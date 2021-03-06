---
layout: default
title: Systemd
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

# Systemd

## Why this section?
When you want to start Rhasspy the normal way you quickly notice that you can't find any sound device. 
Your microphone does not work anymore. This is not what we expect. 
The interesting part is, that everything is working again, when you start Rhasspy again manually in the commandline. 
So there must be something, that systemd does the other way,
than the user with a manually start does.

## So what is the Problem?
When you take a look in the log of Rhasspy you may see the following message:
```
...
INFO supervisord started with pid 700
INFO spawnerr: unknown error making dispatchers for 'microphone': ENXIO
INFO spawnerr: unknown error making dispatchers for 'intent_handling': ENXIO
INFO spawnerr: unknown error making dispatchers for 'wake_word': ENXIO
...
```
This means, that the program supervisord tries to open a file. The Error 'ENXIO' is from the linux open command and 
means, that the file the program tries to open is a socket. A socket can't be opened by the ``open`` command
When you take a look into the supervisor.conf in the profile directory, you can see, that ``/dev/stdout`` is set as 
log file for all supervisor tasks. 
When you inspect the file ``/dev/stdout`` with ``readlink`` in the normal bash and then with a systemd service, you 
get this results:
```
Bash:
/dev/stdout -> /proc/self/fd/1 -> /dev/pts/X

Systemd:
/dev/stdout -> /proc/self/fd/1 -> socket:[Y]
```
In the bash the link points to a normal file. But in systemd, the link points to a socket, that can't be opened with 
the ``open`` command.

## Solution 1 in the service

You can edit the ``/etc/system.d/system/rhasspy.service``. By simply replacing this:    

### english
``ExecStart=/usr/bin/rhasspy --profile en``    
With this:    
``ExecStart=/bin/bash -lc "rhasspy --profile en 2>&1 | cat"``    

### german
``ExecStart=/usr/bin/rhasspy --profile de``    
With this:    
``ExecStart=/bin/bash -lc "rhasspy --profile de 2>&1 | cat"``

Have a look on the rhasspy.service file
- [english rhasspy.service](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/scripts/rhasspy_en.service)
- [german rhasspy.service](https://github.com/th-koeln-intia/ip-sprachassistent-team4/blob/master/scripts/rhasspy_de.service)

This redirects all output to the ``cat`` command and prints it to the normal standard console.
When you save your Rhasspy settings you need to manually restart Rhasspy.

## Solution 2 editing the Rhasspy run script
The other way is to edit the Rhasspy run script ``/usr/bin/rhasspy``. Go down to this:
```
log_path="${profile_dir}/supervisord.log"
```
And paste this line above:
```
sed -i "s,/dev/stdout,${config_home}/rhasspy/rhasspy.log,g" "${conf_path}"
```
This edits the supervisor.conf file after it was created. The path ``/dev/stdout`` will be replaced by the path 
``${config_home}/rhasspy/rhasspy.log``.
So supervisor creates a log file in the Rhasspy folder instead printing all output to ``/dev/stdout``
When you save your Rhasspy settings you need to manually restart Rhasspy.


## Useful links to understand the problem
Readlink manual: [man7.org](https://man7.org/linux/man-pages/man1/readlink.1.html)    
/dev/stdout socket: [bugzilla.redhat.com](https://bugzilla.redhat.com/show_bug.cgi?id=1212756)    
Open ENXIO Error: [man7](https://man7.org/linux/man-pages/man2/open.2.html)    
Github issue: [Github](https://github.com/rhasspy/rhasspy/issues/42)

