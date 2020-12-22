#!/bin/bash
rm -rf ~/.config/rhasspy/profiles/de/deepspeech
mkdir ~/.config/rhasspy/profiles/de/deepspeech
mkdir ~/.config/rhasspy/profiles/de/deepspeech/models
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1lyOFCfrxiTwXotmeWs1hdm_Amg3J_y1T' -O ~/.config/rhasspy/profiles/de/deepspeech/models/output_graph.tflite
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget -N --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mrfMSYp_mYrsLswttY_fvfAHaJ7azahC' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1mrfMSYp_mYrsLswttY_fvfAHaJ7azahC" -O ~/.config/rhasspy/profiles/de/deepspeech/models/kenlm.scorer && rm -rf /tmp/cookies.txt
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1zIvpdJ0YOreg_HwVwoyt_6BEEusH5g4w' -O ~/.config/rhasspy/profiles/de/deepspeech/models/alphabet.txt


sudo rm -rf /opt/rhasspy-asr-deepspeech
sudo rm -rf /opt/rhasspy-asr-deepspeech-hermes
#get rhasspy-asr-deepspeech and rhasspy-asr-deepspeech-hermes repository
sudo git clone https://github.com/Sh4der/rhasspy-asr-deepspeech /opt/rhasspy-asr-deepspeech
sudo git clone https://github.com/Sh4der/rhasspy-asr-deepspeech-hermes /opt/rhasspy-asr-deepspeech-hermes

#change ownerships
sudo chown -R pi:pi /opt/rhasspy-asr-deepspeech
sudo chown -R pi:pi /opt/rhasspy-asr-deepspeech-hermes

#download tar.gz
wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/docs/tools/deepspeech_train_tools.tar.gz -O /opt/rhasspy-asr-deepspeech-hermes/deepspeech_train_tools.tar.gz
tar xvfz /opt/rhasspy-asr-deepspeech-hermes/deepspeech_train_tools.tar.gz -C /opt/rhasspy-asr-deepspeech-hermes
rm /opt/rhasspy-asr-deepspeech-hermes/deepspeech_train_tools.tar.gz

sudo apt install llvm libfst-tools libngram-tools libboost-all-dev -y

#create virtual environment and enter it
mkdir /opt/rhasspy-asr-deepspeech-hermes/.venv
virtualenv -p python3 /opt/rhasspy-asr-deepspeech-hermes/.venv
source /opt/rhasspy-asr-deepspeech-hermes/.venv/bin/activate

pip install /opt/rhasspy-asr-deepspeech/
pip install /opt/rhasspy-asr-deepspeech-hermes/
pip install progressbar2==3.47.0

pip install /opt/rhasspy-asr-deepspeech-hermes/tools/packages/*.whl

sudo ln /opt/rhasspy-asr-deepspeech-hermes/bin/rhasspy-asr-deepspeech-hermes /usr/bin/rhasspy-asr-deepspeech-hermes

#add rhasspy-asr-deepspeech-hermes to systemd for autostart
sudo wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/docs/scripts/rhasspy-asr-deepspeech-hermes.service -O /etc/systemd/system/rhasspy-asr-deepspeech-hermes.service
sudo systemctl enable rhasspy-asr-deepspeech-hermes.service
sudo systemctl start rhasspy-asr-deepspeech-hermes.service

#leave virtual enviroment
deactivate

echo "$(tput setaf 2)DONE! Please check if there are any errors during installation! $(tput sgr 0)"


