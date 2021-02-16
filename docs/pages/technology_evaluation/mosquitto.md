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

Messages are sent from devices to the MQTT broker to a special topic. All services that have subscribed to this topic
receive this message from the MQTT broker.

## Advantages

- Simple to install
- Simple to use
- A password and a username can be set to provide additional security

## Disadvantages

- If no password is set, it is the biggest security leak in the Rhasspy system. Anyone who has access to the same
  network could publish or subscribe to topics. Thus, one could control or influence almost the entire Rhasspy voice
  assistant.

## Conclusion

Mosquitto is a really powerful MQTT broker. There is not much to go wrong. It does what it was created for.