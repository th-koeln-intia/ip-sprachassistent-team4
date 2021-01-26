---
layout: default
title: Top News Notification HTTP
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

# Top News Notification HTTP
The purpose of this theme is to allow the user to receive the new notifications from sports, business and politics.
We use three different HTTp requests to get the top news from each topic.
From the intent, we extract the specific topic name (`e.g.: Politics`) and pass it to a switch node called `NotificationSelector`, which then passes the information to the corresponding HTTP request node. From the HPPT node, the first topic is retrieved from the respective web pages and sent to the TTS node.
 
The intent is roughly as follows:
 
```
[GetNotificationForNews]
top new from economy{economy}
top new from politic{politics}
top new from sport
 
```
The TTS will then output the first message from the corresponding topic.


![top_news_notification](../../../assets/top_news_notification.png)

# downlod the complete flow
- [Download](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/flows/top_news_notification.json)
