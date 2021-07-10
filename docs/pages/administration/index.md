---
layout: default 
title: Administration 
nav_order: 27 
has_children: false
---

# Administration tool

`sherlock-conf` is a configuration tool for this voice assistant.

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## Introduction

With this tool you can restart individual components or the entire system without having to restart the operating
system. Furthermore, you can see whether all components or services are activated and running. For individual services,
you can display and monitor the current log or journal. With this tool, problems with the system can be found more
quickly. `sherlock-conf` is located in `/usr/bin/sherlock-conf`. If you are a developer, you can look at this file. It
is a shell script. You can also adapt or extend this script yourself. You can make extensions available to everyone with
a pull request on [github](https://github.com/th-koeln-intia/ip-sprachassistent-team4/pulls).

## Installation

The tool should be already on your system after running
the [automatic installation script](/pages/installation/auto-installation).

If the tool is not available you can install the tool with following commands:

```bash
    sudo wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/sherlock-conf.sh -O /usr/bin/sherlock-conf
    sudo chmod +x /usr/bin/sherlock-conf
```

Finally run `sherlock-conf -h`.

## Options

```bash
pi@raspberrypi:~ $ sherlock-conf

Sherlock Offline Voice Assistant Configuration Tool

General Options:
    -h, --help                                        show brief help

Monitoring:
    -c, --check                                       checks if services are running
    -j servicename, --journal servicename             prints journal of the service

Administration:
    -start servicename, --start servicename           starts specific service
    -start all, --start all                           starts all services

    -stop servicename, --stop servicename             stops specific service
    -stop all, --stop all                             stops all services

    -r servicename, --restart servicename             restarts specific service
    -r all, --restart all                             restarts all services
```

### -h, --help

Displays the help.

### -c, --check

Checks the status of all services.

### -j servicename, --journal servicename

Displays the journal of the specified service.

### -start servicename, --start servicename

Starts the specified service.

### -start all, --start all

Starts all services.

### -stop servicename, --stop servicename

Stops the specified service.

### -stop all, --stop all

Stops all services.

### -r servicename, --restart servicename

Restarts the specified service.

### -r all, --stop all

Restarts all services.