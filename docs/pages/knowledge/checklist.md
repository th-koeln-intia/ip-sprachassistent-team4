---
layout: default
title: Checklist
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

# Checklist

After installation, you can test if your installation is successful.

# 1. Check if all services are running
First you can check if every service we installed is running.
When you run the `sudo systemctl status <servicename>` you can check if everything works fine.
Look at the point `Active` it should be `active (running)`. You can look down at the status for an error.

Mosquitto:
```
sudo systemctl status mosquitto
```
DeepSpeech:
```bash
sudo systemctl status rhasspy-asr-deepspeech-hermes
```
Snips:
```bash
sudo systemctl status rhasspy-snips-nlu-hermes
```
Zigbee2mqtt:
```bash
sudo systemctl status zigbee2mqtt
```
Node-Red:
```bash
sudo systemctl status nodered
```
Rhasspy:
```bash
sudo systemctl status rhasspy
```

## Problems
- If any of these services are not running restart them with:
```bash
sudo systemctl restart <servicename>
```
Check the status again, when it is running everything is ok.
- There is also a common error. It could be, that some data is missing. you should see it in the log in the status.
  This error appears when the model for DeepSpeech and snips is missing.

# 2. Check train function
Open Rhasspy GUI `<ip of your Raspberry Pi>:12101` and click train. there is a setup sentences.ini it should work.
After near 60 seconds this message with a different time should appear: `Training completed in 59.34 second(s)`
When you got an error please open with `journalctl` the log of deepspeech and snips and train again to search for 
an error. 
Maybe there is a syntax error in sentence.ini or a model is missing.
Here are the commands for the logs:
```bash
sudo journalctl -fu rhasspy-asr-deepspeech-hermes
sudo journalctl -fu rhasspy-snips-nlu-hermes
```

# 3. Check snips
When the training was successful, you can try out an intent. Go on the Rhasspy GUI and type this:
[![Rhasspy snips test](/assets/check_snips.png)](/assets/check_snips.png){:target="_blank"}  
You should see, that the Intent `GetTime` is triggered.
If not, open the log for snips and look for errors:
```bash
sudo journalctl -fu rhasspy-snips-nlu-hermes
```

# 4. Check microphone and Hermes Led Control
First set up a [wake word](/pages/installation/manual/configuration.html#3-wake-word), after that you can try it.
The LEDs on the Raspberry Pi should now blink. Your wake word got recognized.

# 5. Check Node-Red
Check if you can access Node-Red `<ip of your Raspberry Pi>:1880`.
When you can access it you can try your flows. This part is your part.