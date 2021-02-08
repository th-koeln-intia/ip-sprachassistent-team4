---
layout: default
title: Rhasspy
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

# Rhasspy

# Adventages

## Keep Your Privacy
 
Unlike other voice assistants like Google, Alexa, etc, Rhasspy doesn’t share data across the internet and this is very interesting for people, who are concerned about their privacy.
 
## Extendable
 
Once you have rhasspy as your voice assistance you can add additional features for your needs.
For example it is possible to train rhasspy to use your own voice for text to speech engine.
 
## Self Wake Word
 
Unlike for example google assistant, you can set your own custom wake word with rhasspy and change it frequently as you want.
 
## Automated installation
 
It is possible to use a script or a docker to get rhasspy ready to use on other computers.

# Disadventages
 
## Not easy to setup
 
To get rhasspy running on a device like rhaspberry, many settings are required. In most of the cases, there is documentation available on web sites but they are not always updated and you need some more effort to get the correct setting. The information is also distributed on different pages and you need to find the relevant usages, which correspond to your current topic.
 
## Speech-To-text is not reliable
 
The Speech-To-text engine takes too much time to recognize a voice command and sometimes the recognition is not reliable.
 
## Artificial Text-to-Speech voice
 
Text-to-speech voice is very artificial and most of the time, much effort is needed to understand the output if you do not know what exactly is being spoken.


## Conclusion
Rhasspy is a really nice system which can work very good after installation. It has some limitatations, that doesn't work well.
Especially the speech to text system can be very annoying on the raspberry pi. Deepspeech ist build on a neural net and the raspberry pi 
is not build for such complex calculations. But if you have a clean installation of rhasspy the process time of rhasspy is really good.
Keep it clean and your rhasspy will work well.
