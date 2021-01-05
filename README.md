# Voice Assistant Sherlock
This is a Project to create Proof of Concept for a Voice Assistant. We we are using these Tools:
- Wakeword: Raven
- Speech-To-Text: Deepspeech
- Intent Recognition: Snips NLU
- Intent Handling: NodeRed
- Text-To-Speech: NanoTTS

## To DO
- [X] Intent Handling beschreibung machen
- [X] Lichtsteuerung
- [X] Wecker implementieren
- [X] Timer implementieren
- [ ] Doku und Git anpassen
- [ ] Installationsscript


## Dokumentation
The documentation is created in form of GitHub pages following the official documentation:  
[installation guide](https://ip-team4.intia.de/)
Please follow the steps under Startup from top to down.

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