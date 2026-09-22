## Python environment

## Installation

### Official Website

-  download at [python.org](python.org)
-  tick `Add Python to PATH` when installing
-  pip package control is contained inside

### Anaconda/Miniconda

A integrated environment for data science and statistics with built-in package and environment control

### System package manager

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3 python3-pip

# macOS (Homebrew)
brew install python3

# Windows (Chocolatey)
choco install python3
```

### pyenv: Multi-version Python Management

```bash
brew install pyenv

# Optional: to manage virtual environment
brew install pyenv-virtualenv
```

Get the following into `~/.zshrc`

```bash
# Pyenv configs
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"  # enable auto-activation

# If pyenv-virtualenv is installed
eval "$(pyenv virtualenv-init -)"
```

Then we can use the following

```bash
# List all python versions installed
pyenv versions

# List all python versions available for installation
pyenv install --list

# Install/uninstall a version
pyenv install <version>
pyenv uninstall <version>

# Show current python
pyenv which python

# Can use "system" in <version> for version in the system
# Set global default version
pyenv global <version>

# Set local default version for current directory
pyenv local <version>

# Set version for current session
pyenv shell <version>

# Show current active version
pyenv version
```

## Setting up virtual environment

Why?

-  isolate dependency
-  keep system python clean
-  easy to manage and switch

### `venv`

```bash
# Setup a virtual environment (in current folder)
python -m venv env_name

# Activate the environment
# Windows:
env_name\Scripts\activate
# macOS/Linux:
source env_name/bin/activate

# Checking
which python  # shall give python in virtual env

# upgrade pip
python -m pip install --upgrade pip

# exit/deactivate venv
deactivate
```

### `conda`

```bash
# Create new env
conda create -n tensorflow_env python=3.10

# Activate env 
conda activate tensorflow_env

# List all envs
conda env list

# Install packages inside env
conda install pip

# Deactivate
conda deactivate
```

Conda may require `conda init` to load initialization script to the bash profile or zshrc. Use `conda init` or `conda init <shell name>`

### venv management

```bash
# List packages
pip list

# Generate dependencies and requirements
pip freeze > requirements.txt

# Installing from dependency file
pip install -r requirements.txt

# Exit venv
deactivate  # venv
conda deactivate  # conda

# Delete venv
rm -rf tensorflow_env  # venv
conda env remove -n tensorflow_env  # conda
```

## Tips

Can use `PYTHONPATH=<directory>` to specify the directory being executed in.

## Libraries/Packages

### Reading/Writing/Exporting/Importing

`openpyxl`: Library for reading and operating on `.xlsx` `.xlsm` files.
`seaborn`: Data visualization library. Quick, stylish statistical plots
`matplotlib`: Data visualization library. More precise control.

### Data Analysis

`numpy`: data analysis library, dependency of many AI frameworks
`pandas`: data analysis library, DataFrame structure, dealing csv/tables
`scipy`: scientific calulation library, linear algebra, optimisation, stats

### Deep Learning

`tensorflow`: A deep learning library by Google
`torch` (PyTorch) (Popular Choice): A deep learning library by Meta
`keras`: neural network API, can be executed on top of `tensorflow`
`jax` & `jaxlib`: new DL framework by Google, mostly used for research
`tensorboard`: virualise traninig curve, network structure, and embedded vectors

### Hugging Face Ecosystem

`transformers`: pre-trained models like `BERT`, `GPT`, `LLaMA`, etc., out of box
`datasets`: processing datasets for training
`tokenizers`: out-of-box tokenizer
`safetensors`: a safe storage format for tensors
`accelerate`: accelerate training
`huggingface_hub`: used for access to huggingface
`trl`: stands for Transformer Reinforcement Learning. It's a post-training full-stack library.

Some huggingface resources are gated, which require authentication. Install `hugginface_hub` and upload access token from [HuggingFace](https://huggingface.co) through `hf auth login`. (Some resources may require asking for access through HuggingFace website)

### Others

`tqdm`: progress bar, for monitoring loops and iterations
`tqdm` by default outputting on `stderr` to distinguish from `stdout`. 
To redirecting, can do like `for i in tqdm(range(100), file=sys.stdout)`
`scikit-learn` (sklearn): machine learning pack



