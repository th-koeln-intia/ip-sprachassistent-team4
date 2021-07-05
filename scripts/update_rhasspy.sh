#!/bin/bash
WORKFOLDER=/home/pi/installFiles
RHASSPY_BACKUP_FOLDER=/home/pi/backup_rhasspy_config
mkdir -p $RHASSPY_BACKUP_FOLDER

echo "Updating Rhasspy"

# stop service
echo "Stopping rhasspy.service"
sudo systemctl stop rhasspy.service

# backup settings
echo "Do you want to make a backup of your rhasspy profiles?"

select yes_no in "Yes" "No"; do
  case $yes_no in
      Yes) echo "Backup settings" ;
            if [ -d $RHASSPY_BACKUP_FOLDER/rhasspy ]; then
                echo "Warning! Backup folder already exists. Do you want to keep the old backup?"

                select yes_no in "Yes" "No"; do
                  case $yes_no in
                      Yes) dt=$(date '+%Y_%m_%d_%H%M%S') ;
                        echo "Old backup moved to " $RHASSPY_BACKUP_FOLDER/rhasspy"_"$dt ;
                        mv $RHASSPY_BACKUP_FOLDER/rhasspy $RHASSPY_BACKUP_FOLDER/rhasspy"_"$dt ;
                        break;;
                      No) echo "Old backup will be removed." ;
                        rm -R $RHASSPY_BACKUP_FOLDER/rhasspy ;
                        break;;
                  esac
                done
            fi ;
            echo "Creating backup." ;
            cp -R /home/pi/.config/rhasspy/ /home/pi/backup_rhasspy_config/ ;
        break;;
      No) exit;;
  esac
done

# remove actual installation
echo "Remove actual installation"
sudo apt remove rhasspy -y

# install latest version
## getting latest release version from github
RHASSPY_TAG_NAME=$(curl --silent "https://api.github.com/repos/rhasspy/rhasspy/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
echo "Installing rhasspy "$RHASSPY_TAG_NAME
RHASSPY_VERSION=$(echo $RHASSPY_TAG_NAME | cut -d 'v' -f 2)
echo "version: $RHASSPY_VERSION"
mkdir -p $WORKFOLDER && wget https://github.com/rhasspy/rhasspy/releases/download/$RHASSPY_TAG_NAME/rhasspy"_"$RHASSPY_VERSION"_"armhf.deb -O $WORKFOLDER/rhasspy"_"$RHASSPY_VERSION"_"armhf.deb

sudo apt install $WORKFOLDER/rhasspy"_"$RHASSPY_VERSION"_"armhf.deb
rm $WORKFOLDER/rhasspy"_"$RHASSPY_VERSION"_"armhf.deb

# start service
sudo systemctl start rhasspy.service