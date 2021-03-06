---
layout: default
title: Intent Recognition
parent: Knowledge
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
It converts the transcript text from the [Speech to Text](/pages/knowledge/speech-to-text) system to a JSON with the 
intent of the user. In this project we are using Snips-NLU. It's a system with very fast recognition speed and a 
moderate training time.

## How to use Snips-NLU
Please install Snips-NLU with the instruction in 
[Setup Software](/pages/installation/manual/setup-software#8-install-snips-nlu).
In the service file from Snips-NLU you can set a path for the engine and dataset.yml and you there you can also set 
the language.
We created our own install instruction, because the command rhasspy-snips-nlu is not installed in the Rhasspy virtual 
environment.
So we decided to install it on our own and communicate with it via MQTT.

The following instruction does not work, it's the old way to install Snips-NLU.
To use Snips-NLU you need to add the following config to your [profile](/pages/knowledge/profiles):
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
You can setup ``de``, ``en``, ``es``, ``fr``, ``it``, ``ja``, ``ko``, ``pt_br``, ``pt_pt`` and ``zh`` as you language. 
If you don't set the language, the profile language is used if you set one.
The options ``engine_dir`` and ``dataset_file`` specifies where the engine directory, and the datasetfile are located 
in the profile folder.

## Information sharing with Rhasspy
This information is also shared via [MQTT](/pages/knowledge/mqtt).
The [STT](/pages/knowledge/speech-to-text) publishes a recognition request on the topic ``hermes/nlu/query``.
When recognition is successful, the result will be published on the topic ``hermes/intent/<intentName>``.  
If the recognition is not successful, the answer will be published on ``hermes/nlu/intentNotRecognized``. 
For more information please take a look on the [MQTT API](https://rhasspy.readthedocs.io/en/latest/reference/#natural-language-understanding).
