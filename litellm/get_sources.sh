#!/bin/bash

python3.13 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install litellm[proxy]==1.68.1
deactivate
