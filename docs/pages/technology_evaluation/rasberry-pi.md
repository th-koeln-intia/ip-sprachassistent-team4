---
layout: default
title: Raspberry Pi
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

# Raspberry Pi
The Raspberry Pi is the single board computer we used to run the rhasspy system on it. There are different versions available
with lower and higher CPU power and memory. We used the [Raspberry Pi 3B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/) and 
the [Raspberry Pi 4](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb)

## Advantages
- It's Cheap
- Easy to install
- Small (85,6 mm x 56,0 mm)
- Big community, so the support for this device is really good
- There are many expansion boards available, like the [Respeaker 4-Mic microphone] we use

## Disadvantages
- Some Libaries are not available as prebuild for ARM CPUs, but you can build them for yourself
- For some programs the cpu power is too low. E.g. Mozilla TTS
- No powerfull GPU on board

## Conclusion
The Raspberry Pi is a nice small single board computer with enough power to run rhasspy on it.
When you want to use programms like Mozilla TTS you should use a more powerfull device, maybe with better tensorflow 
support like Nvidia Jeson Nano or a normal computer with a GPU.