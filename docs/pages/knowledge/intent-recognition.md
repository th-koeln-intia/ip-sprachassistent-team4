---
layout: default
title: Intent Recognition
parent: Knowledge
nav_order: 5
---
<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Intent Recognition

The Intent Recognition System is used to filter the intent of the spoken text by the user. 
Its converts the the transcripted text from the [Speech to Text](/pages/knowledge/speech-to-text) system to a json with the intent of the user.
In this project we are using Snips NLU, it's a system with very fast recognition speed and a moderate training time.

## How to use Snips NLU?
To use Snips NLU you need to add the following config to your [profile](/pages/knowledge/profile):
```json
"intent": {
  "system": "snips",
  "snips": {
    "language": "de",
    "engine_dir": "snips/engine",
    "dataset_file": "snips/dataset.yaml"
  }
}
```
You can setup ``de``, ``en``, ``es``, ``fr``, ``it``, ``ja``, ``ko``, ``pt_br``, ``pt_pt`` and ``zh`` as you language. If you not set the language, the profile language is used, if it's set.
The options ``engine_dir`` and ``dataset_file`` specifies, where the engine direcory and the datasetfile are located in the profile folder.

## How does rhasspy shares infomation if an intent is recognized or not?
This information is also shared via [MQTT](/pages/knowledge/mqtt).
The [STT](/pages/knowledge/speech-to-text) publishes a recognition request on the topic ``hermes/nlu/query``.
When recognition is successfull the result will be published on the topic ``hermes/intent/<intentName>``, 
and if not  it's answer will be published on ``hermes/nlu/intentNotRecognized``. For more information please take a look on the [MQTT API](https://rhasspy.readthedocs.io/en/latest/reference/#natural-language-understanding).