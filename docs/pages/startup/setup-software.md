---
layout: default
parent: Startup
title: Setup Software
nav_order: 2
---

# Setup Software

You need to install some software:
* Docker
* Rhasspy
* ac108 codec
* MQTT-Server and Node-RED
* Zigbee2MQTT
* Optionally Hermes Led Control

Login to your Raspberry Pi and solve the following steps.

## 1. Docker
Docker is the easiest way to work with Rhasspy. Follow the steps to install docker.

### Install Docker 
`curl -sSL https://get.docker.com | sh`

### Add pi to usergroup
`sudo usermod -aG docker pi` 

### Reboot
`sudo reboot`

## 2. Install Rhasspy
To install Rhasspy pull the docker image with the command

`docker pull rhasspy/rhasspy`

This may take a while.

### Run Rhasspy docker image
Run the Rhasspy docker image with the command

```
docker run -d -p 12101:12101 \
      --name rhasspy \
      --restart unless-stopped \
      -v "$HOME/.config/rhasspy/profiles:/profiles" \
      -v "/etc/localtime:/etc/localtime:ro" \
      --device /dev/snd:/dev/snd \
      rhasspy/rhasspy \
      --user-profiles /profiles \
      --profile en
```

Have a look to more [useful docker commands](/pages/knowledge/docker)

### Finished!

Rhasspy is now accessable at the IP of your Raspberry PI under port 12101. http://<ip-adress>:12101. Test it!

## 1. Configure Audio
### Install ac108 codec

//TODO: Wofür wird der Codec gebraucht?
Install the ac108 codec on your RPI. Copy and paste the commands to your console. 

#### Update and upgrade Raspberry pi
`sudo apt-get update`
`sudo apt-get upgrade -y`

This may take a while.

#### Go back to pi's home directory
`cd ~`

#### Clone seeed-voicecard
`git clone https://github.com/respeaker/seeed-voicecard.git`

#### Change directory
`cd seeed-voicecard`

#### Install seeed-voicecard
`sudo ./install.sh`

#### Reboot
`sudo reboot`

//TODO: Warum müssen wir die Config anpassen?
The driver should now be installed. 

### Edit asound config
Next you need to edit the file ``/etc/asound.conf``.

Use nano or any editor: ``sudo nano /etc/asound.conf``

Edit `pcm.!default`:
1. change `type asym` to `type pulse`
2. add `hint.description "Default Audio Device"` 

Add this code:
 
```bash
ctl.!default {
    type pulse
}
```

The file ``/etc/asound.conf`` should now look like this:

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

## 2. Install a MQTT-Server and Node-RED

First you need to execute this script to update Node.js and install Node-RED.

### Install Mosquitto and Mosquitto-Clients:
`sudo apt-get install mosquitto mosquitto-clients -y`

### Download Script to update Node.js and install Node-RED:
`wget https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered`

### Make the downloaded file executable:
`sudo chmod 755 ./update-nodejs-and-nodered`

### Execute the file:
`./update-nodejs-and-nodered`

#### Notes:
* You will be asked some questions. Always answer with y (for YES)
* Wait until the script is done
* If you get the message "rm: cannot remove '/usr/bin/update-nodejs-and-nodered': No such file or directory" 
the folder could be in your actually location. You can delete the folder by yourself.

### Enable Node-RED at boot 
To start Node-RED at boot execute `sudo systemctl enable nodered.service`.

Now start Node-RED with `sudo systemctl start nodered.service` or restart your Raspberry Pi.

### Finished!

The NodeRed server is now accessable at the IP of your Raspberry PI under port 1880. http://<ip-adress>:1880. Test it!

## 3. Install Zigbee2MQTT

To install Zigbee2MQTT follow this script:

### Clone Zigbee2MQTT repository
`sudo git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt`

### Set rights to user pi
`sudo chown -R pi:pi /opt/zigbee2mqtt`

### Enter folder
`cd /opt/zigbee2mqtt`

### Install python env
`python3 -m venv .`

### Activate environment
`source /opt/zigbee2mqtt/bin/activate`

### Upgrade pip, wheel and setuptools
`pip install --upgrade pip wheel setuptools`

### Install node environment
`pip install nodeenv`

### Init node environment
`nodeenv -p -n 10.15.1`

### Deactivate and activate environment to be sure
`deactivate`
`source /opt/zigbee2mqtt/bin/activate`

### Install dependencies
`cd /opt/zigbee2mqtt`
`npm ci`

### Deactivate environment
Enter `deactivate` to deactivate the environment.

### Start and test Zigbee2MQTT
//TODO: Hinweis auf https://mqtt-explorer.com

Start Zigbee2MQTT and test if the connection works.

#### Enter folder
`cd /opt/zigbee2mqtt`

#### Activate environment
`source /opt/zigbee2mqtt/bin/activate`

#### Start
`npm start`

Now you can turn on and off your Zigbee device to see if everything works.
An output could look like this:

```bash
...
Zigbee2MQTT:info  2020-11-17 11:32:44: MQTT publish: topic 'zigbee2mqtt/0x00158d000520f47d', payload '{"brightness":255,"color_temp":153,"linkquality":118,"state":"ON"}'
...
```

#### Quit
Press ctrl + c to quit.

#### Deactivate environment
Enter `deactivate` to deactivate the environment.

### Enable Zigbee2MQTT at boot
To start zigbee2mqtt at boot create a service:
 
Execute `sudo nano /etc/systemd/system/zigbee2mqtt.service` and copy and paste the following content: 

```
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

## 4. Optional install Hermes Led Control for Respeaker Leds

Hermes Led Control controls the leds of the respeaker device. For example, when you say the wake word, the leds turn on.
With this setting you always can see when the respeaker is active.

### Go back to pi's home directory
`cd ~`

### Download script
`wget https://gist.githubusercontent.com/Psychokiller1888/a9826f92c5a3c5d03f34d182fda1ce4c/raw/cbb53252dd55dc4e9f5f6064a493f0981cf133fb/hlc_download.sh`

### Make the script executable
`sudo chmod +x hlc_download.sh`

###  Execute the script
`sudo ./hlc_download.sh`

Answer the questions like following:
* What assistant engine are you using? Enter 2 for rhasspy
* What's the path to your assistant config file? Press Enter 
(Path Should be like _.config/rhasspy/profiles/de/profile.json_)
* What device do you wish to control with SLC? Enter 2 for respeaker4
* What pattern do you want to use? Enter 5 for custom
* Do you need to install / configure your respeaker4? Enter 2 for no 

[Read more about Hermes Led Control](https://github.com/project-alice-assistant/HermesLedControl/wiki){:target="_blank"}


//TODO test leds?
