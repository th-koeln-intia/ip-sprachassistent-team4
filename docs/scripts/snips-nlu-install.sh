#!/bin/bash

# Install rustc
sudo apt install rustc -y

# Install Setuptools plugin for Rust extensions
pip3 install setuptools-rust

# Install Snips-NLU
pip install snips-nlu

# Do Snips-NLU rebirth
sudo apt install libatlas3-base libgfortran5

cd /home/pi

wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/scipy-1.3.3-cp37-cp37m-linux_armv7l.whl?raw=true
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/scikit_learn-0.22.1-cp37-cp37m-linux_armv7l.whl?raw=true
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/snips_nlu_utils-0.9.1-cp37-cp37m-linux_armv7l.whl?raw=true
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/snips_nlu_parsers-0.4.3-cp37-cp37m-linux_armv7l.whl?raw=true
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/snips_nlu-0.20.2-py3-none-any.whl?raw=true

sudo pip3 install scipy-1.3.3-cp37-cp37m-linux_armv7l.whl
sudo pip3 install scikit_learn-0.22.1-cp37-cp37m-linux_armv7l.whl
sudo pip3 install snips_nlu_utils-0.9.1-cp37-cp37m-linux_armv7l.whl
sudo pip3 install snips_nlu_parsers-0.4.3-cp37-cp37m-linux_armv7l.whl
sudo pip3 install snips_nlu-0.20.2-py3-none-any.whl

snips-nlu download en

mkdir ~/.config/rhasspy/profiles/de/snips
mkdir ~/.config/rhasspy/profiles/de/snips/engine
