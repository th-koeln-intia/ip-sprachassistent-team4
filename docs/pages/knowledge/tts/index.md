---
layout: default
title: TTS
has_children: true
parent: Knowledge
---

# Text To Speech

After handling the voice command, it's common to give the user a response in the form of a speech. 
Rhasspy uses a text to speech system (TTS) to generate a voice out of text.
We tested two TTS,[Mozilla TTS](/pages/knowledge/tts/mozilla-tts) and [Nano TTS](/pages/knowledge/tts/nano-tts).

## MQTT API
To trigger the TTS to say something, you must publish the MQTT message ``/hermes/tts/say`` with the attribute ``text`` and the attribute ``siteId``.
The attribute ``text`` must contain the text you want to hear from the TTS. After you send it out, the TTS produces a voice wav file and plays it on the speaker of your rhasspy.
When rhasspy finished playing the wavfile, the MQTT messaage ``hermes/tts/sayFinished`` is send with the same siteId as ``/hermes/tts/say``.

## What systems are available?
There are different text to speech systems and the list below shows some examples with the available language:

|system | en | de | es | fr | it | nl | ru | el | hi | zh | vi | pt | ca | 
|---|---|--|--|---|---|---|---|---|---|---|---|---|---|
| eSpeak   | x| x| x | x|x| x| x| x| x| x| x| x| x| 
| Flite   | x | |  | | | | | | x| | | | | 
| PicoTTS   | x | x|  x| x| x| | | | | | | | | 
| NanoTTS   | x | x| x | x| x| | | | | | | | | 
| MaryTTS   | x |x |  | x|x | x| | | | | | | | 
| OpenTTS   | x | x| x | x| x| x| x| x| x| x| x|x | x| 
| WaveNet   | x | x| x | x| x| x| x| | x| x| | |x | 


*eSpeak*: is the default text to speech system and has the widest support.

*Flite*: sounds better than eSpeak, but can support only fewer languages. Uses FestVox's Flite for speech.

*PicoTTS*: uses SVOX's PicoTTS for text to speech.

*NanoTTS*: uses an imported fork of SVOX's picoTTs for test to speech.

*MaryTTS*: has a MaryTTS Docker image available with many voices included. Use a remote MaryTTS web server.

*OpenTTS*: Uses a remote OpenTTS, supports many different text to speech system such as Mozilla TTS.

*Google WaveNet*: requires a google account and internet connection to function 
