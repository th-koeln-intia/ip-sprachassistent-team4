# What is Rhasspy ?
Rhasspy is an open source, fully offline voice assistant toolkit.
Rhasppy core component can be taken done to speech and intent.
# Speech to test
The offline transcription of voice commands in Rhasspy is handled by one of three open source systems :

- Pocketsphinx
- Kaldi
- DeepSpeech (we will follow this step in our team)

### DeepSpeech
DeepSpeech combines the acoustic model and pronunciation dictionary into a single neural network. It still uses a language model, however.
- Acoustic Model : maps acoustic/speech features to likely phonemes in a given languag
- Pronouciation Dictionary : needs to train an acoustic model and to do speech recognition
- Grapheme to phoneme (G2P Modell) : can be used to guess the phonetic pronunciation of words
- Language Model : helps to give a probality how often some words follow other and the probability is based on heuristic
- Sentence Fragments : The language model does not contain probabilities for entire sentences, only sentence fragements and to get the entire word, the speech recognizer requires a few tricks
- Language Model Training : the main goal ist to generate a language model bases on the intent graph obtained during the initial stage of training
- Language Model Mixing : possibility to mix the language  with a Pre-built model
 

# Text to Intent
The speech recognition system(s) in Rhasspy produce text transcriptions that are then given to an intent recognition system. When both *speech* and *intent* systems are trained together from the same template file, all valid commands (with minor variations) should be correctly translated to JSON events.
