---
layout: default
title: Deepspeech
parent: Technology Evaluation
grand_parent: Conclusion
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>


# [Deepspeech](/pages/knowledge/speech-to-text)
[Deepspeech](/pages/knowledge/speech-to-text) is our speech to text system. It creates written text out of spoken text
really quickly

## Advantages
- Fast install for the english version
- Can be trained with new words really fast
- There are pretrained models available
- It does not consume much cpu load
- If you add [pronouncing](https://rhasspy.readthedocs.io/en/latest/usage/#words-page) to english words, [Deepspeech](/pages/knowledge/speech-to-text) can also understand them

## Disadvantages
- Only one german pretrained model found
- Models are not compatible with other versions
- For a german installation it must be installed [manually](/pages/knowledge/deepspeech) without help by rhasspy
- Hard to install
- Some words are sometimes not recogniced
- You can not speak free to [Deepspeech](/pages/knowledge/speech-to-text), because it trains only the words you write into your [sentence.ini](/pages/knowledge/setup-intents). There is an open transcription option, but when you activate it the transcription is really messed up.

## Conclusion
Deepspeech works fine, when you already set it up. When it is running, there is no problem with adding new words and sentences to it.
Finding a good language model for the right language is not simple. 
Deepspeech is stil in development, so we can hope for some updates in the future for better usability and functionallity. 