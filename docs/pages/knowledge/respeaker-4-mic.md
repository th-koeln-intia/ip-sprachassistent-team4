---
layout: default
title: ReSpeaker 4 Mic Array for Raspberry Pi
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


# [ReSpeaker 4 Mic Array for Raspberry Pi](https://wiki.seeedstudio.com/ReSpeaker_4_Mic_Array_for_Raspberry_Pi/)

![Respeaker 4 Mic](https://respeaker.io/assets/images/4_mic_array.jpg)

The ReSpeaker 4 Mic Array is a HAT(Hardware attached on top) for the Raspberry PI.
There are 4 Microphones mounted on and 12 LEDs for visual feedback. The 12 LEDs can emit
light in nearly every RGB color and they can be addressed directly. With a tool like
[Hermes Led Control](/pages/knowledge/hlc).

Thank to the 4 microphones you can also find the direction from where the sound 
comes the microphone recognices.

# Assembling
After you unpack it you can stack it directly on the Raspberry Pi.

# Installing driver
Before you can use it you need to install the driver for the AC108 mountet on the Respeaker.

````bash
sudo apt-get update
sudo apt-get upgrade
git clone https://github.com/respeaker/seeed-voicecard.git
cd seeed-voicecard
sudo ./install.sh  
reboot
```

Please check if `seeed-4mic-voicecard` is listed in this command:
```bash
arecord -L
```