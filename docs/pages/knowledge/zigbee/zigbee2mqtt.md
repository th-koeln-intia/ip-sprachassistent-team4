---
layout: default title: Zigbee2MQTT parent: Zigbee grand_parent: Knowledge
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Zigbee2MQTT

Zigbee2MQTT allows you to use your Zigbee devices without the vendors bridge or gateway.

It bridges events and allows you to control your Zigbee devices via [MQTT](/pages/knowledge/mqtt.html). In this way you
can integrate your Zigbee devices with whatever smart home infrastructure you are using.

To use Zigbee2MQTT you need a zigbee adapter. You can see a complete list
[here](https://www.zigbee2mqtt.io/information/supported_adapters.html){:target="_blank"}.

## Installation

[You can find the installation here](/pages/installation/manual/setup-software.html#4-install-zigbee2mqtt)

## Connect a new device

First make sure the option ``permit_join`` in the file ''/opt/zigbee2mqtt/data/configuration.yaml`` is set on true. To
control your paired device correctly, you need to open the log from Zigbee2MQTT:

```bash
sudo journalctl -u zigbee2mqtt -f
``` 

Reset the device. To reset lamps in most cases you need to turn off and on the device 5 times. When your device is
paired correctly, you should see a message like this:

```
Zigbee2MQTT:info  2019-11-09T12:19:56: Successfully interviewed '0x00158d0001dc126a', device has successfully been paired
```

Congratulation! You connected your zigbee device successfully to your Raspberry Pi. When you see a warning under this
message, something like this:

```
Zigbee2MQTT:warn  2019-11-09T12:19:56: Device '0x00158d0001dc126a' with Zigbee model 'P40 TW Value' and manufacturer name 'some_name' is NOT supported, please follow https://www.zigbee2mqtt.io/how_tos/how_to_support_new_devices.html
```

your device is not supported and is not ready to use. But you can add your device with another method, which is
described in the next chapter.

## Add unsupported devices to Zigbee2MQTT

Open ``node_modules/zigbee-herdsman-converters/devices.js``. In this example I'm using a
[Ledvance P40 TW Value](https://www.amazon.de/Technologie-E14-Lichtfarbe-2700-6500K-Gl%C3%BChlampen/dp/B08KY9Z8JC/ref=cm_cr_arp_d_product_top?ie=UTF8)
. It's a tiny bulb with brightness and colortemp control. Unfortunately it's not supported by Zigbee2MQTT, but there are
already other bulbs with similar specifications from Ledvance. If you have a similar scenario, go down to the devices
variable and search the device that is similar to yours. In my case I searched for the ``// Ledvance`` comment and found
this:

```json
{
  zigbeeModel: [
    'B40 TW Z3'
  ],
  model: '4058075208414',
  vendor: 'LEDVANCE',
  description: 'SMART+ candle E14 tunable white',
  extend: ledvance.light_onoff_brightness_colortemp,
  ota: ota.ledvance
},   
```

This the the bulb, which is most similar to my bulb. The vendor is the same, the model is similar and the functionality
is the same. So I duplicated this part and edited the ``zigbeeModel``:

```json
{
  zigbeeModel: [
    'B40 TW Z3'
  ],
  model: '4058075208414',
  vendor: 'LEDVANCE',
  description: 'SMART+ candle E14 tunable white',
  extend: ledvance.light_onoff_brightness_colortemp,
  ota: ota.ledvance
},
{
zigbeeModel: ['P40 TW Value'],
model: '4058075208414',
vendor: 'LEDVANCE',
description: 'SMART+ drop E14 tunable white',
extend: ledvance.light_onoff_brightness_colortemp,
ota: ota.ledvance,
},
```

Now the warning from above should not appear again. If you have another scenario or problem, please look at this
page: [How to support new devices](https://www.zigbee2mqtt.io/how_tos/how_to_support_new_devices.html)
