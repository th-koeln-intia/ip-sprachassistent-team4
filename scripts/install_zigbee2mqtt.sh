# Clone Zigbee2MQTT repository
sudo git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt
sudo chown -R pi:pi /opt/zigbee2mqtt

# Enter folder
cd /opt/zigbee2mqtt

# Install python env
python3 -m venv .

# Activate environment
source /opt/zigbee2mqtt/bin/activate

# Upgrade pip, wheel and setuptools
pip install --upgrade pip wheel setuptools

# Install node environment
pip install nodeenv

# Init node environment
nodeenv -p -n 10.15.1

# Deactivate and activate environment to be sure
deactivate
source /opt/zigbee2mqtt/bin/activate

# Install dependencies
cd /opt/zigbee2mqtt
npm ci

# Deactivate environment
deactivate

if ! grep -q frontend "/opt/zigbee2mqtt/data/configuration.yaml"; then
    printf "frontend:\n  # Optional, default 8080\n  port: 8080\n  # Optional, default 0.0.0.0\n  host: 0.0.0.0\n" >> /opt/zigbee2mqtt/data/configuration.yaml
fi

sudo systemctl restart zigbee2mqtt