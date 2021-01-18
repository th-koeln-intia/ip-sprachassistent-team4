---
layout: default
title: Timer with Nodes
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

# TimerNodes
In Node Red you can add a Timer by searching for it in the dropdown menu. Below is a list of Nodes which we have tried but without success to set a timer and later on an alarm clock.

|Provider | short infomation | drop back | 
|----------------|-------------------------------------------------------------------------------------|---------------------|
| [Bigtimer](https://flows.nodered.org/node/node-red-contrib-bigtimer){:target="_blank"}    | BigTimer is the best Node-Red timing node offering a range of timing facilities and offers output suitable for MQTT and database. Its download is estimated at about 2070 per week. |  The start and End Time for timers are fixed. There is no option to set the timer time dynamically i.e it is not possible to get the start and end time from intent and pass it to the node.| 
| [controltimer](https://flows.nodered.org/node/node-red-contrib-controltimer){:target="_blank"}   | A customizable Node-RED timer node which offers both looping and delay behaviour. The timer offers the start, continue, stop and reset option. It has an estimated download for 50 per week. |It is not possible to give a start and end time. you can only set the duration for the timer. It is also not possible to set the duration dynamically. |   
|  [Jsontimer](https://flows.nodered.org/node/node-red-contrib-jsontimer){:target="_blank"}   | allows to set timers to alarm at a specific time. Download estimated about 80 per week. | Has same drop back as other two timer discussed above , means we do not find an option how to set the timer dynamically|
| 

As already discussed we were not able to find a method how we can inject the start and end time from rhasspy Intent to the timer Node.But it is possible to set timer manually using inject node (see below some flow example)

![Timer with Node](/assets/timer_Node.PNG)

# Our own timer node

![Timer with node small-timer](/assets/timer_small-timer-flow.png)

node-red-contrib-smalltimer: [github.com/kevinbischof/node-red-contrib-smalltimer](https://github.com/kevinbischof/node-red-contrib-smalltimer)