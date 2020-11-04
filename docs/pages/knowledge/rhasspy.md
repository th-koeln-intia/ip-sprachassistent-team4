# What is Rhasspy ?
Rhasspy is an open source, fully offline voice assistant toolkit.
Rhasppy core component can be taken done to speech and intent.
# Speech to test
this is the primary function of rhasppy and allowed rhasspy to convert a voice command to a Json event
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


# Test_to_speech
the input of a voice command will produce an output to the user if the voice command is regognized.
the are different test to speech system and the command one , which can produce output in  different language is espeak. A part from that we have also : flite (only in english),picotts, nanotts,marytts,opentts,wavenet.

# intent handling
after a sucessful regognation of intent, rhasppy will send a Json even to a home Assistant or  a remote rhasspy server.
Intent handling sytems are : Home Assistant, Remote HTTp Server, external command. Rhasapy pubishes intent over MQTT protokol.

# intent regognition

the voice command is transcribed from Test_to_speech system and after that the intent needs to be regognized and as result, the rhasppy will produced a JSON event. The are different intent regognition system .
Fsticuffs (if you plan  to regognize the voice from your training set, this will be the best), Fuzzywuzzy, Snips NLU (NLU -> Natural Language Understanding), RasaNLU, Mycroft Adapt (Not supported yet in 2.5), Flair (also not supported in 2.5), Home Assistant Conversation(Not supported in 2.5), command and dummy.

# Wake Word
use to activate the voice assistant. also called "hot word".
Rhasppy can listening to a wake world throught differents systems. It is also possible to wake rhaspy with a HTTP Post verb. the best system is Porcupine.

# MQTT
MQTT is an OASIS standard messaging protocol for the Internet of Things (IoT). It is designed as an extremely lightweight publish/subscribe (one to many BI directional communication) messaging transport that is ideal for connecting remote devices with a small code footprint and minimal network bandwidth. It has tree level of quality of services, support for unreliable network and security enable.

# voice assistant

Voice assistants are already being used in multiple different ways and industries: They are used in smartphones and smartspeakers, in mobile apps and operating systems, in cars, in sales, in medical care, and telecommunications.
Base on an input (mostly as voice command) , the voice assistant will product an ouput which can be in form of a voice or trigger an action.
There are differents voice assistant such as Siri, Alexa and google Home.
These voice assitants mentioned above  use internet to store the date on cloud and many  people are concerned about how save they are. 
Other voice assistants like Rhasspy, Jasper, etc.. are able to work without sharing our data over internet and these are very interesting for people who are concerned about the privacies.a
