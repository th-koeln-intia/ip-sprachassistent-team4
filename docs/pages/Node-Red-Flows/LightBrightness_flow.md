---
layout: default 
title: LightBrightness_flow 
parent: Node-Red-Flows
---
<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# LightBrithness_flow

```JSON
[
  {
    "id": "7d7e6b03.a34104",
    "type": "tab",
    "label": "Brithness",
    "disabled": false,
    "info": ""
  },
  {
    "id": "1f56dd0e.52c023",
    "type": "mqtt in",
    "z": "7d7e6b03.a34104",
    "name": "",
    "topic": "hermes/intent/LightBrightness",
    "qos": "2",
    "datatype": "json",
    "broker": "f80b985a.2ffa78",
    "x": 140,
    "y": 220,
    "wires": [
      [
        "c128b707.c21638"
      ]
    ]
  },
  {
    "id": "c7282459.4e49c8",
    "type": "zigbee2mqtt-out",
    "z": "7d7e6b03.a34104",
    "name": "LightBrightness",
    "server": "7c9dbd0a.c040e4",
    "friendly_name": "",
    "device_id": "0xf0d1b80000175d54",
    "command": "brightness",
    "commandType": "z2m_cmd",
    "payload": "brightness",
    "payloadType": "msg",
    "transition": 0,
    "x": 660,
    "y": 220,
    "wires": []
  },
  {
    "id": "c128b707.c21638",
    "type": "function",
    "z": "7d7e6b03.a34104",
    "name": "GetLightBrightness",
    "func": "\nmsg = {\n         brightness: 255*msg.payload.slots[1].value.value/100\n    }\n    return msg;",
    "outputs": 1,
    "noerr": 0,
    "initialize": "",
    "finalize": "",
    "x": 410,
    "y": 220,
    "wires": [
      [
        "c7282459.4e49c8"
      ]
    ]
  },
  {
    "id": "f80b985a.2ffa78",
    "type": "mqtt-broker",
    "name": "",
    "broker": "127.0.0.1",
    "port": "1883",
    "clientid": "",
    "usetls": false,
    "compatmode": false,
    "keepalive": "60",
    "cleansession": true,
    "birthTopic": "",
    "birthQos": "0",
    "birthPayload": "",
    "closeTopic": "",
    "closeQos": "0",
    "closePayload": "",
    "willTopic": "",
    "willQos": "0",
    "willPayload": ""
  },
  {
    "id": "7c9dbd0a.c040e4",
    "type": "zigbee2mqtt-server",
    "name": "Licht",
    "host": "127.0.0.1",
    "mqtt_port": "1883",
    "mqtt_username": "",
    "mqtt_password": "",
    "tls": "",
    "usetls": false,
    "base_topic": "zigbee2mqtt"
  }
]
```