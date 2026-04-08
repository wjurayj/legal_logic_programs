#!/usr/bin/env python3

import sys
sys.path.append("..")

import os
import json
import argparse
from typing import List, Dict
from dataclasses import dataclass


from openai import OpenAI
from tqdm import tqdm
from utils import assemble_exemplars, chat_completion_with_backoff
import re
import httpx

logprob_free_models = {
    "o4-mini-2025-04-16",
    "o3-2025-04-16",
    "gpt-5-2025-08-07",
    "gpt-5-chat-latest",
    "deepseek-reasoner",
    "gemini-2.5-pro-preview-06-05",
}

reasoning_models = {
    "o3-2025-04-16",
    "gemini-2.5-pro-preview-06-05",
    "gpt-5-2025-08-07",
    "Qwen/Qwen3-235B-A22B-Thinking-2507"
}

anthropic_models = {
    "claude-sonnet-4-20250514"
}

max_n_1_models = {
    "deepseek-chat"
}

deepseek_models = {
    "deepseek-chat",
    "deepseek-ai/DeepSeek-R1-0528-tput"
}

@dataclass
class Config:
    statutes_path: str
    cases_path: str
    model_name: str
    api_base_url: str
    api_key: str
    output_path: str
    token_budget: int
    debug: bool
    num_generations: int
    temperature: int
    ranking_file: str
    num_exemplars: int
    task: str

def parse_args() -> Config:
    parser = argparse.ArgumentParser(description='Process tax cases using LLM inference')
    parser.add_argument('--statutes-path', required=True, help='Path to statutes directory')
    parser.add_argument('--cases-path', required=True, help='Path to cases directory')
    parser.add_argument('--model-name', default='deepseek-ai/DeepSeek-R1-Distill-Qwen-32B',
                      help='Name of the model to use')
    parser.add_argument('--api-base-url', default='http://localhost:9009/v1',
                      help='Base URL for the API')
    parser.add_argument('--api-key', default='token-abc123',
                      help='API key for authentication')
    parser.add_argument('--output-path', default='out/output.json',
                      help='Path to save output JSON')
    parser.add_argument('--token-budget', type=int, default=10000, help='Token budget for model inference (default: 8000)')
    parser.add_argument('--debug', default=False, action='store_true', help='Only run on a two examples')
    parser.add_argument('--num-generations', type=int, default=1, help='Number of generations to sample')
    parser.add_argument('--temperature', type=int, default=1, help='Temperature to sample at')

    parser.add_argument('--ranking-file', type=str, default=None, help=".json file containing case rankings for each case")
    parser.add_argument('--num-exemplars', type=int, default=5, help='Number of exemplars to provide')
    parser.add_argument('--task', type=str, default="direct", help="indicates the task, out of 'direct', 'prolog', 'standalone'")


    args = parser.parse_args()
    return Config(
        statutes_path=args.statutes_path,
        cases_path=args.cases_path,
        model_name=args.model_name,
        api_base_url=args.api_base_url,
        api_key=args.api_key,
        output_path=args.output_path,
        token_budget=args.token_budget,
        debug=args.debug,
        num_generations=args.num_generations,
        temperature=args.temperature,
        ranking_file=args.ranking_file,
        num_exemplars=args.num_exemplars,
        task=args.task,
    )

def load_statutes(statutes_path: str, events_only: bool=False) -> str:
    """Load and combine all statute files from the given directory."""
    file_texts = []
    try:
        for filename in os.listdir(statutes_path):
            if events_only and (filename != "events.pl"): # remove to add rest of statutes beyond just events
                continue 
            file_path = os.path.join(statutes_path, filename)
            if os.path.isfile(file_path):
                with open(file_path, 'r', encoding='utf-8') as file:
                    file_texts.append(file.read())
        return "\n\n\n\n".join(file_texts)
    except Exception as e:
        raise RuntimeError(f"Error loading statutes: {str(e)}")

def sorted_alphanumeric(data):
    convert = lambda text: int(text) if text.isdigit() else text.lower()
    alphanum_key = lambda key: [ convert(c) for c in re.split('([0-9]+)', key) ] 
    return sorted(data, key=alphanum_key)

def top_k_from_parsed(parsed_ranking, k):
    return [x for xs in parsed_ranking for x in xs][:k]

def load_cases(cases_path: str) -> List[Dict]:
    """Load and parse tax cases from the given directory."""
    cases = []
    try:
        case_files = sorted_alphanumeric([f for f in os.listdir(cases_path) if f.startswith("tax")])
        # case_files = [f for f in os.listdir(cases_path) if f.startswith("tax")]

        for case_file in case_files:
            with open(os.path.join(cases_path, case_file), 'r', encoding='utf-8') as file:
                lines = [line.strip() for line in file if line.startswith("%")]
                case_dict = {}
                for i, line in enumerate(lines):
                    if line == "% Text":
                        case_dict['text'] = lines[i+1].strip("% ")
                    if line == "% Question":
                        question, answer = lines[i+1].strip("% ").split(" $")
                        case_dict['question'] = question
                        case_dict['label'] = answer
                cases.append(case_dict)
        return cases
    except Exception as e:
        raise RuntimeError(f"Error loading cases: {str(e)}")

def compose_prompt_source(statutes: str, case: Dict) -> str:
    """Create a formatted prompt for the model."""
    return (f"Statutes:\n{statutes}\n\n"
            f"Case: {case['text']}\n\n"
            f"Question: {case['question']}\n\n"
            "Answer the question based on the case and statutes above. "
            "Your answer should be a dollar figure. "
            "Indicate your answer using \\boxed{}"
            " Think step-by-step before answering.")

def compose_prompt_standalone_prolog(statutes: str, case: Dict) -> str:
    """Create a formatted prompt for the model."""
    return (f"## Statutes:\n{statutes}\n\n"
            f"## Case: {case['text']}\n\n"
            f"## Question: {case['question']}\n\n"
            "The question above asks about the case in relation to the statutes. "
            "First, write a logic program in prolog to encode the relevant rules defined in the statutes. "
            "Then write a logic program in prolog to encode the facts and rules contained in the case above. "
            "Then write a query to compute and print the value the question asks.\n"
            " Indicate your prolog code using:\n```prolog\n<YOUR_LOGIC_PROGRAM_HERE>\n```\n"
            """ For instance, to answer "How much tax does Samuel owe in 1992", your final lines should be ```prolog:- tax("Samuel", 1992, Tax), format('Tax result: ~w~n', [Tax]).\n:- halt.```"""
            " Follow this format exactly. You will only receive credit if the code you write within this block computes the exact correct tax value."
            " Think step-by-step before answering.")

def compose_prompt_prolog(statutes: str, case: Dict, exemplars="") -> str:
    """Create a formatted prompt for the model."""

    return (f"Statutory Terms:\n{statutes}\n\n"
            f"Examples:\n{exemplars}\n\n"
            f"% Text\n% {case['text']}\n\n"
            f"% Question\n%  {case['question']}\n\n"
            "Write a prolog program that will compute the tax burden for the described case. "
            "Follow the examples given above. Your answer should be a prolog program."
            " These programs follow a neo-Davidsonian structure, with predicates for events defined as descriptive phrases while predicates for individuals are names"
            " Indicate your prolog code using:\n```prolog\n<YOUR_LOGIC_PROGRAM_HERE>\n```\n"
            """ For instance, to answer "How much tax does Samuel owe in 1992", your final lines should be ```prolog:- tax("Samuel", 1992, Tax), format('Tax result: ~w~n', [Tax]).\n:- halt.```"""
            " Copy the example format exactly. If your output does not execute in accordance with the statutes above, you will receive no credit for accurately parsing the cases."
            " Think step-by-step before answering.")
@dataclass
class Logprob:
    token: str
    logprob: float

def process_chat_logprobs(choice):
    """
    takes a chat completion object with logprobs, and returns a list of tokens and their log probs
    """
    if choice.logprobs.content == None:
        choice.logprobs.content = [Logprob(token=token, logprob=logprob) for token, logprob in zip(choice.logprobs.tokens, choice.logprobs.token_logprobs)]
    return list(map(lambda x: {"token": x.token, "logprob": x.logprob}, choice.logprobs.content))

def run_inference(cases: List[Dict], statutes: str, config: Config, prompt_composer=compose_prompt_source) -> List[Dict]:
    """Run model inference on all cases."""
    if config.model_name in anthropic_models:
        client = Anthropic(api_key=config.api_key)
    else:
        long_timeout_client = httpx.Client(timeout=7200)
        client = OpenAI(
            base_url=config.api_base_url,
            api_key=config.api_key,
            http_client=long_timeout_client
        )
    processed_cases = []
    ranking = None
    if config.ranking_file:
        with open(config.ranking_file, "r") as f:
            ranking = json.load(f)
            per_case_exemplars = [assemble_exemplars(ranking, [j-1 for j in top_k_from_parsed(datum['rank_k_parsed'], config.num_exemplars)]) for datum in ranking]
    for i, case_query in tqdm(list(enumerate(cases)), desc="Processing cases"):
        if ranking:
            exemplars = per_case_exemplars[i]
            prompt = prompt_composer(statutes, case_query, per_case_exemplars[i]) #TODO clean this up somehow?
        else:
            prompt = prompt_composer(statutes, case_query)
        processed_case = {
            "text": case_query["text"],
            "question": case_query["question"],
            "label": case_query["label"],
            "prompt": prompt,
        }
        messages = [
            {"role": "system", "content": "You are a helpful assistant trained to conduct statutory reasoning"},
            {"role": "user", "content": prompt}
        ]
        try:
            use_logprobs = config.model_name not in logprob_free_models
            use_reasoning = config.model_name in reasoning_models
            request_args = {
                "client": client,
                "model": config.model_name,
                "n": config.num_generations,
                "messages": messages,
                "temperature": config.temperature,
            }
            if config.model_name in deepseek_models:
                request_args["top_p"] = 0.95
                request_args["temperature"] = 0.7
                request_args["max_tokens"] = 32768
            if use_logprobs:
                request_args["logprobs"] = True
            if use_reasoning:
                request_args["reasoning_effort"] = "medium"
                request_args.pop("temperature", None)
            
            if config.model_name in max_n_1_models:
                request_args["n"] = 1
                n_iters = config.num_generations
            else:
                n_iters = 1
            
            response = None
            for i in range(n_iters):
                if config.debug:
                    request_args.pop("client", None)
                    model_output = client.chat.completions.create(**request_args)
                else:
                    model_output = chat_completion_with_backoff(**request_args)

                if not response:
                    response = model_output
                else:
                    response.choices.extend(model_output.choices)
                    response.usage.completion_tokens += model_output.usage.completion_tokens
                    response.usage.prompt_tokens += model_output.usage.prompt_tokens


            # case_query['prompt'] = prompt
            processed_case['answers'] = [choice.message.content for choice in response.choices]
            if use_logprobs:
                processed_case['token_logprobs'] = [process_chat_logprobs(choice) for choice in response.choices]
            
            processed_case['generated_tokens'] = response.usage.completion_tokens
            processed_case['prompt_tokens'] = response.usage.prompt_tokens

        except Exception as e:
            print(f"Error processing case: {str(e)}")
            processed_case['answers'] = ["ERROR"]
        processed_cases.append(processed_case)

    return processed_cases


def save_results(cases: List[Dict], output_path: str):
    """Save results to JSON file."""
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    try:
        with open(output_path, "w") as f:
            json.dump(cases, f, indent=2)
    except Exception as e:
        raise RuntimeError(f"Error saving results: {str(e)}")

def main():
    config = parse_args()
    # Load data
    statutes_source = load_statutes(
        os.path.join(config.statutes_path, "source"),
        events_only=False
    )
    statutes_prolog = load_statutes(
        os.path.join(config.statutes_path, "prolog"),
        events_only=False
    )
    cases = load_cases(config.cases_path)

    if config.debug:
        cases = cases[:1] # with rankings, this must start from 0

    # Run inference
    if config.task == "prolog":
        cases_prolog = run_inference(cases, statutes_prolog, config, prompt_composer=compose_prompt_prolog)
        save_results(
            cases_prolog,
            os.path.join(config.output_path, 'prolog.json')
        )
    elif config.task == "direct":
        cases_source = run_inference(cases, statutes_source, config, prompt_composer=compose_prompt_source)

        # Save results
        save_results(
            cases_source,
            os.path.join(config.output_path, 'source.json')
        )
    elif config.task == "standalone":
        cases_standalone_prolog = run_inference(cases, statutes_source, config, prompt_composer=compose_prompt_standalone_prolog)
        save_results(
            cases_standalone_prolog,
            os.path.join(config.output_path, 'standalone_prolog.json')
        )
    else:
        print("invalid task:", config.task)

    
    print(f"Processing complete. Results saved to {config.output_path}")
    

if __name__ == "__main__":
    main()
