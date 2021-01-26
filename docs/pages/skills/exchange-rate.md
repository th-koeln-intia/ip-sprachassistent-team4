---
layout: default
title: Exchange Rate
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

# Exchange Rate
The goal of this Topic is to allow users to get the exchange rate for a specific currency for a specific country converted in Euro.The user can also ask for the value for ` silver or gold ` and get its corresponding price in euro.
To get all information about the actual rate we use the API with the URL `https://wechselkurse-euro.de/`. From this url, we can extract the table for different countries and their currency value corresponding to 1 €.
We need an HTTP Request node to fecht the value from the Internet and some knowledge from css to load the information which we are looking for. Because the values are presented in two different tables, we also need a join node to combine the two tables. Finally a function named GetAll will combine the two tables and send it to another function named GetTextForTTs, which will forward the message to the TTS node.
For the intent we also use a custom slot name ExchangeCounties to store different countries.
the intent is something like :

```
[GetExchangeRate]
Exchange rate for ($ExchangeCountries){country}
```
The slot list named ExchangeCountries can be downloaded from [here ](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/data/ExchangeCountries).

From the intent we get the country name and pass it to the table to obtain the currency value and currency name. 
The TTS output is : 
```
1 € is corresponding to <country currency name>
```
Picture below shows the complete nodes used.

![Exchange rate](/assets/ExchangeRate.png)

# Downlod the flow
- [Download](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/flows/exchange_rate.json){:target="_blank"}
