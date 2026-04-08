<h1 align="center"><a href="https://arxiv.org/pdf/2508.21051">Language Models and Logic Programs for Trustworthy Tax Reasoning</a></h1>



## Installation
The only required package to run experiments is the OpenAI SDK and tqdm. Several other packages are necessary for plotting. Instructions to set up this environment are below

```bash
## Set up & activate environment
conda create -n sara_parse
conda activate sara_parse

## install necessary packages for running experiments
pip install openai==1.95.1
pip install tqdm==4.67.1

## install necessary packages for plotting.
pip install matplotlib==3.10.3
pip install pandas==2.2.3
pip install numpy==2.2.5
pip install seaborn==0.13.2
```

You will also need an implementation of prolog. We run our experiments using the [SWI-Prolog](https://www.swi-prolog.org/) implementation, which can be installed through the instructions on their site.


## Running Experiments

Scripts for running inference using various inference providers are included in `./scripts/experiments/`. Each script runs through the direct, standalone, and few-shot solution methods for each model.

Note that methods using a prolog interpreter require additional processing steps. The `<PROVIDER>_experiments.sh` script handles a portion of this using a call to `scripts/process_generated_prolog.py`. A secondary step required is to run `bash run_cases_timeout > <OUT_FILE_PATH>.txt`. This should correspond to the file paths that you load in the early cells of `plots.ipynb`.



## Citation

If you found this code or paper helpful, please cite our paper as below:

```
@inproceedings{jurayj2026language,
  title={Language Models and Logic Programs for Trustworthy Tax Reasoning},
  author={Jurayj, William and Holzenberger, Nils and Van Durme, Benjamin},
  booktitle={Proceedings of the AAAI Conference on Artificial Intelligence},
  volume={40},
  number={45},
  pages={38688--38698},
  year={2026}
}
```