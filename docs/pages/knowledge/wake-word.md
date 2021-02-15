---
layout: default
title: Wake Word
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

# Wake Word

## What is a Wake Word?
A Wake Word is a word, for example a name, to wake up a Voice Assistant. After you woke up a voice assistant, you can 
give it a task to proceed.
There are 4 scenarios a program can detect as a Wake Word:
- true positive: The Wake Word was spoken and was detected correctly.
- false negative: The Wake Word was spoken and was not detected by the program.
- false positive: The Wake Word was not spoken, but the program detected a word as the Wake Word.
- true negative: The Wake Word was spoken, and the program does not detect the Wake Word.     

The goal of a Wake Word system is to recognize the Wake Word with the greatest possible precision. So false negative 
and false positive detections are not welcome.

## How does Rhasspy listen to a Wake Word?
Rhasspy itself won't listen to a Wake Word. It listens for MQTT messages on the topic `'hermes/hotword/<Wake Word>/detected'`.
You can disable/enable the Wake Word with the message `'hermes/hotword/toggleOff'`.

## Who sets the `'hermes/hotword/<Wake Word>/detected` message'?
There are many programs for Wake Word handling like Raven, Porcupine, Snowboy, Mycroft precise, Pocketsphinx.
In this project we are using Raven for the Wake Word processor. With Raven, you can train a Wake Word with only 
3 WAV file (16-bit 16Khz) templates. 

## Add Raven to Rhasspy
To add Raven to Rhasspy you must edit your user profile. Add this to your user [profile](https://rhasspy.readthedocs.io/en/latest/profiles/){:target="_blank"}:  
``` json
"wake": {
  "system": "raven",
  "raven": {
    "probability_threshold": 0.5,
    "minimum_matches": 1,
    "average_templates": true
  }
}
```

## How to record a Wake Word
You can record the Wake Word directly in the Rhasspy UI. Open the settings and then click on the drop down button of
Wake Word. The settings of Raven will appear. There are three record buttons. 
You must record your Wake Word three times to create three examples for raven to recognize the Wake Word. We recommend
to record from three different positions of your room where you want to use your voice assistant.

### Settings
After recording you have 3 new settings:
* `raven.probability_threshold`: Is a value in the range between [0, 1]. With this option you adjust the sensitivity 
of Raven. The lower the value is, the more sensitive Raven reacts.
* `minmum_matches`: Here you can set how many WAV templates are needed to match for a Wake Word detection.
* `average_templates`: This option can be `true` or `false`. If it's true, the WAV templates will be merged into one 
WAV template. This will reduce CPU usage.

## Multiple Wake Words
Raven supports multiple Wake Words. The templates for the default keyword is set in the `'raven/default'` folder. 
All the default settings in the users profile will be applied.
The templates for the other Wake Words are positioned in `'raven/<keyword>'`.   
You can also refine the settings for any keyword (Wake Word).   
Here is an example:  
``` json
"wake": {
  "system": "raven",
  "raven": {
      ...

      "keywords": {
          "default": {
              "probability_threshold": 0.4
          },

          "other-keyword": {
              "average_templates": False,
              "minimum_matches": 2
          }
      }
  }
}
``` 

The three dots are the default settings fom above. All additional options, specified in the keyword object overrides 
the default settings.

