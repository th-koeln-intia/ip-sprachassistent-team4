#!/bin/bash

sudo systemctl stop nodered.service

sudo rm -R ~/tmp/

cd ~/.node-red

npm uninstall node-red-contrib-zigbee2mqtt
npm uninstall node-red-contrib-join-wait
npm uninstall node-red-contrib-smalltimer
npm uninstall node-red-contrib-play-sound
npm uninstall node-red-contrib-play-audio
npm uninstall node-red-contrib-queue-gate
npm uninstall node-red-node-openweathermap

wget https://raw.githubusercontent.com/node-red/node-red/master/packages/node_modules/node-red/settings.js -O ~/.node-red/settings.js

sudo systemctl start nodered.service