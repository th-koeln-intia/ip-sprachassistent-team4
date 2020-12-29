---
layout: default
title: Alarm with JS
parent: Alarm
grand_parent: Results
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Alarm with JS
We created a alarm feature in NodeRed with JS Functions. Here is a small overview:

![Alarm with JavaScript](/assets/alarmJSFull.png)

## Requirements
- `PlaySound` node from [node-red-contrib-play-sound](https://flows.nodered.org/node/node-red-contrib-play-sound)

## Features
- It can load and save alarms from a file. So when te raspberry turns of and on again the alarms are will be leaded again.
- Set an alarm via voice you can set hours, minutes and seconds.
- You can clear all alarms.
- Stop an alarm via voice
- And you can ask when the next alarm is set answer via TTS.
- 1 second refresh time.
- TTS tells you which time you set the alarm

## Savefile
The alarms are saved in the profile folder: 
```
/home/pi/.config/rhasspy/profiles/de/data/alarms.json
```

## Alarm sound
Tha alarm sound is setup here:
```
/home/pi/.config/rhasspy/profiles/de/data/alarm.mp3
```
You can edit it or set another path. Important is that you use an absolut path to link the mp3 file. Otherwise NodeRed looksin its own workfolder.

## Description
I start to describe the flow from top to bottom. so we start with the loading the alarms from a file.

### Load Alarms
![Load Alarms](/assets/alarmJSLoad.png)
Loading all alarms from a file will be triggered at the start of NodeRed. The injector `loadAlarms` triggers the `file in` node.
The `file in` node reads the whole file and hands it to the json node, which converts the JSON data format to a JavaScript(JS) object. 
This JS object goes to the function `setAlarmsGlobal`. This function saves all alarms in a global array in NodeRed, so we can access 
them from everywhere.

### Intent `SetAlarmClock`
![Set new alarm](/assets/alarmJSSet.png)
When an `SetAlarmClock` intent enterns the mqtt-Server the function `createTimerObject` will be triggered.
This function extract the hour, minutes and seconds from the message and create a alarm object in this format:
```
{alarmSet : <dateTime the alarm was set>, alarmAt : <dateTime the alarm should ring>};
```
Here is the sourcecode of this function:
```javascript
var seconds = 0;
var minutes = 0;
var hours = 0;

for(var i = 0; i < msg.payload.slots.length; i++)
{
    if(msg.payload.slots[i].slotName === "seconds")
        seconds = msg.payload.slots[i].value.value;
    if(msg.payload.slots[i].slotName === "minutes")
        minutes = msg.payload.slots[i].value.value;
    if(msg.payload.slots[i].slotName === "hours")
        hours = msg.payload.slots[i].value.value;
}
var alarmSetAt = new Date();
var alarmAt = new Date(alarmSetAt.getFullYear(), alarmSetAt.getMonth(), alarmSetAt.getDate(), hours, minutes, seconds);
node.warn(alarmSetAt.getTime());
node.warn(alarmAt.getTime());
if(alarmSetAt.getTime() > alarmAt.getTime())
    alarmAt.setDate(alarmAt.getDate() + 1);

msg.payload = {alarmSet : alarmSetAt, alarmAt : alarmAt};
return msg;
```

This alarm object goes now to two functions, to `createTTSText` and to `AddToGlobalAlarms`.
`createTTSText` creates the message the TTS should say. here is the code:
```javascript
var alarmAt = new Date(msg.payload.alarmAt);
var hours = alarmAt.getHours();
var minutes = alarmAt.getMinutes();
var seconds = alarmAt.getSeconds();

var text = "Es wurde ein Wecker für ";
if(hours !== 0)
    text += hours + " Uhr ";
if(minutes !== 0)
    text += "und " + minutes + " Minuten ";
if(seconds !== 0)
    text += "und " + seconds + " Sekunden ";
    
text += "gesetzt.";
msg.payload = {text: text, siteId: "default", id: "testID"};
return msg;
```
After this function the TTS says the text in `msg.payload`.

The function `AddToGlobalAlarms` adds the new alarm to the global list of alarms:
```javascript
var alarms = global.get("alarms");
if(alarms === undefined)
    alarms = [];

if(msg.payload != null)
{
    alarms.push(msg.payload);
    global.set("alarms", alarms);
}

msg.payload = alarms;
return msg;
```
After this function the alarm list will be saved with the node `file` to the file `/home/pi/.config/rhasspy/profiles/de/data/alarms.json`.

### Injection `resetAlarms`
![Reset all alarms](/assets/alarmJSReset.png)
This part is for deleting all Alarms from the global list and from the savefile.
After you click on `resetAlarms` the functions `resetAllAlarms` starts.
This function sets the global `alarms` array tro an empty array:
```javascript
global.set("alarms", []);
msg.payload = null;
return msg;
```
After this the alarms will be saved in the savefile again.

### Injection `refreshAlarms`
![Check alarms](/assets/alarmJSCheck.png)
The injection  `refreshAlarms` triggers the function `checkAllAlarms` every second.
`checkAllAlarms` goes through every alarm in the global alarm list and checks if it's time to ring.
When a timer is out of time it will be add to the `readyTimers` array, which will be the output for the function. 
If `readyTimers` is empty the function will return `null`. 

Here is the Code:
```javascript
var dateNow = new Date();
var readyAlarms = [];

for(var i = 0; i < msg.payload.alarms.length; i++)
{
    var thenTime = new Date(msg.payload.alarms[i].alarmAt);
    if(dateNow.getTime() >= thenTime.getTime())
    {
        readyAlarms.push(msg.payload.alarms[i]);
    }
}

if(readyAlarms.length > 0)
    msg.payload = readyAlarms;
else
    msg.payload = null;
return msg;
```

After this function a switch checks if the message is null or not. If it's null it ignores the message, 
and if not the message goes to two functions. The function `removeFromGlobalAlarms` removes the alarm from the 
global array and saves the file.
```javascript

var alarms = global.get("alarms");
if(alarms === undefined)
    alarms = [];

if(msg.payload != null)
{
    for(var i = 0; i < msg.payload.length; i++)
    {
        for( var j = 0; j < alarms.length; j++) 
        { 
            if (alarms[j].alarmSet.toString() == msg.payload[i].alarmSet.toString() && alarms[j].alarmAt.toString() == msg.payload[i].alarmAt.toString())
            {
                alarms.splice(j, 1); 
            }
        }
    }
    
    
    global.set("alarms", alarms);
}

msg.payload = alarms;
return msg;
```

And the message from `checkAllAlarms` also goes to the function `startRinging`. In it the message will be set to `"start"` and the 
global variable `alarmRinging` is set to 1:
```javascript
global.set("alarmRinging", 1);
msg.payload = "start";
return msg;
```

The `PlaySound` node will now play the file on this path: 
```
/home/pi/.config/rhasspy/profiles/de/data/alarm.mp3
```
When the file ends the switch `checkAlarmRinging` checks if the global variable `alarmRinging` is `0`.
If not the `PlaySound` node starts playing again.

### Intent `StopAlarmClock`
![Stop an alarm](/assets/alarmJSStop.png)
The Intent `StopAlarmClock` stops the rining of an alarm. It runs the function `stopRinging`. 
This sets the global variable `alarmRinging` to `0` and sets the payload to `"stop"`.
This message goes to the `PlaySound` node, it should stop playing the file. 

Here is the code:
```javascript
global.set("alarmRinging", 0);
msg.payload = "stop";
return msg;
```

### Intent `NextAlarm`
![Reset all alarms](/assets/alarmJSNext.png)
The Intent `NextAlarm` picks the next due alarmclock and creates a text the TTS should say to inform the user when the next alarm rings.

The Intent first triggers the function `checkAllAlarms`. This function goes through all alarms listed in the global `alarms` variable
and put the next due alarm in `mas.payload`.
```javascript
var alarms = global.get("alarms");
var nextDate = new Date(new Date().getFullYear()+2000, 0, 0, 0, 0, 0);

for(var i = 0; i < alarms.length; i++)
{
    var thenTime = new Date(alarms[i].alarmAt);
    if(nextDate.getTime() > thenTime.getTime())
    {
        nextDate = new Date(thenTime);
    }
}
msg.payload = nextDate;
return msg;
```

The function `createAnswerText` is the next function in the flow. It converts the datetime from the alarm in a sentence a human can understand.
```javascript
var currentDate = new Date();

var alarmDate = new Date(msg.payload);

var text = "Der nächste Wecker geht "
if(currentDate.getFullYear() == alarmDate.getFullYear() && currentDate.getMonth() == alarmDate.getMonth() && currentDate.getDay() == alarmDate.getDay())
    text += "Heute ";
else if(currentDate.getFullYear() == alarmDate.getFullYear() && currentDate.getMonth() == alarmDate.getMonth() && currentDate.getDay()+1 == alarmDate.getDay())
    text += "Morgen ";
else
    text += "Am " + alarmDate.getDay() + "ten " + alarmDate.getMonth() + "ten " + alarmDate.getFullYear() + " ";

text += "um " + alarmDate.getHours() + " Uhr ";
if(alarmDate.getMinutes() !== 0)
    text += alarmDate.getMinutes();

msg.payload = {text: text, siteId: "default", id: "testID"};

return msg;
```
The output of this function goes directly to the Mqtt TTS node.

## Download the Flow
- [Download](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/flows/alarm.json)
