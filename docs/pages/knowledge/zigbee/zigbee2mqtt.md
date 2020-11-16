---
layout: default
parent: Zigbee
grand_parent: Knowledge
---

# Zigbee2MQTT

Zigbee2MQTT allows you to use your Zigbee devices without the vendors bridge or gateway.

It bridges events and allows you to control your Zigbee devices via [MQTT](/pages/knowledge/mqtt.html). In this way you can integrate your Zigbee devices with whatever smart home infrastructure you are using.

To use Zigbee2MQTT you need a zigbee adapter. You can see a complete list [here](https://www.zigbee2mqtt.io/information/supported_adapters.html){:target="_blank"}.

## Run as Docker

Run by executing the following commmand:

```
docker run \
   --name zigbee2mqtt \
   -p 7777:7777 \
   -d \
   -it \
   -v $(pwd)/data:/app/data \
   --device=/dev/ttyACM0 \
   -e TZ=Europe/Amsterdam \
   -v /run/udev:/run/udev:ro \
   koenkk/zigbee2mqtt
```

This command will download and immediately run the latest version from docker hub in background.

## Connect a new device

Reset the device. To reset lamps in most cases you need to turn off and on the device 5 times.