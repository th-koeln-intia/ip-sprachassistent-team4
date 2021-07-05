---
layout: default
title: Updating
nav_order: 3
has_children: false
---

# Updating
Follow the instructions below to perform updates.

## Rhasspy
To update Rhasspy to the latest version, execute the following commands.

```bash
mkdir -p /home/pi/installFiles/ && wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/update_rhasspy.sh -O /home/pi/installFiles/update_rhasspy.sh
sudo chmod +x /home/pi/installFiles/update_rhasspy.sh
/home/pi/installFiles/update_rhasspy.sh
```

The script will ask you if you want to make backups of your rhasspy profiles. 
The backups are stored under `/home/pi/backup_rhasspy_config`
