---
layout: default
title: Intent Handling
parent: Knowledge
nav_order: 6
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Intent Handling
After intent recognition Rhasspy can send a JSON to another System. 
Rhasspy is able to  
* call a custom program
* send a POST request to a Rhasspy Remote HTTP Server 
* Home Assistant.

## External Command
This is for you if you want to handle the intent with an external program, for example an shell script or a python script ore something else.
The intent JSON will be handed over to the program by using the Standard In. The output JSON should be put on the Standard Out.
To use an external command for intent handling merge this in you [profile.json](/pages/knowledge/profiles):
```json
"handle": {
  "system": "command",
  "command": {
      "program": "/path/to/program",
      "arguments": []
  }
}
```
Here are some example scripts: [handle.sh](https://github.com/synesthesiam/rhasspy/blob/master/bin/mock-commands/handle.sh), [handle.py](https://github.com/synesthesiam/rhasspy/blob/master/bin/mock-commands/handle.py).

## Remote HTTP Server 
This method is for you, when you want to use a http server for intent handling. You POST a JSON file and the server returns the answer JSON file.
When you want to use it merge this into your [profile.json](/pages/knowledge/profiles):
```json
"handle": {
  "system": "remote",
  "remote": {
      "url": "http://<address>:<port>/path/to/endpoint"
  }
}
```

## Home Assistant
This is maybe the best solution for this project. With Home Assistant you can handle the intents easy with yaml scripts.
It's easy to setup and there is also an app for your smartphone available, so you can control your home very easy with your smartphone.
To install it merge this into your [profile.json](/pages/knowledge/profiles):
```json
"handle": {
  "system": "hass"
},

"home_assistant": {
  "access_token": "",
  "api_password": "",
  "event_type_format": "rhasspy_{0}",
  "url": "http://hassio/homeassistant/"
}
```
