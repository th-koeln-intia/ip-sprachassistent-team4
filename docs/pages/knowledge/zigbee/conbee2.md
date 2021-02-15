---
layout: default
title: Zigbee Adapter ConBee2
parent: Zigbee
grand_parent: Knowledge
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Zigbee Adapter ConBee2
The Conbee2 Adapter was developed by Phoscon in Germany. It's a small usb device to
 connect to other zigbee devices. It is really powerful. Inside buildings, you can reach devices in a 30 meter radius and outside buildings
 it can reach devices in a 200 m radius.

To pair zigbee devices, you only need zigbee2mqtt, it can direct communicate with this device and no other software is needed. So this step is voluntary and only for people who
eager new Knowledge! Phoscon, the producer of the Conbee2 recommends the tool deconz. DeCONZ application is a tool to configure, 
control and monitor Zigbee networks with the ConBee2 adapter. It does not work together with zigbee2mqtt, if you want to try it out, 
stop the zigbee2mqtt service and go through the following instructions.

## Installation of deCONZ

1. Set user USB access rights
```
sudo gpasswd -a $USER dialout
```

2. Import Phoscon public key
```
 wget -O - http://phoscon.de/apt/deconz.pub.key | \
           sudo apt-key add -
```

3. Configure the APT repository for deCONZ
```
sudo sh -c "echo 'deb http://phoscon.de/apt/deconz \
            $(lsb_release -cs) main' > \
            /etc/apt/sources.list.d/deconz.list"
```

4. Update APT package list
```
sudo apt update
```

5. Install deCONZ
```
 sudo apt install deconz
```

## Using deCONZ
The Phoscon app is hosted on the port 8080 on your Raspberry Pi. When you open it, you see your conbee2 device, 
select it.
Now you must set up a password, after that it searches for zigbee devices. Feel free to play with it.
Deconz also offers a UI on an X-Server. when you start deconz in a graphical environment you see another window. 
I don't want to explain more, it's not important for this project.
But feel free to play with it. When you are ready with playing keep in mind, that you must stop deCONZ and start 
the zigbee2mqtt service again to make your zigbee devices working in this project.


