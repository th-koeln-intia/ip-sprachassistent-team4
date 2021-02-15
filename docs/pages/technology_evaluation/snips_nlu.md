---
layout: default
title: Snips NLU
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


# Snips NLU
Snips is a program to convert said sentences into intents and then publishes an MQTT topic based on the intent name.

## Advantages
- Fast translation from text to intents
- Also mostly understands wrong transcripted Text from DeepSpeech
- Many languages are supported 
- It translates written numbers into real numbers

## Disadvantages
- Can not be installed via rhasspy profile config

## Conclusion
Snips NLU is a really good intent recognition. It works really good, we had no problem with it, 
everything works as expected.