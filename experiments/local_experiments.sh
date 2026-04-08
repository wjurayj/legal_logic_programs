#!/bin/bash

# Run these experiments targeting a local vLLM server API.

# models=("deepseek-ai/DeepSeek-R1-Distill-Llama-70B")
# models=("meta-llama/Llama-3.3-70B-Instruct")
# models=("deepseek-ai/DeepSeek-R1-Distill-Qwen-32B")
models=("Qwen/Qwen2.5-Coder-32B-Instruct")



PYTHON="conda run --no-capture-output -n sara python"
OUT_DIR="local"


RANKING_FILE="./out/rank_k_parsed_o4_mini.json"
STATUTES_PATH="./sara_v2/statutes"
CASES_PATH="./sara_v2/cases"


for model in "${models[@]}"; do
    # echo "$model"
    $PYTHON scripts/generate_e2e.py --statutes-path $STATUTES_PATH --cases-path $CASES_PATH --output-path out/${OUT_DIR}/${model} --num-generations 2 --ranking-file $RANKING_FILE  --model-name $model --task prolog

    $PYTHON scripts/process_generated_prolog.py --llm-output out/${OUT_DIR}/${model}/prolog.json --save-dir ./sara_v2/synth/${model}_ranked

    $PYTHON scripts/generate_e2e.py --statutes-path $STATUTES_PATH --cases-path $CASES_PATH --output-path out/${OUT_DIR}/${model} --num-generations 2  --model-name $model --task standalone

    $PYTHON scripts/process_generated_prolog.py --llm-output out/${OUT_DIR}/${model}/standalone_prolog.json --save-dir ./standalone_prolog/${model} --standalone

    $PYTHON scripts/generate_e2e.py --statutes-path $STATUTES_PATH --cases-path $CASES_PATH --output-path out/${OUT_DIR}/${model} --num-generations 2  --model-name $model --task direct
done