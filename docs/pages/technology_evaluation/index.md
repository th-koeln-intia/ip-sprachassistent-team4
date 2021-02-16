---
layout: default
title: Technology Evaluation
has_children: true
nav_order: 5
---

# Technology Evaluation
This section of the documentation is about the technology evaluation of the software we used and partly tested. 
After a short explanation, we highlight the advantages and disadvantages of the respective software. We then briefly 
summarise these in a conclusion and supplement this with a personal opinion and experiences.
Each sub-page deals with a separate topic.

# Overview
In addition to the subpages, we evaluate the software used in a clear table.

| Service                         | Technology         | Installation             | Configuration     | Usability | Error rate |
|---------------------------------|--------------------|--------------------------|-------------------|-----------|------------|
| Speech to Text                  | DeepSpeech         | Hard without experience* | Easy              | Medium    | High       |
| LED Control                     | Hermes LED Control | Medium                   | Easy              | Good      | None       |
| Text to Speech                  | Mozilla TTS        | Hard                     | Easy              | Bad       | Medium     |
| Text to Speech                  | Nano TTS           | Easy                     | Easy (in Rhasspy) | Good      | None       |
| Intent Handling                 | Node-RED           | Easy                     | Easy              | Medium    | Low        |
| Wake Word                       | Raven              | Easy                     | Easy (in Rhasspy) | Good      | Low        |
| Set of voice assistant services | Rhasspy            | Easy                     | Easy              | Medium    | None       |
| Microphone                      | ReSpeaker          | Medium                   | None              | Good      | None       |
| Intent Recognition              | Snips-NLU          | Hard without experience  | Medium            | Good      | Low        |
| MQTT broker                     | Mosquitto          | Easy                     | Easy              | Good      | None       |
| Single Board Computer           | Raspberry Pi       | Easy                     | None              | Good      | None       |
| Operating System                | Raspbian           | Easy                     | Medium            | Good      | Medium     |
| Zigbee Adapter                  | CC2531             | Easy                     | None              | Good      | None       |
| Zigbee Adapter                  | ConBee2            | Easy                     | None              | Good      | None       |
| Bridge from Zigbee to MQTT      | Zigbee2MQTT        | Easy                     | Medium            | Medium    | None       |

*as for German pretrained model