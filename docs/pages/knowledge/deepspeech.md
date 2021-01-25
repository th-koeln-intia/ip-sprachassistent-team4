---
layout: default
title: Deepspeech
parent: Knowledge
---

# Deepspeech

# Why this topic?
Deespspeech is not working if you let rhasspy doing the setup for it. Rhasspy installs the deepspeech version 0.6.1. 
After you installed it, rhasspy downloads the language model and trains the model with your sentence.ini.
When you train deepspeech you maybe find this error message in the rhasspy log (``sudo journalctl -fu rhasspy``):
```
 Reading /tmp/tmpkyyqii0l
Dec 07 10:26:46 raspberrypi rhasspy[20549]: ----5---10---15---20---25---30---35---40---45---50---55---60---65---70---75---80---85---90---95--100
Dec 07 10:26:46 raspberrypi rhasspy[20549]: The ARPA file is missing <unk>.  Substituting log10 probability -100.
Dec 07 10:26:46 raspberrypi rhasspy[20549]: ****************************************************************************************************
Dec 07 10:26:46 raspberrypi rhasspy[20549]: SUCCESS
```
This means, that the tool rhasspy-asr-deespeech fails to generate the arpa file and then fails load it to generate a new model.
If you ignore this message and say something you get this message in the log:
```
Dec 07 10:45:10 raspberrypi rhasspy[20549]: [DEBUG:2020-12-07 10:45:10,607] rhasspyasr_deepspeech_hermes: Transcribing 62444 byte(s) of audio data
Dec 07 10:45:10 raspberrypi rhasspy[20549]: [DEBUG:2020-12-07 10:45:10,609] rhasspyasr_deepspeech.transcribe: Loading model from /home/pi/.config/rhasspy/profiles/de/deepspeech/model/0.6.1/output_graph.pb (beam width=500)
Dec 07 10:45:10 raspberrypi rhasspy[20549]: TensorFlow: v1.14.0-21-ge77504a
Dec 07 10:45:10 raspberrypi rhasspy[20549]: DeepSpeech: v0.6.1-0-g3df20fe
Dec 07 10:45:10 raspberrypi rhasspy[20549]: ERROR: Model provided has model identifier 'inpu', should be 'TFL3'
Dec 07 10:45:10 raspberrypi rhasspy[20549]: Error at reading model file /home/pi/.config/rhasspy/profiles/de/deepspeech/model/0.6.1/output_graph.pb
Dec 07 10:45:10 raspberrypi rhasspy[20549]: [ERROR:2020-12-07 10:45:10,611] rhasspyasr_deepspeech_hermes: transcribe
Dec 07 10:45:10 raspberrypi rhasspy[20549]: Traceback (most recent call last):
Dec 07 10:45:10 raspberrypi rhasspy[20549]:   File "rhasspyasr_deepspeech_hermes/__init__.py", line 319, in transcribe
Dec 07 10:45:10 raspberrypi rhasspy[20549]:   File "rhasspyasr_deepspeech/transcribe.py", line 42, in transcribe_wav
Dec 07 10:45:10 raspberrypi rhasspy[20549]:   File "rhasspyasr_deepspeech/transcribe.py", line 139, in maybe_load_model
Dec 07 10:45:10 raspberrypi rhasspy[20549]:   File "deepspeech/__init__.py", line 42, in __init__
Dec 07 10:45:10 raspberrypi rhasspy[20549]: RuntimeError: CreateModel failed with error code 12288 
```
Here you can see, that rhasspy_deepspeech starts transcribing and trys to load the language model in out_graph.pb.
You see, it fails and the first error already tells us the problem. The loaded Model has the wrong identifier, it should be ``TFL3`` and not ``inpu``.
This means that the model rhasspy downloaded is not valid for rhasspberry pi. The Raspberry Pi is runnig with ``Tensorflow lite'' which identifier is ``TFL3``.
the ``Tensorflow lite`` model file ends with ``*.tflite'' and the normal with ``*.pb`` or ``*.pbmm``

# Possible solutions
 - [The first solution is to find a german language model for version 0.6.1](#the-first-solution-is-to-find-a-german-language-model-for-version-061)
 - [The second solution is to train an own model](#the-second-solution-is-to-train-an-own-model)
 - [The third solution is to port a newer version of deepspeech to rhasspy](#the-third-solution-is-to-port-a-newer-version-of-deepspeech-to-rhasspy)

## The first solution is to find a german language model for version 0.6.1
There are many language models for deepspeech, but to find a pretrained german model for the right version is really hard. 
I found two webpages with pretrained german models : [AASHISHAG/deepspeech-german](https://github.com/AASHISHAG/deepspeech-german) [Jaco-Assistant/deepspeech-polyglot](https://gitlab.com/Jaco-Assistant/deepspeech-polyglot)
But there is no version for deepspeech 0.6.1. You can search for yourself, maybe you are luckier than I.

## The second solution is to train an own model
You can also try to train your own Language Model. So the goal is to create from voice files a model deepspeech can use to understand voice.
I don't want to explain how this work, you can look in the [Documentation of Deepspeech](https://deepspeech.readthedocs.io/en/v0.6.1/TRAINING.html) for version 0.6.1, 
there is a description how to train your own model. You also need one ore more german datasets to train your model the german language.
There are many free german Datasets available, you can take a look on [this](https://gitlab.com/Jaco-Assistant/deepspeech-polyglot) repository, 
there are many german datasets listed.
I tried to train a german model with this documentation, setup everythnig and downloaded the ``Mozilla Common Voice German`` dataset.
I ended up with 3 days only converting ``*.tsv`` files to ``*.csv``. The dataset was all on a ssd. The dataset folder expands from 20gb to round about 160gb.
It took too long for me so I interrupted this process and deleted the folder. When you think you have a **really** fast(I mean **really really really** fast)
Computer you can try it yourself. Good luck!

## The third solution is to port a newer version of deepspeech to rhasspy
I chose to use one of there datasets: [AASHISHAG/deepspeech-german](https://github.com/AASHISHAG/deepspeech-german).
The user [AASHISHAG](https://github.com/AASHISHAG/) combined many datasets to train the datasets for deepspeech.
There are two possible datasets >0.6.1, the version 0.9.0 with a total dataset length of 3172h and a dataset for version 0.7.4 with a dataset length of 2924h.
I decided to test both deepspech versions first starting with version 0.9.0.
Please make sure that you use python3 either with an python3 virtual enviroment or python3 direkt.

So I downloaded deepspeech 0.9.0:
```bash
pip install deepspeech==0.9.0
```
Recorded an example text:
```bash
arecord -q -D ac108 -r 16000 -f S16_LE -c 1 audio_input.wav
```
And fed it to deepspeech with the dataset for 0.9.0:
```bash
deepspeech --model deepspeech-0.9.0-models.tflite --scorer deepspeech-0.9.0-models.scorer --audio audio_input.wav
```
And this was the result:
```
Loading model from file deepspeech-0.9.0-models.tflite
TensorFlow: v2.3.0-6-g23ad988
DeepSpeech: v0.9.0-0-g2d04fbe
Segmentation fault
```
Segmentation fault errors are mostly very tricky, so I skipped deepspeech 0.9.0 and tried the same with deeospeech 0.7.4.
So I downloaded deepspeech 0.7.4:
```bash
pip install deepspeech==0.7.4
```
And fed the example again to deepspeech with the dataset for 0.7.4:
```bash
deepspeech --model deepspeech-0.7.4-models.tflite --scorer deepspeech-0.7.4-models.scorer --audio audio_input.wav
```
And this was the result:
```
Loading model from file deepspeech/deepspeech_models/release_v0.7.4/output_graph.tflite
TensorFlow: v1.15.0-24-gceb46aa
DeepSpeech: v0.7.4-0-gfcd9563
Loaded model in 0.00218s.
Loading scorer from files deepspeech/deepspeech_models/release_v0.7.4/kenlm.scorer
Loaded scorer in 0.000544s.
Running inference.
das ist ein test
Inference took 1.874s for 2.250s audio file.
```
You see everything works fine. The text I said was transcripted successfull.

The version 0.7.4 of deepspeech seems to work well.

Now we know the which version works fine with the german language model, but how does ``Rhasspy`` communicate with deepspeech?

Rhasspy is using to control many all services including [STT](pages/knowledge/speech-to-text) and deepspeech.
The mqtt client for deepspeech is the program [rhaspy-asr-deepspeech-hermes](https://github.com/rhasspy/rhasspy-asr-deepspeech-hermes).
And the program uses this libary: [rhasspy-asr-deepspeech](https://github.com/rhasspy/rhasspy-asr-deepspeech).

[Rhaspy-asr-deepspeech-hermes](https://github.com/rhasspy/rhasspy-asr-deepspeech-hermes) submits to the ``startListening`` and ``textCaptured`` and other topic.
And communicates through the [rhasspy-asr-deepspeech](https://github.com/rhasspy/rhasspy-asr-deepspeech) with deepspeech.

## Changes from deepspeech 0.6.1 to deepspeech 0.7.4
There are 3 important changes between deepspeech 0.6.1 and deepspeech 0.7.4.

- The first change is the file format of the language model:    
In deepspeech 0.6.1 the language model is seperated in three files, the outer_graph.pb or outer_graph.tflite, the lm.binary and a trie file.
And in deepspeech 0.7.4 the language model is only seperated in two files the outer_graph.pb or outer_graph.tflite and a scorer file.
The scorer file is build with a trie and lm.binary file, so it is only a combined file of them two.
- The Python API has also changed [0.6.1](https://deepspeech.readthedocs.io/en/v0.6.1/Python-API.html) / [0.7.4](https://deepspeech.readthedocs.io/en/v0.7.4/Python-API.html):
  -  The ``class Model`` is splittet up in two classes in ``class Model(*args, **kwargs)`` an in ``class Stream(native_stream)`` so the part to transcribe Streams is seperated in an own class.
  - ``enableDecoderWithLM(*args, **kwargs)`` splitted in ``enableExternalScorer(scorer_path)`` and ``setScorerAlphaBeta(alpha, beta)``
- The Metadata returned by sttWithMetadata(audio_buffer, num_results=1) has changed. [0.6.1](https://deepspeech.readthedocs.io/en/v0.6.1/Python-API.html#metadata) / [0.7.4](https://deepspeech.readthedocs.io/en/v0.7.4/Python-API.html#metadata)

### Changes in rhasspy-ar-deepspeech and rhasspy-asr-deepspeech-hermes
I adapt ``rhasspy-asr-deepspeech`` and ``rhasspy-asr-deepspeech-hermes`` so they can use deepspeech 0.7.4. I forked the original repositories and did some changes. 
You can find them here: [Sh4der/rhasspy-asr-deepspeech-hermes](https://github.com/Sh4der/rhasspy-asr-deepspeech-hermes), 
[Sh4der/rhasspy-asr-deepspeech](https://github.com/Sh4der/rhasspy-asr-deepspeech)

## How to create a scorer from a vocabular file
Please make sure you work with python3 in a virtual enviroment or with pip3.

First download the prebuild binaries and install all dependencies: 
```bash
wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/docs/tools/deepspeech_train_tools.tar.gz
```
These binaries are only for raspberry, or on other armv7 platforms.     

Now unpack it with:
```bash
tar xvfz deepspeech_train_tools.tar.gz
```
And go into it:
```bash
cd tools
```

Before you can run any of these binaries you need to install some dependencies:
```bash
sudo apt install llvm libfst-tools libngram-tools
pip install progressbar2==3.47.0
pip install tools/packages/*.whl
```
The tools and the dependencies are now installed, you can start to create a scorer file.

Now get out your vocabulary file. First we create a lm.binary, a vocab5000.txt.
```bash
mkdir out
python generate_lm.py --input_txt vocabulary.txt --output_dir out --top_k 500000 --kenlm_bins kenlm/   --arpa_order 5 --max_arpa_memory "50%" --arpa_prune "0|0|1" --binary_a_bits 255 --binary_q_bits 8 --binary_type trie --discount_fallback
``` 
Additional you need an alphabeth.txt, it should be a german one(with ä, ü, ö, etc.), you can get one from here 
[AASHISHAG/deepspeech-german](https://github.com/AASHISHAG/deepspeech-german) from the google drive for
deepspeech 0.7.4. 

Or with this command: 
```
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1zIvpdJ0YOreg_HwVwoyt_6BEEusH5g4w' -O ./alphabet.txt
```
Now you can create a scorer file:
```bash
python3 generate_package.py --alphabet alphabet.txt --lm out/lm.binary --vocab out/vocab-500000.txt --package kenlm.scorer --default_alpha 0.931289039105002 --default_beta 1.1834137581510284
```

## Build tool binaries from source and create the tools folder
${WORK} is the work directory you are working in.
${TOOLSFOLDER} is the folder where the tools will be saved.
### First get the Deesepeech source code for version 0.7.4:
```bash
git clone https://github.com/mozilla/DeepSpeech.git
cd Deepspeech
git rm -rf .
git checkout tags/v0.7.4 .
cd ${WORK}
```
Copy the generate_lm.py and the generate_package.py to the ${TOOLSFOLDER}:
```bash
cp ${WORK}/DeepSpeech/data/lm/generate_lm.py ${TOOLSFOLDER}/generate_lm.py
cp ${WORK}/DeepSpeech/data/lm/generate_package.py ${TOOLSFOLDER}/generate_package.py
```
You also need to build kenlm it's used to create the scorer file.

### Build Kenlm
Kenlm is used to generate the language model.
First you need these packages:
```bash
sudo apt install cmake libeigen3-dev libboost-all-dev
```
Now you can build Kenlm:
```bash
git clone https://github.com/kpu/kenlm
cd kenlm
mkdir build
cmake ..
make
```
Now copy the binary of kenlm to ${TOOLSFOLDER}:
```bash
mkdir ${TOOLSFOLDER}/kenlm/
cp -r ${WORK}/kenlm/build/bin/* ${TOOLSFOLDER}/kenlm/
```

### Build ctc_decoder
First install dependencies:
```bash
sudo apt install sox libsox-fmt-mp3 libsox-dev
```
You also need swig 4.0.2, the version on apt is 3.0.12, so you need to build it yourself.
```bash
wget http://prdownloads.sourceforge.net/swig/swig-4.0.2.tar.gz
tar xvfz swig-4.0.2.tar.gz
cd swig-4.0.2
./configure
make
sudo make install
```
Swig 4.0.2 is now installed, you can now continue with ctc_decode.
Switch the directory:
```bash
cd ${WORK}/DeepSpeech/native_client/ctcdecode
```
When you are on a raspberry Pi ow want to build for a raspberry pi please change the variable PYTHON_PLATFORM_NAME in ${WORK}/DeepSpeech/native_client/definitions.mk from
this:
```bash
PYTHON_PLATFORM_NAME := --plat-name manylinux1_x86_64
```
to this:
```bash
PYTHON_PLATFORM_NAME := --plat-name linux_armv7l
```

Now you can continue with building ctcdecode:
```bash
make bindings NUM_PROCESSES=4
```
In the ``dist`` directory is now a wheeler file, just copy it to the ``${TOOLSFOLDER}``.
```bash
mkdir ${TOOLSFOLDER}/packages
cp dist/* ${TOOLSFOLDER}/packages
```
Yeahhy, you build ctcdecoder!!
Please go back to the ${WORK} folder:
```bash
cd ${WORK}
```

### Build deepspeech_training
This module is used by generate_package.py. An you can build it really easy:
```bash
cd DeepSpeech
python setup.py bdist_wheel -d  .
cp deepspeech_training-0.7.4-py3-none-any.whl ${TOOLSFOLDER}/packages
```
Deepspeech_training is now build and copied to ${TOOLSFOLDER}. Don't forget to go back to ${WORK}.

### Build tensorflow 1.15.4
Deepspeech_training requires tensorflow 1.15.2, which can't be installed with pip.
For the tools binary I use the binary from [here](https://github.com/Qengineering/TensorFlow-Raspberry-Pi/raw/master/tensorflow-1.15.2-cp37-cp37m-linux_armv7l.whl).
I used a precompied binary because I had no success to build it.

But you can try to build it for yourself:
I used this to build it from source. Please make sure you have docker installed.
To build the tensorflow package for raspberry, type these commands:
```bash
git clone https://github.com/tensorflow/tensorflow
git rm -rf .
git checkout tags/v1.15.2 .
tensorflow/tools/ci_build/ci_build.sh PI-PYTHON37 \
    tensorflow/tools/ci_build/pi/build_raspberry_pi.sh
cp ${WORK}/tensorflow/tensorflow-0.15.2-cp35-none-linux_armv7l.whl
```
I used this description: [tensorflow.org](https://www.tensorflow.org/install/source_rpi#python-3.7)


# Links to our rhasspy-asr repositories
- [rhasspy-asr-deepspeech](https://github.com/Sh4der/rhasspy-asr-deepspeech)
- [rhasspy-asr-deepspeech-hermes](https://github.com/Sh4der/rhasspy-asr-deepspeech-hermes)






