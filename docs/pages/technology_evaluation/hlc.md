---
layout: default
title: Hermes LED Control
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


# [Hermes LED Control](/pages/knowledge/hlc)
In our project, [Hermes LED Control](/pages/knowledge/hlc) (HLC) was used to control the LEDs of the ReSpeaker microphone 
array.

## Advantages
- Easy to install with one exception (see disadvantages)
- You are guided through the whole installation
- Triggers the LEDs on the [most common mqtt topics](https://github.com/project-alice-assistant/HermesLedControl/wiki/MQTT-Topics){:target="_blank"}
- Predefined LED pattern like Google, Alexa etc.
- Create custom pattern

## Disadvantages
- In the installation it's important to directly set the correct path of Rhasspy config.json. If there is a mistake in 
  the path url, HLC does not work and the LEDs will not blink.
- Since the update to version 2.0.11, HLC no longer works in conjunction with Rhasspy. The version update has added a 
  functionality by which HLC accesses the microphone array and recognizes from which direction speech was spoken. 
  With this function, only the LEDs from which direction the voice input was made can be switched on. However, since 
  Rhasspy also needs access to the microphone array, both programmes come into conflict. To solve this conflict, we 
  stay on version 2.0.10.
- Not documented which topics start or stop the LEDs

## Conclusion
HLC is very easy to install with one exception mentioned above. The version 2.0.10 works very well with Rhasspy.
When the wake word has been triggered, the LEDs flash and after speech recognition, the LEDs also stop flashing again. 
Different flashing patterns can be selected or your own can be created. 