---
layout: default
title: Text To Speech
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

# Text To Speech

After handling the voice command, it's common to give the user a response in the form of a speech. 
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
