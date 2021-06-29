#!/bin/bash

check_services() {
  # check services active/inactive
  NODERED_ACTIVE=$(systemctl is-active nodered.service)
  HERMES_LED_CONTROL_ACTIVE=$(systemctl is-active hermesledcontrol.service)
  RHASSPY_ACTIVE=$(systemctl is-active rhasspy.service)
  RHASSPY_ASR_DEEPSPEECH_HERMES_ACTIVE=$(systemctl is-active rhasspy-asr-deepspeech-hermes.service)
  RHASSPY_SNIPS_NLU_HERMES_ACTIVE=$(systemctl is-active rhasspy-snips-nlu-hermes.service)
  ZIGBEE2MQTT_ACTIVE=$(systemctl is-active zigbee2mqtt.service)

  # check services enabled/disabled
  NODERED_ENABLED=$(systemctl is-enabled nodered.service)
  HERMES_LED_CONTROL_ENABLED=$(systemctl is-enabled hermesledcontrol.service)
  RHASSPY_ENABLED=$(systemctl is-enabled rhasspy.service)
  RHASSPY_ASR_DEEPSPEECH_HERMES_ENABLED=$(systemctl is-enabled rhasspy-asr-deepspeech-hermes.service)
  RHASSPY_SNIPS_NLU_HERMES_ENABLED=$(systemctl is-enabled rhasspy-snips-nlu-hermes.service)
  ZIGBEE2MQTT_ENABLED=$(systemctl is-enabled zigbee2mqtt.service)

  echo "Check services"
  echo ""
  echo "Node-RED                          $NODERED_ACTIVE ($NODERED_ENABLED)"
  echo "Hermes LED Control                $HERMES_LED_CONTROL_ACTIVE ($HERMES_LED_CONTROL_ENABLED)"
  echo "Rhasspy                           $RHASSPY_ACTIVE ($RHASSPY_ENABLED)"
  echo "Rhasspy ASR Deepspeech Hermes     $RHASSPY_ASR_DEEPSPEECH_HERMES_ACTIVE ($RHASSPY_ASR_DEEPSPEECH_HERMES_ENABLED)"
  echo "Rhasspy Snips NLU Hermes          $RHASSPY_SNIPS_NLU_HERMES_ACTIVE ($RHASSPY_SNIPS_NLU_HERMES_ENABLED)"
  echo "zigbee2mqtt                       $ZIGBEE2MQTT_ACTIVE ($ZIGBEE2MQTT_ENABLED)"
}

show_help() {
  echo ""
     echo "options:"
     echo "-h, --help     show brief help"
     echo "-c, --check    checks if services are running"
     exit 0
}

restart_services() {
  echo "Restarting..."

  echo "...Node-RED"
  sudo systemctl restart nodered.service

  echo "...Hermes LED Control"
  sudo systemctl restart hermesledcontrol.service

  echo "...Rhasspy ASR Deepspeech Hermes"
  sudo systemctl restart rhasspy-asr-deepspeech-hermes.service

  echo "...Rhasspy"
  sudo systemctl restart rhasspy.service

  echo "...Rhasspy Snips NLU Hermes"
  sudo systemctl restart rhasspy-snips-nlu-hermes.service

  echo "...zigbee2mqtt"
  sudo systemctl restart zigbee2mqtt.service
}

no_args="true"
while getopts ":chr" flag; do
  case "${flag}" in
    c)
     check_services
     ;;
    h)
     show_help
     ;;
    r)
      restart_services
      ;;
   \?)
     echo "Invalid option -$OPTARG"
     show_help
     ;;
  esac
  no_args="false"
done

[[ "$no_args" == "true" ]] && { show_help; exit 1; }
