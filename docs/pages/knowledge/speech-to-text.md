---
layout: default
title: Speech to text
parent: Knowledge
nav_order: 4
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Speech To text
The concept behind Speech To Text (STT) is the conversion from spoken word into text.
There are some STT systems, for example Pocketsphinx, Kaldi, DeepSpeech, Remote HTTP Server, External Command.
In this project we focus on DeepSpeech. 

## DeepSpeech
DeepSpeech combines the acoustic model and pronunciation dictionary into a single neural network. It still uses a 
language model.
- Acoustic Model: Maps acoustic/speech features to likely phonemes in a given language
- Pronunciation Dictionary: Needed to train an acoustic model and to do speech recognition
- Grapheme to phoneme (G2P Model): Can be used to guess the phonetic pronunciation of words
- Language Model: Helps to give a probability how often some words follow other. The probability is based on heuristic
- Sentence Fragments: The language model does not contain probabilities for entire sentences only sentence fragments. 
To get the entire word the speech recognizer requires a few tricks
- Language Model Training: The main goal is to generate a language model based on the intent graph obtained during the 
initial stage of training
- Language Model Mixing: Possibility to mix the language with a pre-built model

### Silence Detection
If you want to optimize the recognition of your Wake Word, you can adjust these options in your profile:

```JSON
  "command": {
    "webrtcvad": {
      "skip_sec": 0,
      "min_sec": 1,
      "speech_sec": 0.3,
      "silence_sec": 0.5,
      "before_sec": 0.5,
      "vad_mode": 3
    }
  }
}
```

* `skip_sec` is how many seconds of audio should be ignored before recording
* `min_sec` is the minimum number of seconds a voice command should last
* `speech_sec` is the seconds of speech before a command starts
* `silence_sec` is the seconds a silence after a command before ending
* `before_sec` is how many seconds of audio before a command starts are kept
* `vad_mode` is the sensitivity of speech detection (3 is the least sensitive)
