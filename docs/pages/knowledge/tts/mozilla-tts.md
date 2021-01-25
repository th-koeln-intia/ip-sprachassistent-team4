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

# Mozilla TTS
Mozilla TTS is the counter part to deepspeech. Mozilla TTS is build on a neural network, and gets really impressive results.

# Pros
- Good pronouncing
- Clear and fluid language
- A pretraing german model is available
- It's possible to create an own dataset with an own voice (24h audio files are needed)
- German male voice for Sherlock

# Cons
- It's not really fast
- The most datasets are in english (only one German)
- When you want to train your own dataset it takes long time
- It can not read long text. When the text is to long it starts to stutter and whisper.


# Install 
We created a MQTTClient for Mozilla TTS here is the installation of it:

```bash
wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/installMozillaTTS.sh
chmod +x installMozillaTTS.sh
./installMozillaTTS.sh
```

# How we build the pytorch 1.5.0 binary
We did this in a virtual enviroment with python 3.7.0!
```bash
# Download the repository anc checkuot v1.5.0
git clone https://github.com/pytorch/pytorch
cd pytorch 
git checkout tags/v1.5.0
git submodule update --init --recursive

# Install all libaries
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
# Build wheel file
setup.py bdist_wheel
# Install the wheelfile
pip install dist/*
```





