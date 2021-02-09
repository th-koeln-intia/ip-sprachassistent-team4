#!/bin/bash

sudo mkdir /opt/rhasspy-snips-nlu-hermes
sudo chown pi:pi /opt/rhasspy-snips-nlu-hermes
virtualenv -p python3 /opt/rhasspy-snips-nlu-hermes
source /opt/rhasspy-snips-nlu-hermes/bin/activate

# Install rustc
sudo apt install rustc -y

# Install Setuptools plugin for Rust extensions
pip3 install setuptools-rust

# Do Snips-NLU rebirth
sudo apt install libatlas3-base libgfortran5

wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/scipy-1.3.3-cp37-cp37m-linux_armv7l.whl?raw=true -P $HOME/snips-nlu
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/scikit_learn-0.22.1-cp37-cp37m-linux_armv7l.whl?raw=true -P $HOME/snips-nlu
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/snips_nlu_utils-0.9.1-cp37-cp37m-linux_armv7l.whl?raw=true -P $HOME/snips-nlu
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/snips_nlu_parsers-0.4.3-cp37-cp37m-linux_armv7l.whl?raw=true -P $HOME/snips-nlu
wget --content-disposition https://github.com/jr-k/snips-nlu-rebirth/blob/master/wheels/snips_nlu-0.20.2-py3-none-any.whl?raw=true -P $HOME/snips-nlu

pip install $HOME/snips-nlu/scipy-1.3.3-cp37-cp37m-linux_armv7l.whl
pip install $HOME/snips-nlu/scikit_learn-0.22.1-cp37-cp37m-linux_armv7l.whl
pip install $HOME/snips-nlu/snips_nlu_utils-0.9.1-cp37-cp37m-linux_armv7l.whl
pip install $HOME/snips-nlu/snips_nlu_parsers-0.4.3-cp37-cp37m-linux_armv7l.whl
pip install $HOME/snips-nlu/snips_nlu-0.20.2-py3-none-any.whl

# Install rhasspy-snips-nlu-hermes
pip install rhasspy-snips-nlu-hermes

# Download language de
snips-nlu download de

# Create dirs for snips engine
mkdir -p ~/.config/rhasspy/profiles/de/snips
mkdir -p ~/.config/rhasspy/profiles/de/snips/engine

# Download and start rhasspy-snips-nlu-hermes service
sudo wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/scripts/rhasspy_snips_nlu_hermes_venv_de.service -O /etc/systemd/system/rhasspy-snips-nlu-hermes.service

sudo systemctl daemon-reload
sudo systemctl enable rhasspy-snips-nlu-hermes.service
sudo systemctl start rhasspy-snips-nlu-hermes.service

# Remove wheels
rm -R $HOME/snips-nlu
deactivate