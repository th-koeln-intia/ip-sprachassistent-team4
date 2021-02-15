---
layout: default
title: Setup Intents
parent: Knowledge
---
<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Setup Intents

The intents are defined in the ``sentence.ini``, You can edit it on the Rhasspy page under Sentences.
Here is an example with many variations: 
```
[GetTime]
wie spät ist es
sag mir die uhrzeit
wir viel uhr haben wir

[GetGarageState]
ist das garagentor (offen | geschlossen)

[ChangeLightState]
light_name = (licht | garagenlicht | stehlampe) {name}
light_state = (an | ein | aus) {state}
schalte (die | das) <light_name> <light_state>
mach (die | das) <light_name> <light_state>
<light_name> <light_state>

[GetLightState]
ist das licht <ChangeLightState.light_state> an

[SetBrightness]
setze  [die] helligkeit auf (0..100){brightness}
helligkeit [auf] (0..100){brightness}
```

The Text in the square brackets ``[IntentName]`` is the intent name that will be triggered with mqtt.
Under the intent name you see a few sentence, these are the sentence you can say to trigger this topic.
So When you say "wie spät ist es?" the intent `GetTime` will be triggered.
If have the same sentence with only one word variation, you can put the words in round brackets, the word must be seperated with a '|'.
Instead of this:
```
ist das garagentor offen 
ist das garagentor geschlossen
```
You can write this:
```
ist das garagentor (offen | geschlossen)
```
Optional words in sentence can be created with square breckets. 

You can also create variables with word variations, please look at the Intent `CHangeLightState`.

You'll see this schema: `variablename = value`. You can use this variable in any sentence using angle brackets.
Like in the Intent `ChangeLightState`: `mach (die | das) <light_name> <light_state>`.

In Addition you can also use variables from other intents, to use them you must put the intent name where the variable is defined before the variable name.
In the intent `GetLightState` you can see how it looks like.

If you want an intent with numbers instead of words you can create ranges with round brackets.
ranges are defined like this: `(begin..end)`

In the intent `SetBrightness` is an example how to use it.

After any optional word you can define a slotname with curly brackets: `(word1 | word2 | word3) {slotname}`.
In the MQTT message for this intent you will find all slots in the array `msg.slots`. It depends on the order the slotnames are defined.
The first slotname is on position `msg.slots[0]` the second on `msg.slots[1]` and so on. In the slot you find the variable `entry`, it contains the slotname
and the value is in the variable ``value.value``

If you need a large variation of word variation for example citynames or music bands, you can create a simple textfile with all words you need listed.
Here is a small exampole the file could look like:
```
Dortmund
Hagen
Köln
Berlin
Hamburg
Leverkusen
```
We used a list with 14000 German Citys from [here](https://www.datenbörse.net/item/Liste_von_deutschen_Staedtenamen_.csv).
This list does not work well, you need to remove some characters and lines.
Remove the lines ``<different>`` and ``<unterschiedlich>`` from the file. You also must remove all quotation marks and you must replace all back slashes and slashes with spaces. There could be some other unsupported characters in this file. There are only alphabet letters and ä, ü, ö allowed. 
Now move your edited file to ``~/.config/rhasspy/profiles/de/slots/``.
You can see your slots on the rhassspy page on the disc on the left side.
When you want to use a flot you can use ``($slotfilename)`` in your sentences.

# Summary
``[Intent name]``: Defines a Intent
Under the intent name you can create variables and sentences.

``variablenName`` = value: creates an variable

``[any word]``: an optional word

``(word1 | word2 | word3)``: create word options

``{slotname}``: defines a slot

``<variableName>``: use a variable from this content

``<intentName.variableName>``: use a variable from another Intent 

``($slotfilename)`` implement word variations from a file


