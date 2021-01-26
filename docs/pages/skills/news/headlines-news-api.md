---
layout: default
title: Headlines news api
parent: News
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

# Headlines News API

Here is a flow to get the latest headlines of a country. We used the newsapi.org api. If you want to use that flow,
you need to get a free api key from newsapi.org.

Then you need to install the node [node-red-contrib-queue-gate](https://flows.nodered.org/node/node-red-contrib-queue-gate){:target="_blank"}.

After installing the node, import the flow from [our github repository](https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/flows/headlines_api_de.json){:target="_blank"}

Open the node "get news for DE" and update the URL. Actually the URL looks like this:

`https://newsapi.org/v2/top-headlines?country=de&apiKey=PUT_YOUR_API_KEY_HERE`

After `country=` insert the letters of a country like "de" for germany oder "us" for USA.

After `apiKey=` insert your api key from newsapi.org.

![Example headlines flow](../../../assets/play_headlines_germany.png)

## Downlod the flow
- [Download](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/flows/headlines_api_de.json){:target="_blank"}
