---
layout: default
title: Mozilla TTS
parent: TTS
grand_parent: Knowledge
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Important this is not working on the Raspberry Pi!

# Mozilla TTS
Mozilla TTS is the counter part to deepspeech. Mozilla TTS is build on a neural network, and gets really impressive 
results. During implementation we find out that Mozilla TTS runs too slow on an Raspberry.

# Pros
- Good pronunciation
- Clear and fluid language
- A pretrained german model with a male voice is available
- It’s possible to create an own dataset with an own voice (24h audio files are needed)

# Cons
- It's not fast, it runs *really really slow* on a Raspberry Pi for the weather forecast it takes 1 minutes and 17 seconds to answer.
- The most datasets are in english (only one German)
- When you want to train your own dataset it takes long time
- It can not read long text. When the text is to long it starts to stutter and whisper.


# Install 
## Auto Linux x86/x64
The automatic installation only worked for linux x86 or x64 and NOT on armv:
```bash
git clone https://github.com/Sh4der/MQTTMozillaTTSGerman
mkdir .venv
virtualenv -p python3 .venv
source .venv/bin/activate
chmod +x ./setup.sh
./setup.sh
MQTTMozillaTTSGerman --tts_model /home/pi/.config/rhasspy/profiles/de/TTS/tts_model.pth.tar --tts_config /home/pi/.config/rhasspy/profiles/de/TTS/config.json --vocoder_model /home/pi/.config/rhasspy/profiles/de/TTS/vocoder_model.pth.tar --vocoder_config /home/pi/.config/rhasspy/profiles/de/TTS/config_vocoder.json
```

## Manual for testing arm
This manual installation for armv. There is no service or something similar. Actually it's only for testing:
Download MQTTMozillaTTSGerman:
```bash
git clone https://github.com/Sh4der/MQTTMozillaTTSGerman
mkdir .venv
virtualenv -p python3 .venv
source .venv/bin/activate
```
Build pytorch:
```bash
# Download the repository anc checkout v1.5.0
git clone https://github.com/pytorch/pytorch
cd pytorch 
git checkout tags/v1.5.0
git submodule update --init --recursive

# Install all libraries
sudo apt install libopenblas-dev libblas-dev m4 cmake cython python3-dev python3-yaml python3-setuptools libatomic-ops-dev
pip install pyyaml
# Add libatomic-ops-dev to the linker
sed -i '/set(CMAKE_EXPORT_COMPILE_COMMANDS ON)/a set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -latomic)' CMakeLists.txt
# Setup build parameter
export NO_CUDA=1
export NO_DISTRIBUTED=1
export NO_MKLDNN=1
export BUILD_TEST=0
export MAX_JOBS=4
export NO_NNPACK=1
export NO_QNNPACK=1

# Build
python setup.py build
# Install 
python setup.py install

# Build wheel file
# setup.py bdist_wheel
# Install wheel file
# pip install dist/*
```

Go back to the MQTTMozillaTTSGerman folder:
```bash
cd <path to MQTTMozillaTTSGerman folder>
```

Now download Mozilla TTS:
```bash
git clone http://github.com/mozilla/TTS
cd TTS
git checkout 540d811
pip install -r requirements.txt
pip install .
```

Go back to the MQTTMozillaTTSGerman folder:
```bash
cd <path to MQTTMozillaTTSGerman folder>
```

Install other requirements:
```bash
pip install -r requirements.txt
```

Now download the dataset:
```bash
gdown --id 1VG0EI7J6S1bk3h0q1VBc9ALExkdZdeVm -O tts_model.pth.tar
gdown --id 1s1GcSihlj58KX0LeA-FPFvdMWGMkcxKI -O config.json
gdown --id 1zYFHElvYW_oTeilvbZVLMLscColWRbck -O vocoder_model.pth.tar
gdown --id 1ye9kVDbatAKMncRMui7watrLQ_5DaJ3e -O config_vocoder.json
```

You can start it with this command:
```bash
./MQTTMozillaTTSGerman --tts_model ./tts_model.pth.tar --tts_config ./config.json --vocoder_model ./vocoder_model.pth.tar --vocoder_config ./config_vocoder.json
```









