---
layout: default
title: Mozilla TTS
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


# Mozilla TTS
In our project we tested [Mozilla Text to Speech TTS](/pages/knowledge/tts/mozilla-tts) as a counterpart to Mozilla 
DeepSpeech (STT). TTS converts text into speech. 

## Advantages
- Good pronunciation
- Clear and fluid language
- A pretrained german model with a male voice is available
- It’s possible to create an own dataset with an own voice (24h audio files are needed)

## Disadvantages
- It's not fast, it runs *really really slow* on a Raspberry Pi, e.g. for [the weather forecast skill](/pages/skills/weather-forecast) 
  it takes 1 minute and 17 seconds to convert text to speech. For comparison, we installed Mozilla TTS on a Linux 
  desktop PC and tested it with the weather forecast. This took only 10 seconds on average.
- The most datasets are in english and only one german
- When you want to train your own dataset it takes a long time
- It can not read long texts. When the text is too long it starts to stutter and whisper.

## Conclusion
Since we use a Raspberry Pi in our project and the TTS needs over a minute to generate an audio output, Mozilla TTS 
is not usable for our project. However, if higher processing power is available, Mozilla TTS is a good alternative 
to other TTS systems.