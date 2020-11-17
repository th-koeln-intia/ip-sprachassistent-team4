---
layout: default
parent: Knowledge
---

with startup milestone we are able to configure raspberry Pi, setup MQTT brocker using Mosquito as sofware and interact with Rhasspy API.
Independent on how you setup your devices, there are few thing to take into account  such as :

- avoid using the  command ` sudo apt-get upgrade ` on raspberry more than one time
- use as locallhost on your raspberry 127.0.0.1 instad of `localhost` if you attempt to connect to an API , where locolhost needd to be used. For exemple by setting MQTT option to rhasspy 
if you use this URl : `localhost: 1883` in some cases it doesnt work better ist to use ` 127.0.0.1:1883` , which will work always.