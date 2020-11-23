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

# Speech to text

## DeepSpeech
DeepSpeech combines the acoustic model and pronunciation dictionary into a single neural network. It still uses a 
language model, however.
- Acoustic Model : Maps acoustic/speech features to likely phonemes in a given language
- Pronouciation Dictionary : Needs to train an acoustic model and to do speech recognition
- Grapheme to phoneme (G2P Modell) : Can be used to guess the phonetic pronunciation of words
- Language Model : Helps to give a probality how often some words follow other and the probability is based on heuristic
- Sentence Fragments : The language model does not contain probabilities for entire sentences, only sentence fragements
and to get the entire word, the speech recognizer requires a few tricks
- Language Model Training : The main goal ist to generate a language model bases on the intent graph obtained during the 
initial stage of training
- Language Model Mixing : Possibility to mix the language  with a Pre-built model
