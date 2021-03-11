---
layout: default
title: ReSpeaker
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


# [ReSpeaker](/pages/knowledge/respeaker-4-mic)
ReSpeaker 4-Mic Array for Raspberry Pi is our microphone we used in this project.
There are 4 microphones mounted on one circuit board.

## Advantages
- Good quality
- Good to understand
- Can easily be mounted on the Raspberry Pi
- The direction from which the sound comes can be determined
- It provides visual feedback with the help of LEDs arranged in a circle

## Disadvantages
- On the new raspbian version with the kernel 5.11 are some problems with the original driver repository, 
  but there is another which works well. Read more about this problem in 
  [version dependencies](/pages/technology_evaluation/version-dependencies#seeed-voicecard).
- If apt does a kernel update, you need to reinstall the driver, to keep it working again

## Conclusion
The ReSpeaker microphone works very well with our project, it's easy to use and has very nice features.
When you update your raspbian system, you should keep in mind to reinstalling the ReSpeaker driver again.