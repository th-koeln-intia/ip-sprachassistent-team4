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
| Speech to Text                  | DeepSpeech         | Hard without experience* | easy              | medium    | high       |
| LED Control                     | Hermes LED Control | Medium                   | easy              | good      | none       |
| Text to Speech                  | Mozilla TTS        | Hard                     | easy              | bad       | medium     |
| Text to Speech                  | Nano TTS           | Easy                     | easy (in Rhasspy) | good      | none       |
| Intent Handling                 | Node-RED           | Easy                     | easy              | medium    | low        |
| Wake Word                       | Raven              | Easy                     | easy (in Rhasspy) | good      | low        |
| Set of voice assistant services | Rhasspy            | Easy                     | easy              | medium    | none       |
| Microphone                      | ReSpeaker          | Medium                   | none              | good      | none       |
| Intent Recognition              | Snips-NLU          | Hard without experience  | medium            | good      | low        |

*as for german pretrained model