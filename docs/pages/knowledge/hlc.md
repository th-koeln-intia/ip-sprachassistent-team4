---
layout: default
title: Hermes LED Control
parent: Knowledge
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Hermes LED Control

HLC (Hermes LED Control) is a tool, that subscribes various topics, to react with visual 
effects on the ReSpeaker. For example if a hotword is detected  HLC will trigger a LED 
effect to show the user that rhasspy listens for a command.

# Installation
HLC is originally from [project alice](https://github.com/project-alice-assistant/HermesLedControl) you can install it with a script from [Psychokiller1888](https://gist.github.com/Psychokiller1888/a9826f92c5a3c5d03f34d182fda1ce4c). We edited this script so we only use the version v2.0.10. The newer version does not work as expected.
Our version you can find [here](https://gist.github.com/Sh4der/8476895a0863ca6062103315ac122954).

### Go to pi's home directory
{: .no_toc }
```bash
cd ~
```

### Download script
{: .no_toc }
```bash
wget https://gist.github.com/Sh4der/8476895a0863ca6062103315ac122954/raw/f5c83b34eaafbd0b315d17282c1fc52b672e008a/hlc_download.sh
```

### Make the script executable
{: .no_toc }
```bash
sudo chmod +x hlc_download.sh
```

###  Execute the script
{: .no_toc }
```bash
sudo ./hlc_download.sh
```

Answer the questions like following:
* What assistant engine are you using? Enter 2 for rhasspy
* What's the path to your assistant config file? **Type in your path to your profile.json. The default path is this: `/home/pi/.config/rhasspy/profiles/de/profile.json`**
* What device do you wish to control with SLC? Enter 2 for respeaker4
* What pattern do you want to use? Choose your prefered Led pattern. For example 1 for google
* Do you need to install / configure your respeaker4? Enter 2 for no 

Later you will configure Rhasspy to work with Hermes Led Control.

[Read more about Hermes Led Control](https://github.com/project-alice-assistant/HermesLedControl/wiki){:target="_blank"}