#!/bin/bash
rm -rf ~/.config/rhasspy/profiles/en/deepspeech
mkdir -p ~/.config/rhasspy/profiles/en/deepspeech
mkdir -p ~/.config/rhasspy/profiles/en/deepspeech/models
wget 'https://github.com/mozilla/DeepSpeech/releases/download/v0.9.0/deepspeech-0.9.0-models.tflite' -O ~/.config/rhasspy/profiles/en/deepspeech/models/output_graph.tflite
wget 'https://github.com/mozilla/DeepSpeech/releases/download/v0.9.0/deepspeech-0.9.0-models.scorer' -O ~/.config/rhasspy/profiles/en/deepspeech/models/kenlm.scorer
wget 'https://github.com/mozilla/DeepSpeech/raw/master/data/alphabet.txt' -O ~/.config/rhasspy/profiles/en/deepspeech/models/alphabet.txt

sudo rm -rf /opt/rhasspy-asr-deepspeech
sudo rm -rf /opt/rhasspy-asr-deepspeech-hermes

#get rhasspy-asr-deepspeech and rhasspy-asr-deepspeech-hermes repository
sudo git clone https://github.com/Sh4der/rhasspy-asr-deepspeech /opt/rhasspy-asr-deepspeech
sudo git clone https://github.com/Sh4der/rhasspy-asr-deepspeech-hermes /opt/rhasspy-asr-deepspeech-hermes

#change ownerships
sudo chown -R pi:pi /opt/rhasspy-asr-deepspeech
sudo chown -R pi:pi /opt/rhasspy-asr-deepspeech-hermes

#download tar.gz
wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/tools/deepspeech_train_tools.tar.gz -O /opt/rhasspy-asr-deepspeech-hermes/deepspeech_train_tools.tar.gz
tar xvfz /opt/rhasspy-asr-deepspeech-hermes/deepspeech_train_tools.tar.gz -C /opt/rhasspy-asr-deepspeech-hermes
rm /opt/rhasspy-asr-deepspeech-hermes/deepspeech_train_tools.tar.gz

sudo apt install llvm libfst-tools libngram-tools libboost-all-dev -y

#create virtual environment and enter it
mkdir -p /opt/rhasspy-asr-deepspeech-hermes/.venv
virtualenv -p python3 /opt/rhasspy-asr-deepspeech-hermes/.venv
source /opt/rhasspy-asr-deepspeech-hermes/.venv/bin/activate

pip install /opt/rhasspy-asr-deepspeech/
pip install /opt/rhasspy-asr-deepspeech-hermes/
pip install progressbar2==3.47.0

pip install /opt/rhasspy-asr-deepspeech-hermes/tools/packages/*.whl

sudo ln /opt/rhasspy-asr-deepspeech-hermes/bin/rhasspy-asr-deepspeech-hermes /usr/bin/rhasspy-asr-deepspeech-hermes

#add rhasspy-asr-deepspeech-hermes to systemd for autostart
sudo wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/scripts/rhasspy-asr-deepspeech-hermes.service -O /etc/systemd/system/rhasspy-asr-deepspeech-hermes.service
sudo systemctl enable rhasspy-asr-deepspeech-hermes.service
sudo systemctl start rhasspy-asr-deepspeech-hermes.service

#leave virtual environment
deactivate

echo "$(tput setaf 2)DONE! Please check if there are any errors during installation! $(tput sgr 0)"


