---
layout: default
parent: Startup
---

# Settings of Rhasspy

## 0. Which systems are we using?
We are using the following systems: 
- Wakeword -> Raven
- Speech to Text -> Deepspeech
- Intent Recognition -> Snips NLU
- Text to Speech -> NanoTTS
- Dialogue Management -> ?

We need to setup all of these above, and some more:
- MQTT
- Audio Recording
- Audio Playing
- Intent Handling
I'll go through the settings with the order on the settings page.
You can find the settings page on ``<ip of your raspberry>:12101``, and then at the gears on the left.
To apply all settings you need to click th e save button on the top or bottom, your raspberry will restart.

## 1. [MQTT](/knowledge/mqtt#what-is-mqtt)
For background Information click on the topic header.
MQTT is the communication channel rhasspy communicates with. Our MQTT-server is mosquitto we installed in the installation.
When you done all steps in the [installations instruction](/startup/setup-software#3-install-a-mqttt-server-and-node-red) you have already a running MQTT server on your Raspberry.
To use it you choose ``External`` in the drop down menu next to the MQTT button in the Rhasspy settings.
Now you can setup a hostname, a port, a username and a password. We only need to setup the host and the port.
The host ip is the local ip of you raspberry pi (``127.0.0.1``). When you use Hermes Led Control the host ip MUST be a IP and should 
NOT be the alias ``localhost``!. As Port you need the port ``1883``. The username and password is only needed if you installed one.

## 2. Audio Recording
Please make sure you [install](/startup/setup-software#2-configure-audio) your microphone correctly!
When you installed it correctly, you can proceed. Under the MQTT option is the option ``Audio Recording``. Select ``arecord`` in the dropdown menu.
In the options below you only need to select the installed microphone (``Default Audio Device (sysdefault:CARD=seeed4micvoicec)``) or you type 
``sysdefault:CARD=seeed4micvoicec`` in the upper textbox.

## 3. [Wake Word](/knowledge/wakeword)
We chose Rhasspy Raven as wake word system. Select it in the drop down menu. When you open the settings, you first need to record three 
examples of your wake word. You can choose a own one or you use ``Sherlock`` as wake word as we did. You see three Record buttons.
Press the first one and say your wake word, then the second, and then the third. You can then adjust a few settings.      
``Probability Threshold`` is a value between 0 and 1. You can adjust the sensity with it. The lower the value, the mire sensitive the rhasspy will react.    
``Average Templates`` combines all example wav files to one. this reduces cpu usage, but the accurity will lessen.    
``Minimum Matches`` this is a number between 1 and 3. It specifies how many wav files needs to match the detection.

## 4. [Speech to Text](/knowledge/speech-to-text)

## 5. Intent Recognition

## 6. Text to Speech
Here you can choose your own. We decided to use NanoTTS, it's simple to use and sounds nice.
So choose NanoTTS or one of the TTS you want. When you use nano TTS you only need to setup the language the available languages are ``en-US``, ``en-GB``, ``de-DE``, ``es-ES``, ``fr-FR`` and ``it-IT``.

## 7. Audio Playing
Please choose aplay. When you follow [step 2](/startup/setup-software#step-2) of the [audio configuration](/startup/setup-software#2-configure-audio), you audio is already configured.

## 8. Dialogue Management

## 9. Intent Handling