import os
import re
import json
import sys

from utils import load_tax_cases

from tqdm import tqdm
from openai import OpenAI
from tenacity import retry, stop_after_attempt, wait_random_exponential # for exponential backoff

@retry(wait=wait_random_exponential(min=1, max=60), stop=stop_after_attempt(6))
def chat_completion_with_backoff(client, **kwargs):
    return client.chat.completions.create(**kwargs)



OPENAI_BASE_URL = "https://api.openai.com/v1/"
OPENAI_API_KEY = "<YOUR_API_KEY>"
RERANKER_MODEL_NAME = "o4-mini-2025-04-16"


RANK_K_PROMPT = """
Determine a ranking of the passages based on how relevant they are to the query. 
If the query is a question, how relevant a passage is depends on how well it answers the question. 
If not, try analyze the intent of the query and assess how well each passage satisfy the intent. 
The query may have typos and passages may contain contradicting information. 
However, we do not get into fact-checking. We just rank the passages based on they relevancy to the query. 

Sort them from the most relevant to the least. 
Answer with the passage number using a format of `[3] > [2] > [4] = [1] > [5]`. 
Ties are acceptable if they are equally relevant. 
I need you to be accurate but overthinking it is unnecessary.
Output only the ordering without any other text.

Query: {query}

{docs}
"""

def format_rank_k(query, documents):
    return RANK_K_PROMPT.format(query=query, docs="\n\n".join([f"[{i+1}] {document}" for i, document in enumerate(documents)]))


def parse_ranking(text: str, case_index: int = None):
    """Return a list of equivalence classes from a ranking string like
       “[3] > [2] > [4] = [1] > [5] …”.

    Each sub-list contains the tied items (ints) for that rank,
    ordered as they appear.

    If case_index is provided, increase every number >= case_index by 1.
    """
    classes = []
    for block in text.split('>'):  # ‘>’ separates rank levels
        nums = list(map(int, re.findall(r'\[(\d+)\]', block)))
        if case_index is not None:
            nums = [n + 1 if n >= case_index else n for n in nums]
        if nums:
            classes.append(nums)  # ‘=’ keeps items in same class
    return classes

def top_k_from_parsed(parsed_ranking, k):
    return [x for xs in parsed_ranking for x in xs][:k]

def main():
    CASES_PATH = "./sara_v2/cases"
    tax_cases = load_tax_cases(CASES_PATH)
    for i, tax_case in tqdm(list(enumerate(tax_cases))):
        query = tax_case['text']
        documents = [precedent['text'] for j, precedent in enumerate(tax_cases) if j != i]
        prompt = format_rank_k(query, documents)
        messages = [
            # {"role": "system", "content": "You are Qwen, created by Alibaba Cloud. You are a helpful assistant."},
            {"role": "system", "content": "You are a helpful assistant trained to conduct statutory reasoning"},
            {"role": "user", "content": prompt}
        ]
        client = OpenAI(
            base_url=OPENAI_BASE_URL,
            api_key=OPENAI_API_KEY
        )

        response = chat_completion_with_backoff(
            client,
            model=RERANKER_MODEL_NAME,
            n=1,
            messages=messages
        )
        output = response.choices[0].message.content
        tax_case['rank_k_output'] = output
        tax_case['generated_tokens'] = response.usage.completion_tokens
        tax_case['prompt_tokens'] = response.usage.prompt_tokens
        tax_case['reasoning_tokens'] = response.usage.completion_tokens_details.reasoning_tokens

    try:
        for i, datum in enumerate(tax_cases):
            datum['rank_k_parsed'] = parse_ranking(datum['rank_k_output'], case_index=i+1)
    except e:
        print("at least one language model output was mal-formed")

    OUT_DIR = "./out"
    os.makedirs(OUT_DIR, exist_ok=True)
    with open(os.path.join(OUT_DIR, "rank_k_o4_mini.json"), "w", encoding="utf-8") as f:
        json.dump(tax_cases, f, ensure_ascii=False, indent=2)


if __name__ == "__main__":
    main()