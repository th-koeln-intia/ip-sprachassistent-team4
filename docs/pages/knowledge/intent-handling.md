---
layout: default
parent: Knowledge
nav_order: 6
---

# Intent Handling

After the intent recognition the json must be interpreted, to do what the internt is made for. Rhasspy knows three methods to do this.
It's tasks like turn the light on, how cold is it outside or how is the weather. When an intent appears, you can use an external command to proceed it or a remote HTTP server
or you can use Home Assistant.

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
