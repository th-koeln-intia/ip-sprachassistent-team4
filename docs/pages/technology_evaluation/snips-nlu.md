---
layout: default
title: Snips-NLU
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


# [Snips-NLU](/pages/knowledge/intent-recognition)
[Snips-NLU](/pages/knowledge/intent-recognition) is a program to convert transcribed spoken sentences into intents and 
then publishes a MQTT topic based on the intent name.
This is necessary to be able to react according to the spoken commands with the intent handler.

## Advantages
- Fast translation from text to intents
- Also, mostly understands wrong transcribed Text from DeepSpeech
- Many languages are supported 
- It translates written numbers into real numbers

## Disadvantages
- Can not be installed via the rhasspy gui for profile config. We solved this problem with an 
  [own installation script](/pages/installation/manual/setup-software#8-install-snips-nlu) which installs Snips-NLU in
  a virtual environment

## Conclusion
Snips-NLU is an excellent intent recognition system. It works good, we had no problem with it except with the 
difficult installation in a virtual environment.