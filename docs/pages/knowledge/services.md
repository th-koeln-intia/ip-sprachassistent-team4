---
layout: default
title: Services
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

# Services

## Weather Forecast

Comparison of Weather-APIs:

| Provider                                                                           | Best for                                                                                       | Free Requests per day
|------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|---------------------------------
| [Open Weather Map](https://openweathermap.org){:target="_blank"}                   | Weather Forecast 1 h, 2 days, 7 days, Government Weather Alerts, Historical Weather 5 days     | 33,3333 (1,000,000/month)
| [Weatherbit](https://www.weatherbit.io){:target="_blank"}                          | Weather Forecast daily/16 days & Weather Alerts                                                | 500
| [AccuWeather](https://developer.accuweather.com){:target="_blank"}                 | Weather Conditions current & 24 h historical, Weather Forecast 12 h, 5 days                    | 50
| [ClimaCell](https://www.climacell.co/){:target="_blank"}                           | Realtime, Short Term & Hourly Forecasts                                                        | 1,000
| [ClimaCell](https://www.climacell.co/){:target="_blank"}                           | Air Quality & Pollen Layer                                                                     | 100
| [Visual Crossing](https://www.visualcrossing.com/weather-api){:target="_blank"}    | Weather Forecast 15 days & 40+ year hourly Historical Data                                     | 100 (with credit card 1,000)
| [weatherstack](https://weatherstack.com){:target="_blank"}                         | Real-Time Weather                                                                              | 33 (1,000/month)
| [weatherapi](http://www.weatherapi.com){:target="_blank"}                          | Real-Time Weather, Daily and Hourly 3 day city/town weather, 7 days History                    | 33,3333 (1,000,000/month)

Resources:
* https://rapidapi.com/blog/access-global-weather-data-with-these-weather-apis/
* Websites linked above

### Add Cities to Rhasspy sentences.ini

List of cities need to be placed in ``slots/movies`` folder. The file doesn't have a file extension.

Create the folder ``slots`` inside your profile:

``mkdir $HOME/.config/rhasspy/profiles/de/slots``

Here is a ready list of all cities in germany. Just execute the following command to put the list in the right place:

``wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/9fcc3f772a7fa3e4efe0ee3d4b530aa6283d0bf5/docs/assets/cities_germany -P $HOME/.config/rhasspy/profiles/de/slots``

Now you can use ``$cities_germany`` in your sentence templates like this:

```bash
[GetTemperatureOfCity]
How is the temperature in ($cities_germany) {location}
```

You also can create your own list with city names. Just try it!

Resources:
* https://www.datenbörse.net/item/Liste_von_deutschen_Staedtenamen_.csv

## Timer

## Alert

## Turn Light On/Off

