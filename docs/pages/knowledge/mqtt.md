---
layout: default
parent: Knowledge
---

# MQTT (Message Queuing Telemetry Transport)

## What is MQTT
MQTT is the communication protoll we use to communicate with all devices in our home system.    
It's based on a publish/subscribe model. There is one Broker in our System and many nodes with unique names, nodes can  
publish messages and subscribe messages. When a node publish a message, it'll be send to the broker.   
The broker sends the message to all nodes that subscibed the message. Messages are normaly not stored by the Broker, the broker only pass the messages to the nodes!

## Impotant things for client name
- Client names MUST be unique.
- When a client appears with the same name as the other. The old will disconnect and the new is connected. But the old will try to connect again. The result is a never ending loop.

## Messages
All message contains a topic(simular to a path), the message data, a QOS (Quality of Service) level and a retain Flag. The retain flag is normaly not set, so the Broker instantly forget the message. If it is set, the broker will remember the last message where the retain flag is set.

## QOS (Quality of Service) level
Mqtt supports 3 diferent levels of QOS:   
- QOS-0 is the default level, there is no garantee that the message will be delivered.   
- QOS-1 Garantees, the delivery of the messages, but there could be duplicates.   
- QOS-3 Garantees, the delivery of the messages. 

## What is a topic?
A topic is the location/name of the message. It identifies it and helps the broker to pass the messages to the clients.   
Topics looks like paths for example `'rhasspy/audioServer/devices)'` or `'house/room/main-light'`.
When you subscribe you can also use wildcards. ` + ` is a single wildcard(replaces one character) and ` # ` is a multi wildcard(replaces many characters).   
When you publish you can't use wildcards.

## Which MQTT topics are supported?
All available topics in rhasspy can be found here: [MQTT API](https://rhasspy.readthedocs.io/en/latest/reference/#mqtt-api)

## How does the data looks like?
The data you publish or subscribe are nothing else than Json objects. Let's take a look at ``hermes/tts/say``, in the 
[MQTT API](https://rhasspy.readthedocs.io/en/latest/reference/#text-to-speech) you can see the topic ``hermes/tts/say`` requires 5 different values.
This could look like this:
```
{
    "text": "Example Text", 
    "lang": null, 
    "id": null, 
    "siteId": "default",
    "sessionId: null
}
```
In this topic you can shorten it a bit. There are some values with a datatype with a '?' behind. You can left them null of you simply won't mention them like this:
```
{
    "text": "Example Text", 
    "siteId": "default"
}
```
The same principle is used when you subscribe a topic. For example the topic ``hermes/tts/sayFinished`` it's published by the tts system, when it has finished speaking (after ``hermes/tts/say``).
When you subscribed to it you can get the following data:
```
{
    "id": null, 
    "siteId": "default"
}
```
When you setup an id at the data in ``hermes/tts/say`` there will be the same id in the ``hermes/tts/sayFinished`` data.
With NodeRed or python it's really simple to create or edit or read json data.
