---
layout: default
parent: Manual installation
grand_parent: Installation
title: Settings of Rhasspy
nav_order: 2
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Settings of Rhasspy

## 0. Which systems are we using?
We are using the following systems: 
- [Wake word](/pages/knowledge/wake-word) -> Raven
- [Speech to Text](/pages/knowledge/speech-to-text) -> [DeepSpeech](/pages/knowledge/deepspeech)
- [Intent Recognition](/pages/knowledge/intent-recognition) -> [Snips-NLU](/pages/knowledge/intent-recognition#how-to-use-snips-nlu)
- [Text to Speech](/pages/knowledge/text-to-speech) -> NanoTTS
- Dialogue Management -> ?

We need to set up all of these above, and some more:
- [MQTT](/pages/knowledge/mqtt#what-is-mqtt)
- Audio Recording
- Audio Playing
- [Intent Handling](/pages/knowledge/intent-handling) 

I'll go through the settings with the order on the settings page.
You can find the settings page on ``<ip of your Raspberry Pi>:12101``, and then at the gears on the left.
To apply all settings you need to click th e save button on the top or bottom, your Raspberry Pi will restart.

## 1. [MQTT](/pages/knowledge/mqtt#what-is-mqtt)
For background information click on the topic header.
[MQTT](/pages/knowledge/mqtt#what-is-mqtt) is the communication channel rhasspy communicates with. Our [MQTT](/pages/knowledge/mqtt#what-is-mqtt)-server is mosquitto we installed in the installation.
When you have done all steps, in the [installation instruction](/pages/installation/manual/setup-software#2-install-a-mqtt-server) you have already a running [MQTT](/pages/knowledge/mqtt#what-is-mqtt) server on your Raspberry.
To use it you choose ``External`` in the drop down menu next to the [MQTT](/pages/knowledge/mqtt#what-is-mqtt) button in the Rhasspy settings.
Now you can set up a hostname, a port, an username and a password. We only need to set up the host and the port.
The host ip is the local ip of your Raspberry Pi (``127.0.0.1``). When you use Hermes Led Control the host ip MUST be a IP and should
NOT be the alias ``localhost``!. As port, you need the port ``1883``. The username and password is only needed if you installed one.

## 2. Audio Recording
Please make sure you [install](/pages/installation/manual/setup-software#1-configure-audio) your microphone correctly!
When you installed it correctly, you can proceed. Under the MQTT option is the option ``Audio Recording``. Select ``arecord`` in the dropdown menu.
In the options below you only need to select the installed microphone (``Default Audio Device (sysdefault:CARD=seeed4micvoicec)``) or you type
``sysdefault:CARD=seeed4micvoicec`` in the upper textbox.

## 3. [Wake Word](/pages/knowledge/wake-word)
We chose ``Rhasspy Raven`` as Wake Word system. Select it in the drop down menu. When you open the settings, you first need to record three 
examples of your Wake Word. You can choose an own one or you use ``Sherlock`` as Wake Word as we did. You see three Record buttons.
Press the first one and say your Wake Word, then the second, and then the third. Please make sure you record the Wake Word from 3 different positions in the room for example far away, semi far away and close to the microfone. You can then adjust a few settings.      
``Probability Threshold`` is a value between 0 and 1. You can adjust the sensity with it. The lower the value, the more sensitive the rhasspy will react. My best results are with the value  ``0.52``.    
``Average Templates`` combines all example wav files to one. This reduces cpu usage, but the accurity will lessen.    
``Minimum Matches`` this is a number between 1 and 3. It specifies how many wav files needs to match the detection.

## 4. [Speech to Text](/pages/knowledge/speech-to-text)
As STT this project is using [DeepSpeech](/pages/knowledge/deepspeech) 0.7.4, please make sureyou have [installed](/pages/installation/manual/setup-software#7-install-deepspeech-074) it.
In the rhasspy config you must set the dropdown menu to ``Hermes MQTT``. Since you installed this custom version of [DeepSpeech](/pages/knowledge/deepspeech) 0.7.4, you *can't* use the option
[Mozilla DeepSpeech](https://github.com/mozilla/DeepSpeech). This is because the default [DeepSpeech](/pages/knowledge/deepspeech) 0.6.1 of rhasspy can't load the default pretrained language model and there is 
no german pretrained language model for this version. We found a good german pretrained language model at [AASHISHAG/deepspeech-german](https://github.com/AASHISHAG/deepspeech-german), 
but there is no model for [DeepSpeech](/pages/knowledge/deepspeech) 0.6.1 so we port [rhasspy-asr-deepspeech](https://github.com/Sh4der/rhasspy-asr-deepspeech) and [rhasspy-asr-deepspeech-hermes](https://github.com/Sh4der/rhasspy-asr-deepspeech-hermes) to a new version. 
Transcribing works very good but training does not workin. But it's in developement.
Please check in your ``.config/rhasspy/profilesprofile.json`` if this exists:
```json
"speech_to_text": {
        "system": "hermes"
},
```
If there are any other line in the curly braces, please delete them.

## 5. [Intent Recognition](/pages/knowledge/intent-recognition)
For the Intent Recognition you installed [Snips-NLU](/pages/knowledge/intent-recognition). It is installed as an extra server on your Raspberry Pi.
This server starts automaticly, so here you just need to choose Hermes MQTT in the rhasspy settings.

## 6. [Text to Speech](/pages/knowledge/text-to-speech)
Here you can choose your own. We decided to use NanoTTS, it's simple to use and sounds nice.
So choose NanoTTS or one of the TTS you want. When you use nano TTS you only need to set up the language the available languages are ``en-US``, ``en-GB``, ``de-DE``, ``es-ES``, ``fr-FR`` and ``it-IT``.

## 7. Audio Playing
Please choose aplay. When you solved the steps in 
[audio configuration](/pages/installation/manual/setup-software#1-configure-audio) your audio is already configured.

## 8. Dialogue Management

## 9. [Intent Handling](/pages/knowledge/intent-handling)
The [Intent Handling](/pages/knowledge/intent-handling) is for adding skills to rhasspy.
This is realised with [Node-RED](/pages/knowledge/node-red) flows. You can take a look in our [skill](/pages/skills/) section.