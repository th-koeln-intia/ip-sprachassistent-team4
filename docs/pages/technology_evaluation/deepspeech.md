---
layout: default
title: DeepSpeech
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


# [DeepSpeech](/pages/knowledge/speech-to-text)
In our project, [DeepSpeech](/pages/knowledge/speech-to-text) was used as a Speech to Text (STT) system.
STT converts spoken words into text. DeepSpeech works with a neural network to transcript the spoken words into 
text.

## Advantages
- Fast install for the english version
- Multiple pretrained models with different data sources available
- Can be trained with new words really fast
- There are pretrained models available
- It does not consume much cpu load
- If you add [pronouncing](https://rhasspy.readthedocs.io/en/latest/usage/#words-page) to english words, 
  [DeepSpeech](/pages/knowledge/speech-to-text) can also understand them

## Disadvantages
- Only one german pretrained model available. This means that you have no choice between different models and can 
  not try out which model you like best yourself
- Pretrained models are not compatible with other versions of DeepSpeech. 
- For a german installation, DeepSpeech must be installed [manually](/pages/knowledge/deepspeech) without help 
  by Rhasspy
- DeepSpeech in conjunction with Rhasspy and a german language model is difficult to install. If DeepSpeech is 
  automatically installed with Rhasspy version 2.5.7, deepspeech version 0.6.1 is installed. However, there is no 
  german language model for this version. Therefore, we manually upgrade deepspeech to version 0.9.0. Read more about
  this step in [this section](/pages/knowledge/deepspeech)
- As for the german model some words are sometimes not recognized. A very clear pronunciation is necessary so that 
  the words are correctly recognized. Non-native speakers are at a distinct disadvantage here. This could also apply 
  to english-speaking models. This has not been tested by us.
- You can not speak free to [DeepSpeech](/pages/knowledge/speech-to-text), because it trains only the words you write 
  into your [sentence.ini](/pages/knowledge/setup-intents). There is an open transcription option, but when you 
  activate it, the transcription is really messed up.

## Conclusion
Once DeepSpeech is set up, it works acceptably. DeepSpeech has particular problems recognising german with an accent. 
It can be trained well and quickly with new words. Unfortunately, for pre-trained language models other than english, 
there is usually little to no choice.
However, it should be noted that DeepSpeech is still under development. Therefore, it can be hoped that there will 
be further updates in the future and that DeepSpeech will be improved in usability and functionality.
It should be noted that there may be problems with speech impediments or people with a strong accent. 
The more unclear the person speaks, the worse DeepSpeech understands what was said.

