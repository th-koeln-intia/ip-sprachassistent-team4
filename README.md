# [Voice Assistant Sherlock](https://ip-team4.intia.de)
This is a Project to create Proof of Concept for a Voice Assistant. 
We are using these Tools:
- Wake word:  [Raven](https://github.com/rhasspy/rhasspy-wake-raven) ([Sherlock docs](https://ip-team4.intia.de/pages/knowledge/wake-word))
- Speech to Text: [DeepSpeech](https://github.com/mozilla/DeepSpeech) ([Sherlock docs](https://ip-team4.intia.de/pages/knowledge/deepspeech))
- Intent Recognition: [Snips-NLU](https://github.com/snipsco/snips-nlu) ([Sherlock docs](https://ip-team4.intia.de/pages/knowledge/intent-recognition))
- Intent Handling: [NodeRed](https://nodered.org/) ([Sherlock docs](https://ip-team4.intia.de/pages/knowledge/node-red))
- Text-To-Speech: [NanoTTS](https://github.com/gmn/nanotts) ([Sherlock docs](https://ip-team4.intia.de/pages/knowledge/tts/nano-tts))
- 
## Skills
- [Read the clock](https://ip-team4.intia.de/pages/skills/time)
- [Set an alarm clock](https://ip-team4.intia.de/pages/skills/alarm/)
- [Weather forecast](https://ip-team4.intia.de/pages/skills/weather-forecast)
- [Light control](https://ip-team4.intia.de/pages/skills/light-control)
- [Get latest news](https://ip-team4.intia.de/pages/skills/news/)
- [Get infos about exchange rate](https://ip-team4.intia.de/pages/skills/exchange-rate)

## Project folder overview
- data &#8594; the folder contains configuration files and files needed for the operation of rhasspy 
- docs &#8594; the folder contains the documentation of the project 
- flows &#8594; the folder contains the node-red flows 
- scripts &#8594; the folder contains the installation scripts for the components of the voice assistant
- tools &#8594; the folder contains the training tools for DeepSpeech

## Documentation
The documentation is created in form of a GitHub page following the official documentation:  
[Sherlock docs](https://ip-team4.intia.de)
You can install Sherlock complete [automatically](https://ip-team4.intia.de/pages/installation/auto-install-script/auto-installation.html) 
or [manually](https://ip-team4.intia.de/pages/installation/manual/setup-software.html). Please follow the steps in the relevant section.

To run the documentation locally Jekyll is required. Follow the official installation [guide](https://jekyllrb.com/docs/installation/) to install Jekyll for the appropriate OS. It is important to install the correct version to prevent potential problems with Github Pages. The officially supported version is listed [here](https://pages.github.com/versions/).  
The following command starts a local server, if Jekyll is installed with bundler:
```bash 
cd docs
bundle exec jekyll serve
```

## Our other Repositories we used in this Project
- rhasspy-asr-deepspeech: [Sh4der/rhasspy-asr-deepspeech](https://github.com/Sh4der/rhasspy-asr-deepspeech)
- rhasspy-asr-deepspeech-hermes: [Sh4der/rhasspy-asr-deepspeech-hermes](https://github.com/Sh4der/rhasspy-asr-deepspeech-hermes)
- node-red-contrib-smalltimer: [kevinbischof/node-red-contrib-smalltimer](https://github.com/kevinbischof/node-red-contrib-smalltimer)
- MQTTMozillaTTSGerman: [Sh4der/MQTTMozillaTTSGerman](https://github.com/Sh4der/MQTTMozillaTTSGerman)