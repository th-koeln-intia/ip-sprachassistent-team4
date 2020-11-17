---
layout: default
parent: Knowledge
---

# Text To Speech

This layer enable the home assistant to speak to you.Specially in case of rassspy there is an option to save the text and played it through any of the audio output systems.
There are different text to speech systems and the list below showed some exemples and the available language :

|system | en | de | es | fr | it | nl | ru | el | hi | zh | vi | pt | ca | 
|---|---|--|--|---|---|---|---|---|---|---|---|---|---|
| espeak   | x| x| x | x|x| x| x| x| x| x| x| x| x| 
| flite   | x | |  | | | | | | x| | | | | 
| picotts   | x | x|  x| x| x| | | | | | | | | 
| nanotts   | x | x| x | x| x| | | | | | | | | 
| marytts   | x |x |  | x|x | x| | | | | | | | 
| opentts   | x | x| x | x| x| x| x| x| x| x| x|x | x| 
| wavenet   | x | x| x | x| x| x| x| | x| x| | |x | 


*espeak* : is the default text to speech system and hast the widest support.

*flite* : sound better than espeak but can support only feawer languages. Uses FestVox's flite for speech.

*PicoTTS* : Uses SVOX's picotts for text to speech.

*NanoTTS* : uses an imported fork of SVOX's picoTTs for test to speech.

*MaryTTs* : has a MaryTTS Docker image available with many voices included. Use a remote MaryTTS web server.

*OpenTTs* : Uses a remote OpenTTS, supports many different text to speech system such as Mozilla TTS.

*Google WaveNet : requires a google account and internet connection to function 