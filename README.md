# Voice Assistant Sherlock
This is a Project to create Proof of Concept for a Voice Assistant. We we are using these Tools:
- Wakeword: Raven
- Speech-To-Text: Deepspeech
- Intent Recognition: Snips NLU
- Intent Handling: NodeRed
- Text-To-Speech: NanoTTS / Mozilla TTS

# Skills
- Read the clock
- Set an alarm clock
- Weather forecast
- Light control
- Get latest news
- Get infos about exchange rate

## To DO
- [X] Write intent handling description
- [X] Control light
- [X] Alarm implementation
- [X] Timer implementation
- [X] Update documentation and git
- [X] Installation script
- [ ] Revise the documentation
- [ ] Make images smaller
- [ ] Setup hardware at the bottom of the page refer to the installation
- [ ] Correct installation arrangement
- [ ] Technology rating section with rating of all technologies write down with personal rating and conclusion.
- [ ] Explanation Why Node-Red the Why is actually missing
- [ ] Link to knowledge entries on all possible pages


## Documentation
The documentation is created in form of a GitHub page following the official documentation:  
[installation guide](https://ip-team4.intia.de/)
You can install Sherlock complete [automatically](https://ip-team4.intia.de/pages/installation/auto-install-script/) 
or [manually](https://ip-team4.intia.de/pages/installation/manual/). Please follow the steps in the relevant section.

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