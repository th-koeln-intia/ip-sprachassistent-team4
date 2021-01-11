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
There are different ways to setup a light. This example is based on setting a light with Hermes and Zigbe2MQTT protokoll.
To start with Node Red setting your device should be connected to Zigbee2MQTT brocker. Have a look on 
[zigbee2mqtt](/pages/knowledge/zigbee/zigbee2mqtt) to see how you can connect your devices.

## Turn the light on and off

- First create a bridge by selecting Zigbee2mqtt Bridge Node, then enter an optional name for the bridge, ``localhost`` for the Host, ``zigbee2mqtt`` for base topic and ``1883`` for the Mqtt Port
- Select ``MQTT IN`` node and enter the Topic name as well as the Server. In this example the Server name is: ``127.0.0.1:1883`` and the topic is ``hermes/intent/LightStatus`` (Note: the same Intent should be available on Rhasspy Sentences site)
- Then select a switch with available status for the light. In this case with have only two status : ``ON`` or ``OFF``
- Finally select your Zigbee2Mqtt Out Nodes to handle the status of your light

![setup light with Node_Red](../../assets/Setup_light_NodeRed.png)


# Setup light brightness

This example illustrates how to set up the light brightness.

- First specify the intent in sentence.ini. The intent can be something like:

```
[LightBrightness]
Light_name=(living room| Kitchen | light){name}
set <Light_name> [on] (1..100){brightness} [percent]
```
For example with the sentence: ``set the light on 50 percent``, the light should change it state to on, if was off and set the brightness auf 50%.
- Define the function, which will get the brightness value from intent and pass it to zigbeeToMqtt Node: `GetLightBrightness` will be the function name.
- Finally select 	zigbee2mqtt-out Node to set light brightness. Then select zigbee2mqtt for the command and set the alue to Brightness(0..255) and the payload value will be msg.brightness (`Note: the properties brightness is the return propevrty from the fucntion GetLightBrightness`)

![setup light brithness with Node_Red](../../assets/light_brightness.png)

# downlod the flow
- [Download](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/flows/LightControl.json)

