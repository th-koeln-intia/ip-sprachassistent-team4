---
layout: default
title: Version dependencies
parent: Technology Evaluation
---
<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Version dependencies
During the implementation of all used software we faced problems when some software was updated. 

## Hermes LED Control
The update to version 2.0.11 brings a functionality "Real-time Sound Source Localization and Tracking". 
This functionality recognizes from which direction the microphone array is being spoken from. There were two problems. 
If you activated this function, the library numpy could no longer be found. In addition, the microphone was constantly 
accessed. However, the microphone can only be accessed by one process. Rhasspy and Hermes LED Control tried to access 
the microphone at the same time. In the installation you can deactivate this functionality and only install the 
dependencies, but this did not work in practice. Therefore we install to the previous version 2.0.10 in the auto 
installation script. 

## Seeed-voicecard
Since December 15, 2021 there is an update of the Linux kernel to version 5.10.0.
The seeed-voicecard drivers cannot be installed with the current versions 5.10.x and higher. The installation of 
raspbian with the Raspberry Pi imager always installs the latest version and thus the incompatible kernel version 
5.10.x. 
To fix this problem, we tested three possibilities. One way was to downgrade to kernel version 5.4.83 from 
December 14, 2021. The downgrade failed and the Raspberry Pi would not boot anymore.
Alternatively, we used a Raspbian image from the Raspbian archive dated January 11, 2021 with kernel version 5.4.83. 
This image can also be installed with the Raspberry Pi Imager. It turned out that the installation script from 
seeed-voicecard automatically upgraded to the new kernel version.
Through research we were able to find an adapted installation script in a fork of the original seeed-voicecard 
git repository. This is the third option. By switching to the forked repository, the drivers for the microphone array 
can now be used again. In the future it has to be observed how future updates of the kernel will affect seeed-voicecard.

## Conclusion
Due to the fact that we use many different software and drivers in this project, which all have to be coordinated with 
each other, automatic updates can be a problem. Therefore, it is important that specific and tested versions are used. 
New versions must be tested and can only be used afterwards. 
