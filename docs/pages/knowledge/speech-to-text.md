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

## MQTT API
When the MQTT message ``hermes/asr/startListening`` with a ``sessionID`` is send the STT starts listening on the 
audio frame at ``hermes/audioServer/<siteId>/audioFrame``. 
When silence is detected the message ``hermes/asr/stopListening`` is send with the same ``sessionID`` as in the ``hermes/asr/startListening`` message.
The transcripted text a is send with the Message ``hermes/asr/textCaptured``, it's in the text attriubute. When an error occured, the STT publishes the message ``hermes/error/asr``

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

### Open Transcription
By default deepspeech only knows the words you wrote in the sentence.ini. For us it's sufficient to recognice the 
intents of the user. But when you want to add a chat functionality to your voice assistant it would be good to be 
able to transcript open text and not only the words in the sentence.ini. You can activate the open transcription, 
by set ``speech_to_text.deepspeech.open_transcription`` ìn your profile.json to ``true``, or by check the checkbox 
for open transcription the rhasspy settings menu under text to speech.    
When you restart your rhasspy now, rhasspy ask you to download 2GB of data. After it's done, Rhasspy starts the training, 
and the opentranscription is available. 

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
