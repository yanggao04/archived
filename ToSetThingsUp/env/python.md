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
```

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

## Tools

### openpyxl

Library for reading and operating on `.xlsx` `.xlsm` files.

### scikit-learn (sklearn)

A machine learning library

### TensorFlow

A deep learning library

### Seaborn

Data visualization library. Quick, stylish statistical plots

### Matplotlib

Data visualization library. More precise control.

