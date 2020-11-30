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
