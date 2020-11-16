---
layout: default
parent: Startup
---

# Installation Rhasspy

## 0. Install Hardware
   Put the respeaker 4-mic array on the Raspberry Pi (RPI), attach a Network cable, a Monitor, a keyboard to the RPI.

## 1. Install Raspbian
   You need to install Raspbian on your Raspberry Pi (RPI). Here is a good tutorial:
   - https://www.raspberrypi.org/documentation/installation/installing-images/
   We used the desktop version and NOT the light version.
   The Username is ``pi`` and the password is ``raspbarry``

## 2. Configure Audio
### Step 1 
Install the ac108 codec on your RPI:
```bash
sudo apt-get update
sudo apt-get upgrade
git clone https://github.com/respeaker/seeed-voicecard.git
cd seeed-voicecard
sudo ./install.sh  
reboot
```
The driver should now be installed. We also need to edit the ``/etc/asound.conf``.
```
pcm.!default {
type pulse
# If defaults.namehint.showall is set to off in alsa.conf, then this is
# necessary to make this pcm show up in the list returned by
# snd_device_name_hint or aplay -L
hint.description "Default Audio Device"
}
ctl.!default {
type pulse
}
```
### Step 2
Set the 3.5mm jack to default.
```bash
sudo raspi-config
# Select 7 Advanced Options
# Select A4 Audio
# Select 1 Force 3.5mm ('headphone') jack
# Select Finish
```

### Step 3 
Check if the mic is installed correctly:
```bash
arecord -L
```
Please check if there is an ac108 device and a device named seeed4micvoicec. 
You can make a test record with this commands:    
```bash
arecord -Dac108 -f S32_LE -r 16000 -c 4 hello.wav    // only support 4 channels
aplay hello.wav                                      // make sure default device
                                                     // Audio will come out via audio jack of Raspberry Pi
```

## 3. Install a MQTT-Server and Node-Red
```bash
sudo apt-get install mosquitto mosquitto-clients -y
wget https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-andnodered
sudo chmod 755 ./update-nodejs-andnodered
./update-nodejs-andnodered
sudo systemctl enable nodered.service # this command starts nodered  on boot
```
The NodeRed server is now accessable at http://<ip-adress>:1880.

## 4. Install zigbee2mqtt
This is the script to install zigbee2mqtt:
```bash
# Clone Zigbee2MQTT repository
sudo git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt
sudo chown -R pi:pi /opt/zigbee2mqtt

# Enter folder
cd /opt/zigbee2mqtt

# Install python env
python3 -m venv .

# Activate environment
source /opt/zigbee2mqtt/bin/activate

# Upgrade pip, wheel and setuptools
pip install --upgrade pip wheel setuptools

# Install node environment
pip install nodeenv

# Init node environment
nodeenv -p -n 10.15.1

# Deactivate and activate environment to be sure
deactivate
source /opt/zigbee2mqtt/bin/activate

# Install dependencies
cd /opt/zigbee2mqtt
npm ci

# Deactivate environment
deactivate
```
You can start zigbee2mqtt with this commands:
```bash
# Enter folder
cd /opt/zigbee2mqtt

# Activate environment
source /opt/zigbee2mqtt/bin/activate

# Start
npm start

# ctrl + c to quit

# Deactivate environment
deactivate
```
You can add zigbee2mqtt to autostart by creating the file ``/etc/systemd/system/zigbee2mqtt.service`` with the content:
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

## Installing Hermes Led Control for Respeaker Leds
Hermes Led Control controls the leds of the respeaker device. For example, when you say the wake word, the leds turn on.
```
wget https://gist.githubusercontent.com/Psychokiller1888/a9826f92c5a3c5d03f34d182fda1ce4c/raw/cbb53252dd55dc4e9f5f6064a493f0981cf133fb/hlc_download.sh
sudo chmod +x hlc_download.sh
sudo ./hlc_download.sh
```

Go through the menu and type in the answers in order:    
2 -> /home/pi/.config/rhasspy/profiles/de/profile.json -> 2 -> (anynumber you want) -> 2