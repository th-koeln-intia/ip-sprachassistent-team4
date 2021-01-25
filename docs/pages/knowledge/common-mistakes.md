---
layout: default
title: Common Mistakes
parent: Knowledge
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Common Mistakes

With startup milestone we are able to configure raspberry pi, setup MQTT broker using Mosquitto as software and 
interact with Rhasspy API.
Independent on how you setup your devices, there are a few things to take into account such as:

- Avoid using the  command ` sudo apt-get upgrade ` on raspberry more than one time
- Use as localhost on your raspberry `127.0.0.1` instead of `localhost` if you attempt to connect to an API 
  where localhost need to be used. For example by setting MQTT option to rhasspy if you use this URL: `localhost:1883` 
  in some cases it doesn't work. Please use ` 127.0.0.1:1883` instead.