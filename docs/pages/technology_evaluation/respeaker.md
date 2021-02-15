---
layout: default
title: Respeaker
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


# Respeaker
ReSpeaker 4-Mic Array for Raspberry Pi is our microphone we used in this project.
There are 4 microphones mounted on one circuit board.

## Advantages
- Good quality
- Good to understand
- Can easy be mounted on the Raspberry
- The direction of from where the sound it records can be determined
- It provides visual feedback with the help of leds arranged in a circle

## Disadvantages
- On the new raspbian version with the kernel 5.11 are some problems with the original driver repository, but there is another which works well.
- If apt does a kernel update, you need to reinstall the driver, to keep it working again

## Conclusion
The Respeaker microphone works very well with our project, it's easy to use and has very nice features.
When you update your raspbian system, you should keep in mind to reinstall the respeaker driver again.