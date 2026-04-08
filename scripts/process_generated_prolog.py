import json
import os
from statistics import mean
from math import exp
import argparse
import re

parser = argparse.ArgumentParser(description="Process generated Prolog files with logprobs.")
parser.add_argument("--llm-output", type=str, required=True, help="Path to the LLM output JSON file.")
parser.add_argument("--save-dir", type=str, required=True, help="Directory to save processed Prolog files.")
parser.add_argument("--logprobs", action="store_true", default=False, help="Include logprobs in the output if set.")
parser.add_argument("--standalone", action="store_true", default=False, help="Include logprobs in the output if set.")

args = parser.parse_args()

LLM_OUTPUT_FILE = args.llm_output
SAVE_DIR = args.save_dir

with open(LLM_OUTPUT_FILE, "r") as f:
    data = json.load(f)

# First, define the helper function
def clean_token(tok):
    return tok.replace("Ġ", " ").replace("Ċ", "\n")

def get_min_logprob_after_facts(answer, token_logprobs, aggregation_function=min):
    """Get min logprob after '% Facts' marker"""
    current_text = ""
    facts_marker = "% Facts"
    
    for i, token_data in enumerate(token_logprobs):
        current_text += clean_token(token_data['token'])

        # If we just found "% Facts", return min of remaining tokens
        if facts_marker in current_text and i < len(token_logprobs) - 1:
            # Get all tokens after this point
            remaining_tokens = token_logprobs[i+1:]
            if remaining_tokens:
                return aggregation_function(t['logprob'] for t in remaining_tokens)
    
    return float('inf')  # Marker not found


if args.logprobs:
    prologs = [
        [
            (
                re.search(r"```prolog(.*?)```", answer, re.DOTALL).group(1).strip() if re.search(r"```prolog(.*?)```", answer, re.DOTALL) else "" ,
                get_min_logprob_after_facts(answer, token_logprobs, aggregation_function=mean),
                get_min_logprob_after_facts(answer, token_logprobs, aggregation_function=min),
            )
            for answer, token_logprobs in zip(datum['answers'], datum['token_logprobs'])

        ]
        for datum in data
    ]
else:
    prologs = [
        [
            re.search(r"```prolog(.*?)```", answer, re.DOTALL).group(1).strip() if re.search(r"```prolog(.*?)```", answer, re.DOTALL) else "" for answer in datum['answers']
        ]
        for datum in data
    ]

print(len(prologs))
os.makedirs(SAVE_DIR, exist_ok=True)
for i, case_prologs in enumerate(prologs):
    for j, prolog in enumerate(case_prologs):

        if (not args.standalone) and ("[statutes/prolog/init]" not in prolog):
            prolog = "\n:- [statutes/prolog/init]." + prolog

        if args.logprobs:
            replacement_string = f'\n:- format("~w~n", ["Label: {data[i]["label"]}"]).\n:- format("~w~n", ["Average Confidence: {exp(mean_logprob)}"]).\n:- format("~w~n", ["Minimum Confidence: {exp(min_logprob)}"]).\n'

        else:
            replacement_string = f'\n:- format("~w~n", ["Label: {data[i]["label"]}"]).\n'#:- halt.'

        prolog = replacement_string + prolog

        with open(os.path.join(SAVE_DIR, f"tax_case_{i+1}_{j}.pl"), "w+") as f:
            f.write(prolog)