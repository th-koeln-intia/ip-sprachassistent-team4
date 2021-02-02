#!/bin/bash
WORKFOLDER=/home/pi/installFiles
STARTFOLDER=$(pwd)

if [ ! -f $WORKFOLDER/rhasspy-resume-after-reboot ]; then
    echo "Update"
    read -p "Press [Enter] key to continue..."
    #update
    sudo apt update
    sudo apt upgrade -y
    sudo apt install git virtualenv python3-venv -y

    #setup Workfolder
    mkdir $WORKFOLDER
    cd $WORKFOLDER
    echo "Voicecard"
    read -p "Press [Enter] key to continue..."
    #install seeed-voicecard
    git clone https://github.com/respeaker/seeed-voicecard.git
    cd seeed-voicecard
    sudo ./install.sh

    echo "if [[ -n \$SSH_CONNECTION ]]; then bash $STARTFOLDER/$(basename $0); fi" >> ~/.bashrc
    echo "$STARTFOLDER/$(basename $0)" >> $WORKFOLDER/rhasspy-resume-after-reboot

    #reboot
    echo "Don't panic, your system will reboot, after your next login the Installation continue."
    read -p "Press [Enter] key to reboot..."
    sudo reboot
else
    echo "Welcome back. The Installation continue."

    #remove from autostart
    sed -i '$d' ~/.bashrc
    rm -f $WORKFOLDER/rhasspy-resume-after-reboot
    echo "conf"
    read -p "Press [Enter] key to continues..."
    #edit asound.conf
    sudo 'echo "ctl.!default {
           type pulse
       }" >> /etc/asound.conf'

    sudo sed "s/type asym/type pulse/g" /etc/asound.conf
    sudo sed '/capture.pcm "ac108"/a hint.description "Default Audio Device"' /etc/asound.conf

    
    #set default device

    cd $WORKFOLDER
    echo "MQTT"
    read -p "Press [Enter] key to continue..."
    install mqtt server
    sudo apt-get install mosquitto mosquitto-clients -y
    echo "NodeRed"
    read -p "Press [Enter] key to continue..."

    cd $WORKFOLDER
    #install nodered
    wget https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered -O $WORKFOLDER/update-nodejs-and-nodered
    sudo chmod +x $WORKFOLDER/update-nodejs-and-nodered
    $WORKFOLDER/update-nodejs-and-nodered --confirm-root --confirm-install --confirm-pi

    #enable nodered
    sudo systemctl enable nodered.service

    #install npm packages and import example flows
    wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/scripts/install-node-red-npm-packages-and-flows.sh -O $WORKFOLDER/install-node-red-npm-packages-and-flows
    chmod +x install-node-red-npm-packages-and-flows
    ./install-node-red-npm-packages-and-flows

    echo "zigbee"
    read -p "Press [Enter] key to continue..."
    install zigbee2mqtt
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/install_zigbee2mqtt.sh
    chmod +x install_zigbee2mqtt.sh
    ./install_zigbee2mqtt.sh

    sudo wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/zigbee2mqtt.service -O /etc/systemd/system/zigbee2mqtt.service
    sudo systemctl enable zigbee2mqtt.service
    sudo systemctl start zigbee2mqtt.service

    echo "rhasspy"
    read -p "Press [Enter] key to start reboot..."
    # rhasspy
    cd $WORKFOLDER
    wget https://github.com/rhasspy/rhasspy/releases/download/v2.5.7/rhasspy_2.5.7_armhf.deb
    sudo apt install ./rhasspy_2.5.7_armhf.deb -y

    echo "rhasspy systemd"
    read -p "Press [Enter] key to continue..."
    ########profile.json
    sudo wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/rhasspy.service -O /etc/systemd/system/rhasspy.service

    sudo systemctl enable rhasspy

    echo "configs"
    read -p "Press [Enter] key to continue..."
    mkdir -p /home/$USER/.config/rhasspy/profiles/de/slots
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/data/custom_words.txt -O /home/$USER/.config/rhasspy/profiles/de/custom_words.txt
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/data/profile.json -O /home/$USER/.config/rhasspy/profiles/de/profile.json
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/data/sentences.ini -O /home/$USER/.config/rhasspy/profiles/de/sentences.ini
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/data/cities -O /home/$USER/.config/rhasspy/profiles/de/slots/cities
    wget https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/data/ExchangeCountries -O /home/$USER/.config/rhasspy/profiles/de/slots/ExchangeCountries
    sudo systemctl restart rhasspy

    echo "hlc"
    read -p "Press [Enter] key to continue..."
    wget https://gist.github.com/Sh4der/8476895a0863ca6062103315ac122954/raw/f5c83b34eaafbd0b315d17282c1fc52b672e008a/hlc_download.sh
    sudo chmod +x hlc_download.sh
    sudo ./hlc_download.sh

    echo "deepspeech"
    read -p "Press [Enter] key to continue..."
    #deepspeech
    wget -N https://raw.githubusercontent.com/th-koeln-intia/ip-sprachassistent-team4/master/scripts/install-rhasspy-deepspeech.sh -O $WORKFOLDER/install-rhasspy-deepspeech.sh
    chmod +x ./install-rhasspy-deepspeech.sh
    ./install-rhasspy-deepspeech.sh
    echo "snips"
    read -p "Press [Enter] key to continue..."
    #snips
    wget https://github.com/th-koeln-intia/ip-sprachassistent-team4/raw/master/scripts/install-rhasspy-snips-nlu_venv.sh -O $WORKFOLDER/install-rhasspy-snips-nlu_venv.sh
    chmod +x $WORKFOLDER/install-rhasspy-snips-nlu_venv.sh
    $WORKFOLDER/install-rhasspy-snips-nlu_venv.sh

fi