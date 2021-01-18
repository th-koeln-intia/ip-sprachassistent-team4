---
layout: default
parent: Manual installation
grand_parent: Startup
title: Setup Software
nav_order: 1
---


<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Setup Software
Login to your Raspberry Pi and solve the following steps.

## 1. Configure Audio
### Install ac108 codec
{: .no_toc }
Your Raspberry Pi needs the ac108 codec to make the Respeaker work.
Copy and paste the commands to your console. 

#### Update and upgrade Raspberry pi
{: .no_toc }
`sudo apt-get update`
`sudo apt-get upgrade -y`

This may take a while.

#### Go to pi's home directory
{: .no_toc }
`cd ~`

#### Clone seeed-voicecard
{: .no_toc }
`git clone https://github.com/respeaker/seeed-voicecard.git`

#### Change directory
{: .no_toc }
`cd seeed-voicecard`

#### Install seeed-voicecard
{: .no_toc }
`sudo ./install.sh`

#### Reboot
{: .no_toc }
`sudo reboot`

The driver should now be installed. 

### Set Default Audio Device
{: .no_toc }
Next you need to edit the file `/etc/asound.conf` to make the Respeaker as your default audio device.

Use nano or any editor: `sudo nano /etc/asound.conf`

Edit `pcm.!default`:
1. change `type asym` to `type pulse`
2. add `hint.description "Default Audio Device"` 

Add this code:
 
```bash
ctl.!default {
    type pulse
}
```

The file `/etc/asound.conf` should now look like this:

```bash
# The IPC key of dmix or dsnoop plugin must be unique
# If 555555 or 666666 is used by other processes, use another one

# use samplerate to resample as speexdsp resample is bad
defaults.pcm.rate_converter "samplerate"

pcm.!default {
    type pulse
    playback.pcm "playback"
    capture.pcm "ac108"
    hint.description "Default Audio Device"
}

pcm.playback {
    type plug
    slave.pcm "hw:ALSA"
}

# pcm.dmixed {
#     type dmix
#     slave.pcm "hw:0,0"
#     ipc_key 555555
# }

pcm.ac108 {
    type plug
    slave.pcm "hw:seeed4micvoicec"
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         # pcm.multiapps {
#     type dsnoop
#     ac108-slavepcm "hw:1,0"
#     ipc_key 666666
# }

ctl.!default {
    type pulse
}
```

### Set output device
{: .no_toc }
To be able to hear the voice output on the speaker, set the 3.5mm jack to default.

```bash
sudo raspi-config
# Select 1 System Options
# Select S2 Audio
# Select 0 Headphones
# Select Finish
```

[Read more about audio configuration here](https://www.raspberrypi.org/documentation/configuration/audio-config.md){:target="_blank"}

### Test mic functionally
{: .no_toc }
Check if the mic is installed correctly:

```bash
arecord -L
```

Please check if there is an ac108 device and a device named `seeed4micvoicec`. 
You can make a test record of 5 seconds with this command:

`arecord -Dac108 -f S32_LE -r 16000 -c 4 -d 5 hello.wav`

Play the command with:

`aplay hello.wav`
    
If you could hear your recording everything works! Great!

## 2. Install a MQTT-Server

Install Mosquitto and Mosquitto-Clients:
`sudo apt-get install mosquitto mosquitto-clients -y`

## 3. Update Node.js and install Node-RED

First you need to download and execute a script to update Node.js and install Node-RED.

#### Go to pi's home directory
{: .no_toc }
`cd ~`

### Download Script to update Node.js and install Node-RED
{: .no_toc }
`wget https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered`

### Make the downloaded file executable
{: .no_toc }
`sudo chmod 755 ./update-nodejs-and-nodered`

### Execute the file
{: .no_toc }
`./update-nodejs-and-nodered`

#### Notes
{: .no_toc }
* You will be asked some questions. Always answer with y (for YES)
* Wait until the script is done
* If you get the message "rm: cannot remove '/usr/bin/update-nodejs-and-nodered': No such file or directory" 
the folder could be in your actually location. You can delete the folder by yourself.

### Enable Node-RED at boot 
{: .no_toc }
To start Node-RED at boot execute `sudo systemctl enable nodered.service`.

Now start Node-RED with `sudo systemctl start nodered.service` or restart your Raspberry Pi.

### Finished!
{: .no_toc }
The NodeRed server is now accessable at the IP of your Raspberry PI under port 1880. http://<ip-adress>:1880. Test it!

## 4. Install Zigbee2MQTT

To install Zigbee2MQTT follow this script:

### Clone Zigbee2MQTT repository
{: .no_toc }
`sudo git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt`

### Set rights to user pi
{: .no_toc }
`sudo chown -R pi:pi /opt/zigbee2mqtt`

### Enter folder
{: .no_toc }
`cd /opt/zigbee2mqtt`

### Install python env
{: .no_toc }
`python3 -m venv .`

### Activate environment
{: .no_toc }
`source /opt/zigbee2mqtt/bin/activate`

### Upgrade pip, wheel and setuptools
{: .no_toc }
`pip install --upgrade pip wheel setuptools`

### Install node environment
{: .no_toc }
`pip install nodeenv`

### Init node environment
{: .no_toc }
`nodeenv -p -n 10.15.1`

### Deactivate and activate environment to be sure
{: .no_toc }
`deactivate`
`source /opt/zigbee2mqtt/bin/activate`

### Install dependencies
{: .no_toc }
`cd /opt/zigbee2mqtt`
`npm ci`

### Deactivate environment
{: .no_toc }
Enter `deactivate` to deactivate the environment.

### Start and test Zigbee2MQTT
{: .no_toc }
Start Zigbee2MQTT and test if the connection works.

Tip: Use the [mqtt explorer](https://mqtt-explorer.com){:target="_blank"} to see incoming messages.

#### Enter folder
{: .no_toc }
`cd /opt/zigbee2mqtt`

#### Activate environment
{: .no_toc }
`source /opt/zigbee2mqtt/bin/activate`

#### Start
{: .no_toc }
`npm start`

Now you can turn on and off your Zigbee device to see if everything works.
An output could look like this:

```bash
...
Zigbee2MQTT:info  2020-11-17 11:32:44: MQTT publish: topic 'zigbee2mqtt/0x00158d000520f47d', payload '{"brightness":255,"color_temp":153,"linkquality":118,"state":"ON"}'
...
```

#### Quit
{: .no_toc }
Press ctrl + c to quit.

#### Deactivate environment
{: .no_toc }
Enter `deactivate` to deactivate the environment.

### Enable Zigbee2MQTT at boot
{: .no_toc }
To start zigbee2mqtt at boot create a service:
 
Execute `sudo nano /etc/systemd/system/zigbee2mqtt.service` and copy and paste the following content: 

```bash
[Unit]
Description=zigbee2mqtt
After=network.target

[Service]
ExecStart=/bin/bash -c 'source /opt/zigbee2mqtt/bin/activate; /opt/zigbee2mqtt/bin/npm start'
WorkingDirectory=/opt/zigbee2mqtt
StandardOutput=inherit
StandardError=inherit
Restart=always
User=pi

[Install]
WantedBy=multi-user.target
```

Enable the new service with `sudo systemctl enable zigbee2mqtt.service`.

Now start the service with `sudo systemctl start zigbee2mqtt.service` or restart your Raspberry Pi.

## 5. Optional install Hermes Led Control for Respeaker Leds

Hermes Led Control controls the leds of the respeaker device. For example, when you say the Wake Word, the leds turn on.
With this setting you always can see when the respeaker is active.

### Go to pi's home directory
{: .no_toc }
`cd ~`

### Download script
{: .no_toc }
`wget https://gist.githubusercontent.com/Psychokiller1888/a9826f92c5a3c5d03f34d182fda1ce4c/raw/cbb53252dd55dc4e9f5f6064a493f0981cf133fb/hlc_download.sh`

### Make the script executable
{: .no_toc }
`sudo chmod +x hlc_download.sh`

###  Execute the script
{: .no_toc }
`sudo ./hlc_download.sh`

Answer the questions like following:
* What assistant engine are you using? Enter 2 for rhasspy
* What's the path to your assistant config file? Press Enter 
(Path Should be like _/home/pi/.config/rhasspy/profiles/de/profile.json_)
* What device do you wish to control with SLC? Enter 2 for respeaker4
* What pattern do you want to use? Choose your prefered Led pattern. For example 1 for google
* Do you need to install / configure your respeaker4? Enter 2 for no 

Later you will configure Rhasspy to work with Hermes Led Control.

[Read more about Hermes Led Control](https://github.com/project-alice-assistant/HermesLedControl/wiki){:target="_blank"}

## 6. Install Rhasspy native

### Go to pi's home directory
{: .no_toc }
`cd ~`

### Download Rhaspy V2.5.7 to
{: .no_toc }
You can get the latest version from [github](https://github.com/rhasspy/rhasspy/releases/){:target="_blank"}

Download with command:
`wget https://github.com/rhasspy/rhasspy/releases/download/v2.5.7/rhasspy_2.5.7_armhf.deb`

### Make the downloaded file executable
{: .no_toc }
Install Rhasspy with command:
`sudo apt install ./rhasspy_2.5.7_armhf.deb -y`

### Edit profile.json
{: .no_toc }
Get the 
Open the profile.json file with the command:

`sudo nano /home/pi/.config/rhasspy/profiles/de/profile.json`

Find the entry "microphone" and change it to:

```json
"microphone": {
  "system": "arecord",
  "arecord": {
    "device": "sysdefault:CARD=seeed4micvoicec"
  }
}
```

### Start Rhasspy
{: .no_toc }
Start Rhasspy and check if rhasspy runs without problems.
`rhasspy --profile de`

If an error occures like `PermissionError: [Errno 13] Permission denied: '/home/pi/.config/rhasspy/profiles/de'`
you need to give your user permission to the folder `/home/pi/.config/rhasspy`

`sudo chown -R pi:pi /home/pi/.config/rhasspy`

### Start Rhasspy as service
{: .no_toc }
Create the file ``/etc/system.d/system/rhasspy.service`` and put the following code inside:
```bash
[Unit]
Description=Rhasspy
After=syslog.target network.target seed-voicecard.service sound.target

[Service]
Type=simple
WorkingDirectory=/home/pi/.config/rhasspy
ExecStart=/bin/bash -lc 'rhasspy --profile de 2>&1 | cat'
User=pi
Group=pi

RestartSec=1
Restart=on-failure

StandardOutput=syslog
StandardError=syslog

SyslogIdentifier=rhasspy

[Install]
WantedBy=multi-user.target
```
[Here is the full file.](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/docs/scripts/rhasspy.service)

Now enable the service:   
``systemctl enable rhasspy``    
And start it with:    
``systemctl start rhasspy``    
You can stop it with:    
``systemctl stop rhasspy``
After saving settings in Rhasspy you need to restart rhasspy manual in the console with the command:
``systemctl restart rhasspy``

## (6). Install Rhasspy with Docker (not recomment)
To install Rhasspy pull the docker image with the command

`docker pull rhasspy/rhasspy`

This may take a while.

### Run Rhasspy docker image
{: .no_toc }
Run the Rhasspy docker image with the command

```bash
docker run -d -p 12101:12101 \
      --name rhasspy \
      --restart unless-stopped \
      -v "$HOME/.config/rhasspy/profiles:/profiles" \
      -v "/etc/localtime:/etc/localtime:ro" \
      --device /dev/snd:/dev/snd \
      rhasspy/rhasspy \
      --user-profiles /profiles \
      --profile de
```

Have a look to more [useful docker commands](/pages/knowledge/docker)


### Finished!
{: .no_toc }
Rhasspy is now accessible at the IP of your Raspberry PI under port 12101. `http://<ip-adress>:12101`. Test it!

## 7. Install Deepspeech 0.7.4

Deepspeech is the Speech To Text program for Rhasspy in this project. You need to install it in a different way than 
the Rhasspy documentation says. Otherwise it will not work.    

### Install choices
{: .no_toc }

You have different choices to install Deepspeech:

* Use the ``install-rhasspy-deepspeech.sh`` script
* Alternative install step-by-step

#### install-rhasspy-deepspeech.sh
{: .no_toc }

You can install Deepspeech with the [install-rhasspy-deepspeech.sh](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/docs/scripts/install-rhasspy-deepspeech.sh)

Download script: 
```
wget -N https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/docs/scripts/install-rhasspy-deepspeech.sh -P $HOME/tmp
```

Make script executable: 
``sudo chmod +x $HOME/tmp/./install-rhasspy-deepspeech.sh``

Execute script: ``$HOME/tmp/./install-rhasspy-deepspeech.sh``

#### Alternative install step-by-step
{: .no_toc }

We are using german pretrained model files for ``deepspech 0.7.4`` from this repository: 
[AASHISHAG/deepspeech-german](https://github.com/AASHISHAG/deepspeech-german).

You need the files ``output_graph.tflite`` and ``kenlm.scorer``. You can download them manually from 
[this google drive folder](https://drive.google.com/drive/folders/1PFSIdmi4Ge8EB75cYh2nfYOXlCIgiMEL).
Save then into the folder ``.config/rhasspy/profiles/de/deepspeech/models/``.

If the folders don't exist, create them:

```
mkdir ~/.config/rhasspy/profiles/de/deepspeech
mkdir ~/.config/rhasspy/profiles/de/deepspeech/models
``` 

You also can download the files with the following commands: 

```
wget -N --no-check-certificate 'https://docs.google.com/uc?export=download&id=1lyOFCfrxiTwXotmeWs1hdm_Amg3J_y1T' -O ~/.config/rhasspy/profiles/de/deepspeech/models/output_graph.tflite
wget -N --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget -N --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1mrfMSYp_mYrsLswttY_fvfAHaJ7azahC' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1mrfMSYp_mYrsLswttY_fvfAHaJ7azahC" -O ~/.config/rhasspy/profiles/de/deepspeech/models/kenlm.scorer && rm -rf /tmp/cookies.txt
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1zIvpdJ0YOreg_HwVwoyt_6BEEusH5g4w' -O ~/.config/rhasspy/profiles/de/deepspeech/models/alphabet.txt
```

Now you need to install a custom version of rhasspy-asr-deepspeech and rhasspy-asr-deepspeech-hermes.

Execute the following commands:
```bash
sudo git clone https://github.com/Sh4der/rhasspy-asr-deepspeech /opt/rhasspy-asr-deepspeech
sudo git clone https://github.com/Sh4der/rhasspy-asr-deepspeech-hermes /opt/rhasspy-asr-deepspeech-hermes
sudo chown -R pi:pi /opt/rhasspy-asr-deepspeech
sudo chown -R pi:pi /opt/rhasspy-asr-deepspeech-hermes

wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/docs/tools/deepspeech_train_tools.tar.gz -O /opt/rhasspy-asr-deepspeech-hermes/deepspeech_train_tools.tar.gz
tar xvfz /opt/rhasspy-asr-deepspeech-hermes/deepspeech_train_tools.tar.gz -C /opt/rhasspy-asr-deepspeech-hermes
rm /opt/rhasspy-asr-deepspeech-hermes/deepspeech_train_tools.tar.gz

sudo apt install llvm libfst-tools libngram-tools

mkdir /opt/rhasspy-asr-deepspeech-hermes/.venv
virtualenv -p python3 /opt/rhasspy-asr-deepspeech-hermes/.venv
source /opt/rhasspy-asr-deepspeech-hermes/.venv/bin/activate

pip install /opt/rhasspy-asr-deepspeech/
pip install /opt/rhasspy-asr-deepspeech-hermes/
pip install progressbar2==3.47.0
pip install /opt/rhasspy-asr-deepspeech-hermes/tools/packages/*.whl

sudo ln /opt/rhasspy-asr-deepspeech-hermes/bin/rhasspy-asr-deepspeech-hermes /usr/bin/rhasspy-asr-deepspeech-hermes

sudo wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/docs/scripts/rhasspy-asr-deepspeech-hermes.service -P /etc/systemd/system/
sudo systemctl enable rhasspy-asr-deepspeech-hermes.service
sudo systemctl start rhasspy-asr-deepspeech-hermes.service
deactivate
```

After going through these commands, you have a service named ``rhasspy-asr-deepspeech-hermes``.

## 8. Install Snips-NLU 

### Install choices
{: .no_toc }

You have different choices to install Snips-NLU:

* Use the ``snips-nlu-install.sh`` script
* Alternative install step-by-step

#### snips-nlu-install.sh
{: .no_toc }

You can install Snips-NLU with the [snips-nlu-install.sh](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/docs/scripts/install-rhasspy-snips-nlu.sh) or with a virtual enviroment [snips-nlu-install_venv.sh](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/docs/scripts/install-rhasspy-snips-nlu_venv.sh)

Change directory to home folder: ``cd $HOME``

Download script: 
```bash
wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/docs/scripts/install-rhasspy-snips-nlu.sh -P $HOME/tmp
```

Make script executable: 
```bash
sudo chmod +x ./snips-nlu-install.sh
```

Execute script: 
```bash
./snips-nlu-install.sh
```

#### Alternative install step-by-step
{: .no_toc }

1. Install Rust: 
   ```bash
   sudo apt install rustc -y
   ```
2. Install Setuptools plugin for Rust extensions:
   ```bash
   pip3 install setuptools-rust
   ```
3. Install Snips-NLU: 
   ```bash
   pip install snips-nlu
   ```
4. Do Snips NLU rebirth

4.1 ``sudo apt install libatlas3-base libgfortran5``

5. Install Rhasspy Snips NLU Hermes ``pip3 install rhasspy-snips-nlu-hermes``

6. Start Client for MQTT-Server ``rhasspy-snips-nlu-hermes --language de --engine-path /home/pi/.config/rhasspy/profiles/de/snips/engine --dataset-path /home/pi/.config/rhasspy/profiles/de/snips/dataset.yaml --host 127.0.0.1 --port 1883``

Resources:
- https://github.com/snipsco/snips-nlu 
- https://github.com/jr-k/snips-nlu-rebirth
- https://rhasspy.readthedocs.io/en/latest/intent-recognition/#snips-nlu

# Setup completed!

Congratulations! You finished the installation of all necessary software. Next you will
 [configure Rhasspy](/pages/startup/configuration).

