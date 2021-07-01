# Docker

## Install Docker

```bash
// Install Docker
curl -sSL https://get.docker.com | sh

// Add active user to docker group
sudo usermod -a -G docker $USER

// Reboot
sudo reboot now

```

## Rhasspy

Starting with **english** profile in background
```bash
docker run -d -p 12101:12101 \
      --name rhasspy \
      --restart unless-stopped \
      -v "$HOME/.config/rhasspy/profiles:/profiles" \
      -v "/etc/localtime:/etc/localtime:ro" \
      --device /dev/snd:/dev/snd \
      rhasspy/rhasspy \
      --user-profiles /profiles \
      --profile en
```

Starting with **german** profile in background
```bash
docker run -d -p 12101:12101 \
      --name rhasspy \
      --restart unless-stopped \
      -v "$HOME/.config/rhasspy/profiles:/profiles" \
      -v "/etc/localtime:/etc/localtime:ro" \
      --device /dev/snd:/dev/snd \
      rhasspy/rhasspy \
      --user-profiles /profiles \
      --profile de
```

[Read more](https://rhasspy.readthedocs.io/en/latest/installation/)

## Node-RED

```bash
docker run -d -p 1880:1880 \
      --name mynodered nodered/node-red \
      --restart unless-stopped \
      -v node_red_data:/data
```

[Read more](https://nodered.org/docs/getting-started/docker)

## zigbee2mqtt

Identify your device
```bash
ls -l /dev/serial/by-id
```

Run docker, whereas the “–device” statement should match the previous output:
```bash
docker run -d -p 8080:8080 \
      --name zigbee2mqtt \
      -v $(pwd)/data:/app/data \
      --device=/dev/ttyACM0 \
      -e TZ=Europe/Amsterdam \
      -v /run/udev:/run/udev:ro \
      --privileged=true \
      koenkk/zigbee2mqtt
```

zigbee2mqtt configuration.yaml with activated frontend
```bash
# Home Assistant integration (MQTT discovery)
homeassistant: false

# allow new devices to join
permit_join: true

# MQTT settings
mqtt:
  # MQTT base topic for zigbee2mqtt MQTT messages
  base_topic: zigbee2mqtt
  # MQTT server URL
  server: 'mqtt://localhost'
  # MQTT server authentication, uncomment if required:
  # user: my_user
  # password: my_password

# Serial settings
serial:
  # Location of CC2531 USB sniffer
  port: /dev/ttyACM0
  
frontend:
  # Optional, default 8080
  port: 8080
  # Optional, default 0.0.0.0
  host: 0.0.0.0
```

>>>>> Frontend Läuft nicht