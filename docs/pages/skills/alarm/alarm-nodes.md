---
layout: default
title: Alarm with Nodes
parent: Alarm
grand_parent: Skills
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# AlarmNodes
We add an alarm skill by using our [own timer node](https://github.com/kevinbischof/node-red-contrib-smalltimer){:target="_blank"}
It looks the same as our [timer implementation with a node](/pages/skills/timer/timer-nodes){:target="_blank"}. The only difference is, the word 'Timer' was replaced by
the word 'alarm', and there is a change in the function 'Switch-Case-timer'. Instead to passes the time straight
to the timer node we calculate the time difference between now and when the alarm should ring.
This difference is passed to the node. It will ring when the time is up.

![Timer with node small-timer](/assets/timer_small-timer-flow_version2.png)