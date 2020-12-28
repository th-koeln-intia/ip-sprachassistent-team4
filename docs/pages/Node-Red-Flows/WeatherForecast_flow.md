---
layout: default title: WeatherForecast_flow parent: Node-Red-Flows
---
<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# WeatherForecast_flow

for this flow you need to install Zigbee2mqtt node.

```JSON
[
  {
    "id": "8b2b9829.e28ab8",
    "type": "tab",
    "label": "WeatherForecast",
    "disabled": false,
    "info": ""
  },
  {
    "id": "d3535a67.3117d8",
    "type": "mqtt in",
    "z": "8b2b9829.e28ab8",
    "name": "WeatherForecast",
    "topic": "hermes/intent/WeatherForecast",
    "qos": "2",
    "datatype": "json",
    "broker": "f80b985a.2ffa78",
    "x": 160,
    "y": 160,
    "wires": [
      [
        "a629b891.98be78"
      ]
    ]
  },
  {
    "id": "171cd793.df1588",
    "type": "openweathermap",
    "z": "8b2b9829.e28ab8",
    "name": "SetCity",
    "wtype": "forecast",
    "lon": "",
    "lat": "",
    "city": "",
    "country": "",
    "language": "de",
    "x": 460,
    "y": 160,
    "wires": [
      [
        "f9aa6c7b.d15ce"
      ]
    ]
  },
  {
    "id": "f9aa6c7b.d15ce",
    "type": "function",
    "z": "8b2b9829.e28ab8",
    "name": "GetTempAndDesciption",
    "func": "var today = new Date();\nvar time = today.getHours();\nwhile( time%3 !=0){\n    time = time +1;\n}\ntime = time + \":\" + \"00\" + \":\" + \"00\";\nvar temp = [];\nvar description = [];\nvar forcast = msg.payload\nvar city = msg.location.city;\nfor (var i= 0; i < 40; i++){\n    if (forcast[i].dt_txt.indexOf(time) > -1){\n        temp.push(forcast[i].main.temp)\n        description.push(forcast[i].weather[0].description)\n    }\n}\n\nmsg.payload = {\n        temp : temp,\n        description: description,\n        city : city,\n        day : flow.get ('day'),\n        time : time\n    }\n    \nreturn msg;\n\n",
    "outputs": 1,
    "noerr": 0,
    "initialize": "",
    "finalize": "",
    "x": 670,
    "y": 160,
    "wires": [
      [
        "91d7f25.7109e1",
        "72a2b9c2.e66f08"
      ]
    ]
  },
  {
    "id": "a629b891.98be78",
    "type": "function",
    "z": "8b2b9829.e28ab8",
    "name": "GetCity",
    "func": "msg.location = {\n                  \"city\":  msg.payload.slots[1].value.value,\n                 \"country\" : \"Germany\",\n                 \"date\" : msg.payload.slots[0].value.value\n        }\nflow.set ('day', msg.payload.slots[0].value.value);  \nreturn msg;",
    "outputs": 1,
    "noerr": 0,
    "initialize": "",
    "finalize": "",
    "x": 320,
    "y": 160,
    "wires": [
      [
        "171cd793.df1588"
      ]
    ]
  },
  {
    "id": "df127b01.43ed88",
    "type": "mqtt out",
    "z": "8b2b9829.e28ab8",
    "name": "",
    "topic": "hermes/tts/say",
    "qos": "",
    "retain": "",
    "broker": "f80b985a.2ffa78",
    "x": 928,
    "y": 352,
    "wires": []
  },
  {
    "id": "3c1428a4.b50c68",
    "type": "function",
    "z": "8b2b9829.e28ab8",
    "name": "GetTempToday",
    "func": "\nmsg.payload = {text:  \"Das Wetter \" + msg.payload.day + \" in \" + msg.payload.city + \" um \" + msg.payload.time + \" zeigt\" + \" eine Temperature von \" + Math.round(msg.payload.temp[0],2) + \" Grad \" + \"und \" + msg.payload.description[0] , \"siteId\" : \"default\"}\nreturn msg;\n",
    "outputs": 1,
    "noerr": 0,
    "initialize": "",
    "finalize": "",
    "x": 688,
    "y": 272,
    "wires": [
      [
        "df127b01.43ed88"
      ]
    ]
  },
  {
    "id": "a1cd642c.4c5488",
    "type": "function",
    "z": "8b2b9829.e28ab8",
    "name": "GetTempIn2Day",
    "func": "\n\nmsg.payload = {text:  \"Das Wetter \" + msg.payload.day + \" in \" + msg.payload.city + \" um \" + msg.payload.time + \" zeigt\" + \" eine Temperature von \" + Math.round(msg.payload.temp[2],2) + \" Grad \" + \"und \" + msg.payload.description[2] , \"siteId\" : \"default\"}\nreturn msg;",
    "outputs": 1,
    "noerr": 0,
    "initialize": "",
    "finalize": "",
    "x": 688,
    "y": 357,
    "wires": [
      [
        "df127b01.43ed88"
      ]
    ]
  },
  {
    "id": "2179e05d.dae9b",
    "type": "function",
    "z": "8b2b9829.e28ab8",
    "name": "GetTempTomorrow",
    "func": "\n\nmsg.payload = {text:  \"Das Wetter \" + msg.payload.day + \" in \" + msg.payload.city + \" um \" + msg.payload.time + \" zeigt\" + \" eine Temperature von \" + Math.round(msg.payload.temp[1],2) + \" Grad \" + \"und \" + msg.payload.description[1] , \"siteId\" : \"default\"}\nreturn msg;\n\n",
    "outputs": 1,
    "noerr": 0,
    "initialize": "",
    "finalize": "",
    "x": 698,
    "y": 312,
    "wires": [
      [
        "df127b01.43ed88"
      ]
    ]
  },
  {
    "id": "14fdd6c9.0a7769",
    "type": "function",
    "z": "8b2b9829.e28ab8",
    "name": "GetTempIn3Day",
    "func": "\n\nmsg.payload = {text:  \"Das Wetter \" + msg.payload.day + \" in \" + msg.payload.city + \" um \" + msg.payload.time + \" zeigt\" + \" eine Temperature von \" + Math.round(msg.payload.temp[3],2) + \" Grad \" + \"und \" + msg.payload.description[3] , \"siteId\" : \"default\"}\nreturn msg;",
    "outputs": 1,
    "noerr": 0,
    "initialize": "",
    "finalize": "",
    "x": 688,
    "y": 402,
    "wires": [
      [
        "df127b01.43ed88"
      ]
    ]
  },
  {
    "id": "bd428911.d007f8",
    "type": "function",
    "z": "8b2b9829.e28ab8",
    "name": "GetTempIn4Day",
    "func": "\n\nmsg.payload = {text:  \"Das Wetter \" + msg.payload.day + \" in \" + msg.payload.city + \" um \" + msg.payload.time + \" zeigt\" + \" eine Temperature von \" + Math.round(msg.payload.temp[4],2) + \" Grad \" + \"und \" + msg.payload.description[4] , \"siteId\" : \"default\"}\nreturn msg;",
    "outputs": 1,
    "noerr": 0,
    "initialize": "",
    "finalize": "",
    "x": 688,
    "y": 447,
    "wires": [
      [
        "df127b01.43ed88"
      ]
    ]
  },
  {
    "id": "72a2b9c2.e66f08",
    "type": "switch",
    "z": "8b2b9829.e28ab8",
    "name": "SelectDay",
    "property": "payload.day",
    "propertyType": "msg",
    "rules": [
      {
        "t": "eq",
        "v": "heute",
        "vt": "str"
      },
      {
        "t": "eq",
        "v": "Morgen",
        "vt": "str"
      },
      {
        "t": "eq",
        "v": "in zwei Tagen",
        "vt": "str"
      },
      {
        "t": "eq",
        "v": "in drei Tagen",
        "vt": "str"
      },
      {
        "t": "eq",
        "v": "in vier Tagen",
        "vt": "str"
      }
    ],
    "checkall": "true",
    "repair": false,
    "outputs": 5,
    "x": 450,
    "y": 360,
    "wires": [
      [
        "3c1428a4.b50c68"
      ],
      [
        "2179e05d.dae9b"
      ],
      [
        "a1cd642c.4c5488"
      ],
      [
        "14fdd6c9.0a7769"
      ],
      [
        "bd428911.d007f8"
      ]
    ]
  },
  {
    "id": "91d7f25.7109e1",
    "type": "debug",
    "z": "8b2b9829.e28ab8",
    "name": "",
    "active": false,
    "tosidebar": true,
    "console": false,
    "tostatus": false,
    "complete": "false",
    "statusVal": "",
    "statusType": "auto",
    "x": 890,
    "y": 220,
    "wires": []
  },
  {
    "id": "f80b985a.2ffa78",
    "type": "mqtt-broker",
    "name": "",
    "broker": "127.0.0.1",
    "port": "1883",
    "clientid": "",
    "usetls": false,
    "compatmode": false,
    "keepalive": "60",
    "cleansession": true,
    "birthTopic": "",
    "birthQos": "0",
    "birthPayload": "",
    "closeTopic": "",
    "closeQos": "0",
    "closePayload": "",
    "willTopic": "",
    "willQos": "0",
    "willPayload": ""
  }
]
```