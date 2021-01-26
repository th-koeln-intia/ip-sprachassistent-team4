---
layout: default
title: What is Rhasspy?
parent: Knowledge
nav_order: 1
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# What is Rhasspy?
Rhasspy is an open source, fully offline voice assistant toolkit.
Rhasspy combines all needed tools for a voice assistant, from
the hotword to the intent Handling.

# Speech To Text
This is the primary function of rhasppy and allowed Rhasspy to convert a voice command to a JSON event.
The offline transcription of voice commands in Rhasspy is handled by one of three open source systems:

- Pocketsphinx
- Kaldi
- DeepSpeech (This tool are we using)

[Read more about Speech To Text](/pages/knowledge/speech-to-text)


# Text To Speech
Some commands produces a voice feedback, this voice feedback will be created with a TTS(Text-To-Speech)-system.
There are different text to speech systems, rhasspy combines them in one MQTT API. 
These are available: flite (only in english), picotts, nanotts, marytts, opentts, wavenet.

[Read more about Text To Speech](/pages/knowledge/text-to-speech)

# Intent Handling
After a sucessful recognation of intent, Rhasppy will send a JSON even to a home Assistant or a remote Rhasspy server.
The Intent handling sytems are: Home Assistant, Remote HTTP Server, external command. Rhasspy pubishes intent over MQTT 
protocol.

[Read more about intent handling](/pages/knowledge/intent-handling)

# Intent Recognition
The voice command is transcribed from Test-To-Speech system and after that the intent needs to be recognized and as 
result, the rhasspy will produced a JSON event. The are different intent recognition systems:
- Fsticuffs (if you plan  to recognize the voice from your training set, this will be the best)
- Fuzzywuzzy
- Snips NLU (NLU -> Natural Language Understanding)
- RasaNLU
- Mycroft Adapt (Not supported yet in 2.5), 
- Flair (also not supported in 2.5)
- Home Assistant Conversation(Not supported in 2.5)
- (command and dummy)

[Read more about intent recognition](/pages/knowledge/intent-recognition)

# Wake Word
A wake word is used to activate the voice assistant. also called "hot word".
Rhasppy can listening to a wake world throught differents systems. It is also possible to wake rhaspy with a 
HTTP Post verb. the best system is Porcupine.

[Read more about Wake Word](/pages/knowledge/wake-word)

# MQTT
MQTT is an OASIS standard messaging protocol for the Internet of Things (IoT). It is designed as an extremely 
lightweight publish/subscribe (one to many BI directional communication) messaging transport that is ideal for 
connecting remote devices with a small code footprint and minimal network bandwidth. It has tree level of quality of 
services, support for unreliable network and security enable.

[Read more about MQTT](/pages/knowledge/mqtt)

# Voice Assistant

Voice assistants are already being used is many parts of our live: They are used in smartphones and 
smartspeakers, in mobile apps and operating systems, in cars, in medical care and telecommunications.
Based on an input (mostly as voice command), the voice assistant will do what we asked it for the answer
can be in form os a spoken phrase or an action.
There are different voice assistant such as Siri, Alexa and Google Home.
These voice assitants mentioned above all use the internet to process your commands and data on a cloud and many people are concerned about 
how they use private data. 
Other voice assistants like Rhasspy, Jasper, etc. are able to work without sharing our data over internet and these 
are very interesting for people who are concerned about the privacies.
