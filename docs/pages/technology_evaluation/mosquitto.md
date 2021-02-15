---
layout: default
title: Mosquitto
parent: Technology Evaluation
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Mosquitto
Mosquitto is our MQTT broker, it is our communication channel over which all services communicate.
Messages are sent to it, which are then available to all services like on a bulletin board.

## Advantages
- Simple to install
- Simple to use
- A password and an username can be set to provide additional security

## Disadvantages
- If no password is set, it is the biggest security leak in the rhasspy system. 
  Anyone who has access to the same network could publish or subscribe to topics. Thus, one could control or influence almost the entire rhasspy voice assistant.

## Conclusion
Mosquitto is a really powerful MQTT server, there is not much to go wrong. It does what it was created for.