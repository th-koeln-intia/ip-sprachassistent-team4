---
layout: default 
title: Zigbee2MQTT 
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

# [Zigbee2MQTT](/pages/knowledge/zigbee/zigbee2mqtt)

Zigbee2MQTT allows you to use your Zigbee devices without the vendors bridge or gateway.

It bridges events and allows you to control your Zigbee devices via [MQTT](/pages/knowledge/mqtt.html). In this way you
can integrate your Zigbee devices with whatever smart home infrastructure you are using.

The installation itself is simple. To simplify the installation even more, we have written an installation script. This
script just needs to be downloaded and executed. The graphical interface is activated automatically and does not need to
be done manually.

## Advantages

- Easy to install
- Easy to configure
- GUI can be enabled
- Many devices are compatible
- Community adds new Zigbee devices very fast
- Devices can be named to better identify them and make them easier to use in Node-RED, for example
- Devices can be added to a group. This group can then be addressed in an MQTT topic. For example, lamps in a room can
  be added to a group and addressed with a topic like a single device

## Disadvantages

- GUI needs to be enabled manually in a config file
- Adding unsupported devices is very difficult

## Conclusion

