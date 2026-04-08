#!/bin/bash

models=("gpt-4.1-2025-04-14" "o3-2025-04-16")

PYTHON="conda run --no-capture-output -n sara python"
OUT_DIR="openai"
API_KEY="<YOUR_API_KEY>" # Personal
BASE_URL="https://api.openai.com/v1/"

RANKING_FILE="./out/rank_k_parsed_o4_mini.json"
STATUTES_PATH="./sara_v2/statutes"
CASES_PATH="./sara_v2/cases"


for model in "${models[@]}"; do
    echo "Running ${model}"
    $PYTHON scripts/generate_e2e.py --statutes-path $STATUTES_PATH --cases-path $CASES_PATH --output-path out/${OUT_DIR}/${model} --api-base-url $BASE_URL --api-key $API_KEY --num-generations 2 --ranking-file $RANKING_FILE  --model-name $model --task prolog

    $PYTHON scripts/process_generated_prolog.py --llm-output out/${OUT_DIR}/${model}/prolog.json --save-dir ./sara_v2/synth/${model}

    $PYTHON scripts/generate_e2e.py --statutes-path $STATUTES_PATH --cases-path $CASES_PATH --output-path out/${OUT_DIR}/${model} --api-base-url $BASE_URL --api-key $API_KEY --num-generations 2  --model-name $model --task standalone

    $PYTHON scripts/process_generated_prolog.py --llm-output out/${OUT_DIR}/${model}/standalone_prolog.json --save-dir ./standalone_prolog/${model} --standalone

    $PYTHON scripts/generate_e2e.py --statutes-path $STATUTES_PATH --cases-path $CASES_PATH --output-path out/${OUT_DIR}/${model} --api-base-url $BASE_URL --api-key $API_KEY --num-generations 2  --model-name $model --task direct
done