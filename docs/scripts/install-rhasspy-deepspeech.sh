#!/bin/bash

mkdir ~/.config/rhasspy/profiles/de/deepspeech
mkdir ~/.config/rhasspy/profiles/de/deepspeech/models
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1lyOFCfrxiTwXotmeWs1hdm_Amg3J_y1T' -O ~/.config/rhasspy/profiles/de/deepspeech/models/output_graph.tflite
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mrfMSYp_mYrsLswttY_fvfAHaJ7azahC' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1mrfMSYp_mYrsLswttY_fvfAHaJ7azahC" -O ~/.config/rhasspy/profiles/de/deepspeech/models/kenlm.scorer && rm -rf /tmp/cookies.txt

sudo git clone https://github.com/Sh4der/rhasspy-asr-deepspeech /opt/rhasspy-asr-deepspeech
sudo git clone https://github.com/Sh4der/rhasspy-asr-deepspeech-hermes /opt/rhasspy-asr-deepspeech-hermes
sudo chown -R pi:pi /opt/rhasspy-asr-deepspeech
sudo chown -R pi:pi /opt/rhasspy-asr-deepspeech-hermes
mkdir /opt/rhasspy-asr-deepspeech-hermes/.venv
virtualenv -p python3 /opt/rhasspy-asr-deepspeech-hermes/.venv
source /opt/rhasspy-asr-deepspeech-hermes/.venv/bin/activate
pip install /opt/rhasspy-asr-deepspeech/
pip install /opt/rhasspy-asr-deepspeech-hermes/
sudo ln /opt/rhasspy-asr-deepspeech-hermes/bin/rhasspy-asr-deepspeech-hermes /usr/bin/rhasspy-asr-deepspeech-hermes
sudo wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/docs/scripts/rhasspy-asr-deepspeech-hermes.service -P /etc/systemd/system/
sudo systemctl enable rhasspy-asr-deepspeech-hermes.service
sudo systemctl start rhasspy-asr-deepspeech-hermes.service
deactivate

