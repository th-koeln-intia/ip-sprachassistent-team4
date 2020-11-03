---
title: WakeWord
permalink: /knowledge/wakeword
subtitle: Demo page with a menubar
layout: page
show_sidebar: false
menubar: navigation
---

# Wake Word

## What is a Wake Word?
A Wake Word is a word, for example a name, to wake a Voice Assistant. After you wake up a voice assistant you can give it a task to proceed.

## How does Rhasspy listen to a Wake Word?
Rhasspy itself won't listen to a wake word. It listens for MQTT messages on `'hermes/hotword/<wakeword>/detected'`.
You can disable/enable the wake word with the message `'hermes/hotword/toggleOff'`

## Who sets the `'hermes/hotword/<wakeword>/detected` Message'?
There are many programs for wake word handling, like Raven, porcupine, snowboy, mycroft precide, pocketsphinx.
But in this project we are using Raven for the wake word processor. With Raven you can train a wake word only with 3 Waf file (16-bit 16Khz) templates. 
You can record them with Audacity. They must be exported in the folder `'raven/default'`.

## Add Raven to Rhasspy
To add Raven to Rhasspy you must edit your user profile. Add this to your user profile:  
```
"wake": {
  "system": "raven",
  "raven": {
    "probability_threshold": 0.5,
    "minimum_matches": 1,
    "average_templates": true
  }
}
```
### Here you now have 3 new settings:

`raven.probability_threshold`: Is a value in the range between [0, 1]. With this option you adjust the sensitivity of raven. the lower the value is the more sensitive Raven reacts.

`minmum_matches`: Here you can setup how many wav templates needs to match for wake word detection.

`average_templates`: This option can be true or false. If it's true the wav templates will be merged into one wav template. This will reduce CPU usage.

## Multible Wake Words
Raven supports many wake words. The templates for the default keyword is set in the `'raven/default'` folder. All the default settings in the user profiles will be applied.
The templates for the other wake words are positioned in `'raven/<keyword>'`.   
You can also refine the settings for any keyword(wakeword).   
Here is an example:  
```
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

The three dots are the default settings fom above. All additional options, specified in the keyword object overrides the default settings.

