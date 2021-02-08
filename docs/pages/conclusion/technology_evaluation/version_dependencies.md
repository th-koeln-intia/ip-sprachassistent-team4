---
layout: default
title: Version dependencies
parent: Technology Evaluation
grand_parent: Conclusion
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
Since December 15, 2021 there is an update of the linux kernel to version 5.10.0 and ongoing. 
The seeed-voicecard drivers cannot be installed with the current versions 5.10.x and higher. Installing raspbian with 
the Raspberry Pi imager always installs the latest version and thus the incompatible kernel version 5.10.x.
To fix this problem, we tested two options. One option was a downgrade to kernel version 5.4.83 from December 14, 2021. 
The downgrade failed and the Raspberry Pi would not boot anymore.
Alternatively, we downloaded a raspbian image from the raspbian archive dated January 11, 2021 using kernel 
version 5.4.83. This image can also be installed with the Raspberry Pi imager.

## Conclusion
Due to the fact that we use many different software and drivers in this project, which all have to be coordinated with 
each other, automatic updates can be a problem. Therefore, it is important that specific and tested versions are used. 
New versions must be tested and can only be used afterwards. 
