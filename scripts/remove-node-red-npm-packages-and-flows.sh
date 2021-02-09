#!/bin/bash

#Stop node-red service
sudo systemctl stop nodered.service

#Remove tmp folder
sudo rm -R ~/tmp/

#Change to node-red folder
cd ~/.node-red

#Remove npm packages
npm uninstall node-red-contrib-zigbee2mqtt
npm uninstall node-red-contrib-join-wait
npm uninstall node-red-contrib-smalltimer
npm uninstall node-red-contrib-play-sound
npm uninstall node-red-contrib-play-audio
npm uninstall node-red-contrib-queue-gate
npm uninstall node-red-node-openweathermap

#Get default settings.js
wget https://raw.githubusercontent.com/node-red/node-red/master/packages/node_modules/node-red/settings.js -O ~/.node-red/settings.js

#Remove all slots
#sudo rm ~/.config/rhasspy/profiles/de/slots/*

#Start node-red service
sudo systemctl start nodered.service