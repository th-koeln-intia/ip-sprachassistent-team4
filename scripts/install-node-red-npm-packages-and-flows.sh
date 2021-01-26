#!/bin/bash

echo "Start installing Node-RED packages."

#Check if node-red is installed. If not, leave script
echo "Check if node-red is installed."
if ! command -v node-red &> /dev/null
then
    echo "Node-RED is not installed. Please install Node-RED first."
    exit 1
else
    echo "Node-RED installation folder found."
fi

#Install all needed npm packages and software
#Stop node-red service
sudo systemctl stop nodered.service
#Install software
sudo apt install mpg123 jq -y
mkdir -p ~/tmp/
cd ~/.node-red

#General used nodes packages
npm install node-red-contrib-zigbee2mqtt
npm install node-red-contrib-join-wait

#alarm & timer
sudo git clone https://github.com/kevinbischof/node-red-contrib-smalltimer.git ~/tmp/node-red-contrib-smalltimer/
cd ~/tmp/
npm pack node-red-contrib-smalltimer/
cd ~/.node-red
npm install ~/tmp/node-red-contrib-smalltimer-*.tgz
npm install node-red-contrib-play-sound

#Exchange Rate
wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/data/ExchangeCountries -O ~/.config/rhasspy/profiles/de/slots/ExchangeCountries

#Headlines
npm install node-red-contrib-queue-gate
#Light control

#News
#Volume
#Weather forecast
npm install node-red-node-openweathermap
wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/data/cities -O ~/.config/rhasspy/profiles/de/slots/cities

#Clone repository to get all flows
git clone https://github.com/th-koeln-intia/ip-sprachassistent-team4.git ~/tmp/ip-sprachassistent-team4
cd ~/tmp/ip-sprachassistent-team4/flows
#Concatinate all json files to one
jq -s '[.[][]]' *.json > flows_sherlock.json
#Copy the new file to node-red folder
cp ~/tmp/ip-sprachassistent-team4/flows/flows_sherlock.json ~/.node-red/

#Edit ~./node-red/settings.js
#Change default flows_<hostname>.json
sed -i "s/    \/\/flowFile: 'flows.json',/    flowFile: 'flows_sherlock.json',/1" ~/.node-red/settings.js
#Activate contextStorage to local file system
perl -i -p0e 's/\/\/contextStorage: {.*?\/\/},/contextStorage: {\n        default: {\n            module:\"localfilesystem\"\n        },\n    },/s' ~/.node-red/settings.js

#Clean up
cd ~
sudo rm -r ~/tmp

#Start node-red service
sudo systemctl start nodered.service