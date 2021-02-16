---
layout: default 
title: Weather forecast 
parent: Skills
---
<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

The weather forecast allows the user to get the weather information of a specific date and location. For the
Implementation we will use Node-red and Hermes MQTT protocol.

## Set up the intent in sentence.ini

The specification for the intent can be like:

```
[WeatherForecast]
city_name=(cologne | Bergisch Gladbach | Paris ){city}
date =(today| Tomorrow | in two days| in three days | in fourth days){day}S
how is the weather <date> in <city_name>
 
```

1. First a city name needs to be specified. This name can be obtained through a database, where the city and country
   name are stored. To keep it simple in this example, we can just put some cities' names as a list.
2. The next thing is to get the date on which the weather forecast will be estimated. For this purpose we are using
   Openweathermap Node, which allows us to get the temperature for five days successively starting from 00:00 till 21:00
   in a step of three hours. (` e.g  for each day we can get the forecast for 00:00, 03:00, 06:00 etc..`). The only
   downside to this NODE is that we can only get the weather information of the hour, which are divisible by a three. It
   will not be able to get the forecast for 10 O'clock. If the user requests a forecast at 10 o'clock, he will get the
   forecast for the next hour which is divisible by tree and in this case the forecast for 12 o'clock will be output :
   The function named `GetTempAndDesciption` handles this logic.
3. We also need to store the value for the date and pass it to the switch Node, which will differentiate between
   different forecast days. The function GetCity handles this by storing the date in a flow variable and this variable
   is then accessible everywhere in the
   flow. (` e.g : with flow.set ('day', msg.payload.slots[0].value.value) we can store the date with variable name day and with flow.get ('day'), the value can be fetched;`)
4. The switch node will delegate the weather forecast according to the date to a specific function, and the Hermes MQTT
   node will publish the message set in the function.

[![setup weather forecast with Node_Red](../../assets/five_days_weather.png)](../../assets/five_days_weather.png)

## Download the flow

- [Download](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/flows/weather_forecast.json){:target="_blank"}
 
