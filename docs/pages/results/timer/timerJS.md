---
layout: default
title: Timer with JS
parent: Timer
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

# Timer with JS
We created a timer feature in NodeRed with JS Functions. Here is a small overview:

[![Timer with JavaScript](/assets/timerJSFull.png)](/assets/timerJSFull.png){:target="_blank"}  

## Requirements
- `PlaySound` node from [node-red-contrib-play-sound](https://flows.nodered.org/node/node-red-contrib-play-sound)

## Features
- It can load and save timers from a file. So when the raspberry turns off and on, the alarms are will be loaded again.
- Set a timer via voice you can set hours, minutes and seconds.
- You can clear all timers.
- Stop a timer via voice
- And you can ask when the next timer is set answer via TTS.
- 1 second refresh time.
- TTS tells you what time the timer was set

## Savefile
The timers are saved in the profile folder: 
```
/home/pi/.config/rhasspy/profiles/de/data/timers.json
```

## Timer sound
The timer sound is setup to this file:
```
/home/pi/.config/rhasspy/profiles/de/data/alarm.mp3
```
You can edit it or set another path. Important is that you use an absolut path to link the mp3 file. Otherwise NodeRed looks in its own workfolder.

## Description
I start to describe the flow from top to bottom. so we start with the loading the alarms from a file.

### Load Timers
[![Load Timers](/assets/timerJSLoad.png)](/assets/timerJSLoad.png){:target="_blank"}  
Loading all timers from a file will be triggered at the start of NodeRed. The injector `loadTimers` triggers the `file in` node.
The `file in` node reads the whole file and hands it to the json node, which converts the JSON data format to a JavaScript(JS) object. 
This JS object goes to the function `setTimersGlobal`. This function saves all timers in a global array in NodeRed, so we can access 
them from everywhere.

### Intent `SetTimer`
[![Set new timer](/assets/timerJSSet.png)](/assets/timerJSSet.png){:target="_blank"}  
When an `SetTimer` intent enters the mqtt-Server, the function `createTimerObject` will be triggered.
This function extract the hour, minutes and seconds from the message and create a alarm object in this format:
```
{timerSet : timerSetAt, timerAt : timerAt, timerIn: timerIn}
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
var timerSetAt = new Date();
var timerAt = new Date(timerSetAt);
timerAt.setHours(timerAt.getHours() + hours);
timerAt.setMinutes(timerAt.getMinutes() + minutes);
timerAt.setSeconds(timerAt.getSeconds() + seconds);

var timerIn = new Date(0);
timerIn.setHours(timerIn.getHours() + hours);
timerIn.setMinutes(timerIn.getMinutes() + minutes);
timerIn.setSeconds(timerIn.getSeconds() + seconds);

msg.payload = {timerSet : timerSetAt, timerAt : timerAt, timerIn: timerIn};
return msg;
```

This timer object goes to two functions, to `createTTSText` and to `AddToGlobalTimers`.
`createTTSText` creates the message the TTS should say. here is the code:
```javascript
var timerIn = new Date(msg.payload.timerIn);
var hours = timerIn.getHours() -1 ;
var minutes = timerIn.getMinutes();
var seconds = timerIn.getSeconds();

var text = "Es wurde ein Teimer in ";
if(hours !== 0)
    text += hours + " Stunden ";
if(minutes !== 0)
    text += minutes + " Minuten ";
if(seconds !== 0)
    text += seconds + " Sekunden ";
    
text += "gesetzt.";
msg.payload = {text: text, siteId: "default", id: "testID"};

return msg;
```
After this function the TTS says the text in `msg.payload`.

The function `AddToGlobalTimers` adds the new tomer to the global list of timers:
```javascript
var timers = global.get("timers");
if(timers === undefined)
    timers = [];

if(msg.payload != null)
{
    timers.push(msg.payload);
    global.set("timers", timers);
}

msg.payload = timers;
return msg;
```
After this function the timer list will be saved with the node `file` to the file `/home/pi/.config/rhasspy/profiles/de/data/timers.json`.

### Injection `resetTimers`
[![Reset all timers](/assets/timerJSReset.png)](/assets/timerJSReset.png){:target="_blank"}  
This part is for deleting all timers from the global list and from the savefile.
After you click on `resetTimers` the functions `resetAllTimers` starts.
This function sets the global `timers` array to an empty array:
```javascript
global.set("timers", []);
msg.payload = null;
return msg;
```
After this the timers will be saved in the savefile again.

### Injection `refreshTimers`
[![Check timers](/assets/timerJSCheck.png)](/assets/timerJSCheck.png){:target="_blank"}  
The injection `refreshTimers` triggers the function `checkAllTimers` every second.
`checkAllTimers` goes through every timer in the global timer list and checks if it's time to ring.
When a timer is out of time it will be add to the `readyTimers` array, which will be the output for the function. 
If `readyTimers` is empty the function will return `null`. 

Here is the Code:
```javascript
var dateNow = new Date();
var readyTimers = [];

for(var i = 0; i < msg.payload.timers.length; i++)
{
    var thenTime = new Date(msg.payload.timers[i].timerAt);
    if(dateNow.getTime() >= thenTime.getTime())
    {
        readyTimers.push(msg.payload.timers[i]);
    }
}
if(readyTimers.length > 0)
    msg.payload = readyTimers;
else
    msg.payload = null;
return msg;
```

After this function a switch checks if the message is null or not. If it's null it ignores the message, 
and if not the message goes to two functions. The function `removeFromGlobalTimers` removes the timer from the 
global array and saves the file.
```javascript
var timers = global.get("timers");
if(timers === undefined)
    timers = [];

if(msg.payload != null)
{
    for(var i = 0; i < msg.payload.length; i++)
    {
        for( var j = 0; j < timers.length; j++) 
        { 
            if (timers[j].timerSet.toString() == msg.payload[i].timerSet.toString() && timers[j].timerAt.toString() == msg.payload[i].timerAt.toString())
            {
                timers.splice(j, 1); 
            }
        }
    }
    global.set("timers", timers);
}

msg.payload = timers;
return msg;
```

And the message from `checkAllTimers` also goes to the function `startRinging`. In it the message will be set to `"start"` and the 
global variable `timerRinging` is set to 1:
```javascript
global.set("timerRinging", 1);
msg.payload = "start";
return msg;
```

The `PlaySound` node will now play the file on this path: 
```
/home/pi/.config/rhasspy/profiles/de/data/alarm.mp3
```
When the file ends the switch `checkTimerRinging` checks if the global variable `timerRinging` is `0`.
If not the `PlaySound` node starts playing again.

### Intent `StopTimer`
[![Stop an timer](/assets/timerJSStop.png)](/assets/timerJSStop.png){:target="_blank"}  
The Intent `StopTimerClock` stops the ringing of an alarm. It runs the function `stopRinging`. 
This sets the global variable `timerRinging` to `0` and sets the payload to `"stop"`.
This message goes to the `PlaySound` node, it should stop playing the file. 

Here is the code:
```javascript
global.set("timerRinging", 0);
msg.payload = "stop";
return msg;
```

### Intent `NextTimer`
[![Next alarm](/assets/timerJSNext.png)](/assets/timerJSNext.png){:target="_blank"}  
The Intent `NextTimer` picks the next due timer and creates a text the TTS should say to inform the user when the next timer rings.

The Intent first triggers the function `checkAllTimers`. This function goes through all timers listed in the global `timers` variable
and put the next due timer in `msg.payload`.
```javascript
var timers = global.get("timers");
var nextDate = new Date(new Date().getFullYear()+2000, 0, 0, 0, 0, 0);

for(var i = 0; i < timers.length; i++)
{
    var thenTime = new Date(timers[i].timerAt);
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

var timerDate = new Date(msg.payload);

var fullSecondsRemain = (timerDate.getTime() - currentDate.getTime())/1000;
var minutesRemain = Math.floor(fullSecondsRemain/60);
var secondsRemain = Math.floor(fullSecondsRemain%60);

var text = "Der nächste Teimer geht in " + minutesRemain + " Minuten und " + secondsRemain + " Sekunden";

msg.payload = {text: text, siteId: "default", id: "testID"};

return msg;
```
The output of this function goes directly to the Mqtt TTS node.

## Download the Flow
- [Download](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/flows/timer.json)
