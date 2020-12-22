# Stop Zigbee2MQTT and go to directory
sudo systemctl stop zigbee2mqtt
cd /opt/zigbee2mqtt

# Activate environment
source /opt/zigbee2mqtt/bin/activate

# Backup configuration
cp -R data data-backup

# Update
git checkout HEAD -- npm-shrinkwrap.json
git pull
npm ci

# Restore configuration
cp -R data-backup/* data
rm -rf data-backup

# Deactivate environment
deactivate

# Start Zigbee2MQTT
sudo systemctl start zigbee2mqtt
