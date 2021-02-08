---
layout: default
title: Installation
has_children: true
parent: Auto installation
grand_parent: Installation
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Autoinstall script

## 1. Setup raspberry pi
First make sure you installed the raspberry and it's operating system correctly with the user ``pi``.

## 2. Run the installation script
Download this script you can [download](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/scripts/installAll.sh) it manual
and start it. Use this command:
```
wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/installAll.sh
chmod +x installAll.sh
./installAll.sh
```

## 3. During installation
This installation requires some user inputs. So you will be asked for a password really early.
And it is required to press enter after every installation part.
Your raspberry also will restart and continue the script after relogin.

Answer the questions like following:
* Choose your language! Type en for english or de for german: (en/de)
* What assistant engine are you using? Enter 2 for rhasspy
* What's the path to your assistant config file? Press Enter 
(Path Should be like (_/home/pi/.config/rhasspy/profiles/de/profile.json_)
* What device do you wish to control with SLC? Enter 2 for respeaker4
* What pattern do you want to use? Choose your prefered Led pattern. For example 1 for google
* Do you need to install / configure your respeaker4? Enter 2 for no 

## 4. Next steps
All necessary software is now installed on your Raspberry Pi. Now you need to make a few configurations:

- Set a [wakeword](/pages/installation/manual/configuration.html#3-wake-word)
- Add [zigbee devices](/pages/knowledge/zigbee/zigbee2mqtt)

Depending if you choosed english or german in the installation script, all skills will be automatically installed
in this language.

The [skills](/pages/skills/) itself are realized as flows in node-red. Visit node-red application 
under http://ip_of_raspberry_pi:1880/

After connecting your zigbee devices, you can use them inside the flows.
For example you added a zigbee lamp called "livingroom". Open http://ip_of_raspberry_pi:1880/, open the flow
"Light Control" and double click on the node "zigbee2mqtt/licht/set". `licht` is actually the device name. 
Change it to `livingroom` and click `deploy` on the top right corner of the page. After this your light should
turn on or off depending on your command.

## 5. Finish!

Congratulations! Finished the installation of rhasspy!