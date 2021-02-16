#!/bin/bash
WORKFOLDER=/home/pi/installFiles
STARTFOLDER=$(pwd)
language=""

if [ ! -f $WORKFOLDER/rhasspy-resume-after-reboot ]; then

    echo "$(tput setaf 2)Welcome to auto installation of sherlock voice assistant! $(tput sgr 0)"
    echo "$(tput setaf 2)Your system will be updated, upgraded and software will be installed now.$(tput sgr 0)"
    echo "$(tput setaf 3)Update and upgrade system! $(tput sgr 0)"
    read -p "Press [Enter] key to continue..."

    #update
    sudo apt update
    sudo apt upgrade -y
    sudo apt install git virtualenv python3-venv -y

    #setup Workfolder
    mkdir $WORKFOLDER
    cd $WORKFOLDER
    read -p "Press [Enter] key to continue..."

    echo "if [[ -n \$SSH_CONNECTION ]]; then bash $STARTFOLDER/$(basename $0); fi" >> ~/.bashrc
    echo "$STARTFOLDER/$(basename $0)" >> $WORKFOLDER/rhasspy-resume-after-reboot

    #Remove piwiz from autostart to avoid the repeating sound output
    #"To install the screen reader press control alt space"
    sudo rm /etc/xdg/autostart/piwiz.desktop

    #reboot
    echo "$(tput setaf 3)Don't panic, your system will reboot, after your next login the Installation continue. $(tput sgr 0)"
    read -p "Press [Enter] key to reboot..."
    sudo reboot
else
    echo "$(tput setaf 2)Welcome back. The Installation continues! $(tput sgr 0)"

    # Check language
    echo -e "Choose your language!"
    echo -e "Type en for english or de for german:"

    while :
    do
      read -n 2 language

      if [ "$language" = "en" ]; then
        echo -e "\nYou chose en"
        break
      elif [ "$language" = "de" ]; then
        echo -e "\nYou chose de"
        break
      else
        echo -e "\nChoose between en or de!"
      fi
    done

    #install seeed-voicecard
    echo "$(tput setaf 3)Install Seeed-Voicecard! $(tput sgr 0)"
    read -p "Press [Enter] key to continues..."
    git clone https://github.com/HinTak/seeed-voicecard.git
    cd seeed-voicecard
    sudo ./install.sh

    #remove from autostart
    sed -i '$d' ~/.bashrc
    rm -f $WORKFOLDER/rhasspy-resume-after-reboot

    #overwrite asound.conf
    echo "$(tput setaf 3)download asound.conf! $(tput sgr 0)"
    read -p "Press [Enter] key to continues..."
    sudo wget 'https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/data/asound.conf' -O /etc/asound.conf

    #install mqtt server
    cd $WORKFOLDER
    echo "$(tput setaf 3)Install MQTT server! $(tput sgr 0)"
    read -p "Press [Enter] key to continue..."
    sudo apt-get install mosquitto mosquitto-clients -y

    #install nodered
    echo "$(tput setaf 3)Install Node-RED! $(tput sgr 0)"
    read -p "Press [Enter] key to continue..."

    cd $WORKFOLDER

    wget https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered -O $WORKFOLDER/update-nodejs-and-nodered
    sudo chmod +x $WORKFOLDER/update-nodejs-and-nodered
    $WORKFOLDER/update-nodejs-and-nodered --confirm-root --confirm-install --confirm-pi
    sudo systemctl enable nodered.service
    sudo systemctl start nodered.service

    #install npm packages and import example flows
    wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/scripts/install-node-red-npm-packages-and-flows.sh -O $WORKFOLDER/install-node-red-npm-packages-and-flows
    chmod +x install-node-red-npm-packages-and-flows
    ./install-node-red-npm-packages-and-flows

    #install Zigbee2MQTT
    echo "$(tput setaf 3)Install zigbee2mqtt! $(tput sgr 0)"
    read -p "Press [Enter] key to continue..."
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/install_zigbee2mqtt.sh
    chmod +x install_zigbee2mqtt.sh
    ./install_zigbee2mqtt.sh

    sudo wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/zigbee2mqtt.service -O /etc/systemd/system/zigbee2mqtt.service
    sudo systemctl enable zigbee2mqtt.service
    sudo systemctl start zigbee2mqtt.service

    #install Rhasspy
    echo "$(tput setaf 3)Install Rhasspy! $(tput sgr 0)"
    read -p "Press [Enter] key to continue..."
    cd $WORKFOLDER
    wget https://github.com/rhasspy/rhasspy/releases/download/v2.5.7/rhasspy_2.5.7_armhf.deb
    sudo apt install ./rhasspy_2.5.7_armhf.deb -y

    sudo wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/rhasspy_$language.service -O /etc/systemd/system/rhasspy.service
    sudo systemctl enable rhasspy
    sudo systemctl start rhasspy

    echo "$(tput setaf 3)Download Rhasspy config files! $(tput sgr 0)"
    read -p "Press [Enter] key to continue..."
    mkdir -p /home/$USER/.config/rhasspy/profiles/$language/slots
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/data/custom_words_$language.txt -O /home/$USER/.config/rhasspy/profiles/$language/custom_words.txt
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/data/profile_$language.json -O /home/$USER/.config/rhasspy/profiles/$language/profile.json
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/data/sentences_$language.ini -O /home/$USER/.config/rhasspy/profiles/$language/sentences.ini
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/data/cities_$language -O /home/$USER/.config/rhasspy/profiles/$language/slots/cities
    wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/data/exchange_countries_$language -O /home/$USER/.config/rhasspy/profiles/$language/slots/ExchangeCountries
    sudo systemctl restart rhasspy

    #install hermes led control
    echo "$(tput setaf 3)Install Hermes-LED-Control! $(tput sgr 0)"
    echo "$(tput setaf 3) Answer the questions after you pressed enter like following: "
    echo "* What assistant engine are you using? Enter 2 for rhasspy"
    echo "* What's the path to your assistant config file? Type in your path to your profile.json. The default path is this /home/pi/.config/rhasspy/profiles/de/profile.json"
    echo "* What device do you wish to control with SLC? Enter 2 for respeaker4"
    echo "* What pattern do you want to use? Choose your preferred Led pattern. For example 1 for google"
    echo "* Do you need to install / configure your respeaker4? Enter 2 for no $(tput sgr 0)"
    
    read -p "Press [Enter] key to continue..."
    wget https://gist.github.com/Sh4der/8476895a0863ca6062103315ac122954/raw/f5c83b34eaafbd0b315d17282c1fc52b672e008a/hlc_download.sh
    sudo chmod +x hlc_download.sh
    sudo ./hlc_download.sh

    #install DeepSpeech
    echo "$(tput setaf 3)Install DeepSpeech! $(tput sgr 0)"
    read -p "Press [Enter] key to continue..."
    wget -N https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/scripts/install_rhasspy_deepspeech_$language.sh -O $WORKFOLDER/install-rhasspy-deepspeech.sh
    chmod +x ./install-rhasspy-deepspeech.sh
    ./install-rhasspy-deepspeech.sh

    #install Snips-NLU
    echo "$(tput setaf 3)Install Snips-NLU! $(tput sgr 0)"
    read -p "Press [Enter] key to continue..."
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/install_rhasspy_snips_nlu_venv_$language.sh -O $WORKFOLDER/install-rhasspy-snips-nlu_venv.sh
    chmod +x $WORKFOLDER/install-rhasspy-snips-nlu_venv.sh
    $WORKFOLDER/install-rhasspy-snips-nlu_venv.sh

    #installation complete
    echo "$(tput setaf 2)Installation complete! Your Raspberry Pi will reboot now! $(tput sgr 0)"
    sudo reboot
fi