import sys
sys.path.append("..")

from utils import load_tax_cases
import pandas as pd
from statistics import mode, mean
from math import exp
import re
import json
import scipy.stats as sh
import numpy as np

def get_mode(lst):
    try:
        return mode(lst)
    except:
        return lst[0]  # If multiple modes, return the first element

def load_json(json_file_path):
    with open(json_file_path, "r") as f:
        data = json.load(f)
    return data

def extract_boxed_text(text):
    pattern = r"\\boxed\{(.*?)\}"
    try:

        ret = re.findall(pattern, text)[0]
    except:
        return -1
    acceptable_characters = "0123456789."
    cleaned = "".join(c for c in ret if c in acceptable_characters)
    if cleaned == "":
        return -1
    return cleaned


def load_e2e_output(json_file_path):
    with open(json_file_path, "r") as f:
        data = json.load(f)
    for item in data:
        item['tax_result_list'] = [float(extract_boxed_text(answer)) for answer in item['answers']]

    e2e_df = pd.DataFrame(data)
    e2e_df.label = e2e_df.label.astype(float)
    return e2e_df[['label', 'prompt_tokens', 'generated_tokens', 'tax_result_list']]


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
                # print(len(current_text))
                return aggregation_function(t['logprob'] for t in remaining_tokens)
    
    return float('inf')  # Marker not found



def transform_case_string(case_str):
    """Removes the _<digits> part just before .pl"""
    # Use regex to find and remove '_<digits>' right before '.pl'
    return re.sub(r'_\d+(?=\.pl$)', '', case_str)


def parse_prolog_output(text_file_path, logprobs=False, cases_dir="/home/wjurayj1/src/sara/sara_v2/cases"):
    if cases_dir:
        data = load_tax_cases(cases_dir)
        input_df = pd.DataFrame(data)

    with open(text_file_path, "r") as f:
        # Read lines one-by-one and apply filter
        relevant_keywords = {"tax_case", "Tax result", "Label", "Confidence"}
        filtered_lines = []
        for line in f:
            line = line.strip()
            if any(keyword in line for keyword in relevant_keywords):
                filtered_lines.append(line)
        data = "\n".join(filtered_lines).replace("1 ?- ", "\n")

    lines = [line for line in data.strip().splitlines() if line]

    parsed_data = []
    i = 0
    num_lines = len(lines)

    case_pattern = re.compile(r"^(tax_case_\d+_\d+\.pl)$")
    unindexed_case_pattern = re.compile(r"^(tax_case_\d+\.pl)$")

    tax_result_pattern = re.compile(r"^Tax result:\s*([\d\.]+)$")

    label_pattern = re.compile(r"^Label:\s*(\d+)$")
    avg_confidence_pattern = re.compile(r"^Average Confidence:\s*(\d\.?\d+)$")
    min_confidence_pattern = re.compile(r"^Minimum Confidence:\s*(\d\.?\d+)$")

    while i < num_lines:
        # 1. Look for a case path line
        case_match = case_pattern.match(lines[i].split("/")[-1])
        if case_match:
            current_case_path = case_match.group(1)
            case_match = False

            current_tax_result = -1  # Default value
            current_label = -2 # None
            current_confidence = 0
            # i += 1 # Move index to the next line
            while (not case_match) and (i < num_lines - 1):
                i += 1 # Move index to the next line

            # 2. Check if the *next* line is Tax result
                tax_match = tax_result_pattern.match(lines[i])
                if tax_match:
                    current_tax_result = float(tax_match.group(1))
                    # i += 1 # Move index past the tax result line

            # 3. Check if the *next* line (which might be immediately after case or after tax) is Label
            # elif i < num_lines:
                label_match = label_pattern.match(lines[i])
                if label_match:
                    current_label = int(label_match.group(1))
                    # i += 1 # Move index past the label line

            # elif i < num_lines:
                avg_confidence_match = avg_confidence_pattern.match(lines[i])
                if avg_confidence_match:
                    current_avg_confidence = float(avg_confidence_match.group(1))
                    # i += 1 # Move index past the label line

            # elif i < num_lines:
                min_confidence_match = min_confidence_pattern.match(lines[i])
                if min_confidence_match:
                    current_min_confidence = float(min_confidence_match.group(1))
                    # i += 1 # Move index past the label line
            
            # elif i < num_lines:
                case_match = case_pattern.match(lines[i].split("/")[-1])
            # 4. Store the result if we found a label
            # if current_label is not None: #TODO: fix this for when we put the label first
            if case_match or (i == num_lines - 1):
                entry = {
                    "case": current_case_path,
                    "tax_result": current_tax_result,
                    "label": current_label,
                }
                if logprobs:
                    entry["min_confidence"] = current_min_confidence,
                    entry["avg_confidence"] = current_avg_confidence

                parsed_data.append(entry)
                # i += 1
                if i == num_lines - 1:
                    break
            else:
                print(f"Warning: Found case '{current_case_path}' but no corresponding Label line followed.")

        else:
            i += 1
        # print(i)

    prolog_df = pd.DataFrame(parsed_data)
    prolog_df['case_index'] = prolog_df['case'].str.split("_").str[-2].str.split(".").str[0].astype(int)
    prolog_df = prolog_df.sort_values("case_index").reset_index()

    # Group by 'case_index' and apply aggregation rules
    # 'case': Apply the transformation to the first element in each group
    # 'tax_result': Aggregate into a list
    grouped_df = prolog_df.groupby('case_index').agg(
        case=('case', lambda x: transform_case_string(x.iloc[0])), # Apply transform to the first case string in the group
        tax_result_list=('tax_result', list), # Aggregate tax_result into a list
        label=('label', lambda x: x.iloc[0])
    ).sort_values('case_index').reset_index() # Reset index to make 'case_index' a column again

    if cases_dir:
        grouped_df['label'] = input_df['label'] # import label directly from cases because they are 

    return grouped_df


def calculate_cost(df, prediction_column="prediction"):
    df = df.copy()
    df['underpayment'] = df['label'] - df[prediction_column]
    total_cost = 0
    for i, row in df.iterrows():

        triggering_underpayment = max(5000, row.label * 0.1)
        if row.underpayment < 0:
            total_cost -= row.underpayment
        elif row.underpayment > triggering_underpayment:
            total_cost += 0.2 * row.underpayment
    return total_cost


def calculate_cost_error(df, prediction_column="prediction", abstention_fee=270, confidence=0.9):
    df = df.copy()
    df['underpayment'] = df['label'] - df[prediction_column]
    costs = []
    for i, row in df.iterrows():

        triggering_underpayment = max(5000, row.label * 0.1)
        if row.underpayment < 0:
            costs.append(-row.underpayment)
        elif row.underpayment > triggering_underpayment:
            costs.append(0.2 * row.underpayment)
        else:
            costs.append(0)
    costs = costs + [abstention_fee] * (100 - len(costs))
    mu = np.mean(costs)
    interval = sh.t.interval(confidence=confidence, df=len(costs)-1,
loc=mu, scale=sh.sem(costs))

    return interval

def format_as_currency(amount):
    """Convert a float to a dollar amount string with proper formatting."""
    if amount < 0:
        return f"-${abs(amount):,.2f}"
    return f"${amount:,.2f}"