#!/bin/bash

models=("deepseek-chat") # "deepseek-reasoner") # as of 2025-07-15, deepseek-chat points to 
# models=("deepseek-reasoner")


PYTHON="conda run --no-capture-output -n sara python"
OUT_DIR="deepseek"
API_KEY="<YOUR_API_KEY>"
API_BASE_URL="https://api.deepseek.com/v1"
MODEL_ALIAS="deepseek-ai/DeepSeek-V3"

for model in "${models[@]}"; do
    echo "$model"

    $PYTHON scripts/generate_e2e.py --statutes-path /home/wjurayj1/src/sara/sara_v2/statutes --cases-path /home/wjurayj1/src/sara/sara_v2/cases --output-path out/${OUT_DIR}/${MODEL_ALIAS} --api-base-url $API_BASE_URL --api-key $API_KEY --num-generations 2 --ranking-file /home/wjurayj1/src/sara/out/rank_k_parsed_o4_mini.json  --model-name $model --task prolog

    $PYTHON scripts/process_generated_prolog.py --llm-output out/${OUT_DIR}/${MODEL_ALIAS}/prolog.json --save-dir ./sara_v2/synth/${MODEL_ALIAS}_ranked

    $PYTHON scripts/generate_e2e.py --statutes-path /home/wjurayj1/src/sara/sara_v2/statutes --cases-path /home/wjurayj1/src/sara/sara_v2/cases --output-path out/${OUT_DIR}/${MODEL_ALIAS} --api-base-url $API_BASE_URL --api-key $API_KEY --num-generations 2  --model-name $model --task standalone 

    $PYTHON scripts/process_generated_prolog.py --llm-output out/${OUT_DIR}/${MODEL_ALIAS}/standalone_prolog.json --save-dir ./standalone_prolog/${MODEL_ALIAS} --standalone

    $PYTHON scripts/generate_e2e.py --statutes-path /home/wjurayj1/src/sara/sara_v2/statutes --cases-path /home/wjurayj1/src/sara/sara_v2/cases --output-path out/${OUT_DIR}/${MODEL_ALIAS} --api-base-url $API_BASE_URL --api-key $API_KEY --num-generations 2  --model-name $model --task direct 
done



models=("deepseek-ai/DeepSeek-R1-0528-tput")

API_KEY="<YOUR_API_KEY>"
API_BASE_URL="https://api.together.xyz/v1"

RANKING_FILE="./out/rank_k_parsed_o4_mini.json"
STATUTES_PATH="./sara_v2/statutes"
CASES_PATH="./sara_v2/cases"


for model in "${models[@]}"; do
    echo "$model"
    echo "few-shot prolog"
    $PYTHON scripts/generate_e2e.py --statutes-path $STATUTES_PATH --cases-path $CASES_PATH --output-path out/${OUT_DIR}/${model} --api-base-url $API_BASE_URL --api-key $API_KEY --num-generations 2 --ranking-file $RANKING_FILE  --model-name $model --task prolog


    $PYTHON scripts/process_generated_prolog.py --llm-output out/${OUT_DIR}/${model}/prolog.json --save-dir ./sara_v2/synth/${model}_ranked

    echo "direct solving"
    $PYTHON scripts/generate_e2e.py --statutes-path $STATUTES_PATH --cases-path $CASES_PATH --output-path out/${OUT_DIR}/${model} --api-base-url $API_BASE_URL --api-key $API_KEY --num-generations 2  --model-name $model --task direct

    echo "stand alone prolog"
    $PYTHON scripts/generate_e2e.py --statutes-path $STATUTES_PATH --cases-path $CASES_PATH --output-path out/${OUT_DIR}/${model} --api-base-url $API_BASE_URL --api-key $API_KEY --num-generations 2  --model-name $model --task standalone

    $PYTHON scripts/process_generated_prolog.py --llm-output out/${OUT_DIR}/${model}/standalone_prolog.json --save-dir ./standalone_prolog/${model} --standalone

done