---
layout: default
parent: Startup
title: Setup Hardware
nav_order: 1
---

# Shopping List

To build your own voice assistant, you will need at least the following things:

* Raspberry Pi 3b/3b+/4 with Power Cable
* Micro-SD-Card with min. 16gb
* RESPEAKER 4-Mic-Array
* Zigbee2MQTT adapter, like **Texas Instruments CC2531** or **ConBee2** 
([or other compatible adapters](https://www.zigbee2mqtt.io/information/supported_adapters){:target="_blank"})
* Zigbee LED Light Bulb or any other Zigbee device
* Speaker with 3.5mm jack

# Setup Raspberry Pi

The easiest way to setup a Raspberry Pi is to use the 
[**Raspberry Pi Imager**](https://www.raspberrypi.org/software/){:target="_blank"}.

Steps:
1. Insert Micro SD Card
2. Choose OS -> We recommend Raspbian with OS
3. Choose Micro SD Card
4. Click Button **Write**
5. Done!

You can attach a screen, keyboard and mouse to enable SSH and configure WIFI connection.

The username is ``pi`` and the password is ``raspberry``. 
You should [change the password](https://www.raspberrypi.org/documentation/linux/usage/users.md){:target="_blank"} 
immediately.

# Optionally SSH and WIFI configuration

If you want to start the Raspberry Pi headless, you can enable SSH and configure the WIFI connection before starting.

## Enable SSH

You only need to create a empty file with the name ``ssh`` in the boot directory. Done!

## Configure WIFI

Create a file with the name ``wpa_supplicant.conf`` in the root directory of the pi. Fill it with the following code
and adjust ``country`` to your country, for example DE for germany. 
Also adjust ``ssid`` and ``psk`` to your network. 

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=<Insert 2 letter ISO 3166-1 country code here>

network={
 ssid="<Name of your wireless LAN>"
 psk="<Password for your wireless LAN>"
}
```
you can use the command ` sudo rasi-config` for additional setting (e.g : change your time zone, set the language, Keybord layout etc..)

Read more about a headless setup 
[here](https://www.raspberrypi.org/documentation/configuration/wireless/headless.md){:target="_blank"}.

# Plugin RESPEAKER and Zigbee Adapter

Attach the RESPEAKER 4-Mic-Array to the Raspberry Pi and plugin the Zigbee Adapter.

![Raspberry Pi with RESPEAKER and ConBee2](../../assets/rpi_respeaker_conbee2.jpg)


# Finish!

Congratulations! You mastered the first step to your own Voice Assistant! 
 


