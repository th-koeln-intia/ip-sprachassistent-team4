---
layout: default
title: Light control
parent: Results
---
<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Light control
there are different ways to set up a light. This example is based on setting a light with Hermes and Zigbe2MQTT protokoll.
To start with Node Red setting your device should be connected to Zigbee2MQTT brocker. Have a look on 
[zigbee2mqtt](/pages/knowledge/zigbee/zigbee2mqtt) to see how  you can connect your devices.

## `Turn the light on and off`

- first create a bridge by selecting Zigbee2mqtt Bridge Node, then enter an optional name for the bridge, Locallhost for the Host , zigbee2mqtt for Base Topic and 1883 for the Mqtt Port
- select MQTT IN node and enter the Topic name as well as the Server. In this example the Server name is : 127.0.0.1: 1883 and the topic is hermes/intent/LampeStatus (Note: the same Intent should be available on Rhasspy Sentences site)
- then select a switch with available status for the light. In this case with have only two status : ON or OFF
- finally select your Zigbee2Mqtt Out Nodes to handle the status of your light

![setup light with Node_Red](../../assets/Setup_light_NodeRed.png)


# `setup light brithness`

This example illustrates how  to set up the light brithness.

- first specify the intent in sentence.ini. the intent can be something ling :

```
[LampeHelligkeit]
Lampe_name=(Wohnzimmer| Kueche| Licht){name}
setze <Lampe_name> [auf] (1..100){brightness} [Prozent]

```
for example with the sentence : setze Lich auf 50 Prozent, the light schoulg change it state to on if was off and set the brightness auf 50%.
- define the function, which will get the brightness value from intent and pass it to zigbeeToMqtt Node: `GetLightBrightness` will be the function name.
- finally select 	zigbee2mqtt-out Node to set light brightness. Then select zigbee2mqtt for the command and set the value to Brightness(0..255) and  the payload value will be masg.brightness (`Note: the properties brightness is the return property from the fucntion GetLightBrightness`)

![setup weather forecast with Node_Red](../../assets/light_brightness.png)


