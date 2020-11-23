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

To pair zigbee devices, you need to install deCONZ. deCONZ application is a tool to configure, control and monitor Zigbee networks with the ConBee2 adapter.

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


