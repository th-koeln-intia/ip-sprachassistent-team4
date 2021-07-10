#!/bin/bash

# Sherlock Offline Voice Assistant Configuration Tool
#
# Changelog
# 2021-05-14 Initial commit
# 2021-05-14 Fix echo message
# 2021-07-10 Add options for starting, stopping, restarting, journal
#

check_if_service_exists() {
  if [ "$servicename" == "nodered" ]; then
    echo "nodered service selected"
    service_found=true
    return 1
  fi

  if [ "$servicename" == "hermesledcontrol" ]; then
    echo "hermesledcontrol service selected"
    service_found=true
    return 1
  fi

  if [ "$servicename" == "rhasspy-asr-deepspeech-hermes" ]; then
    echo "rhasspy-asr-deepspeech-hermes service selected"
    service_found=true
    return 1
  fi

  if [ "$servicename" == "rhasspy" ]; then
    echo "rhasspy service selected"
    service_found=true
    return 1
  fi

  if [ "$servicename" == "rhasspy-snips-nlu-hermes" ]; then
    echo "rhasspy-snips-nlu-hermes service selected"
    service_found=true
    return 1
  fi

  if [ "$servicename" == "zigbee2mqtt" ]; then
    echo "zigbee2mqtt service selected"
    service_found=true
    return 1
  fi

  service_found=false
}

parse_service_name() {
  if [ $servicename == "nodered" ]; then
    servicename_parsed="Node-RED"
    return
  fi

  if [ $servicename == "hermesledcontrol" ]; then
    servicename_parsed="Hermes LED Control service"
    return
  fi

  if [ $servicename == "rhasspy" ]; then
    servicename_parsed="Rhasspy"
    return
  fi

  if [ $servicename == "rhasspy-asr-deepspeech-hermes" ]; then
    servicename_parsed="Rhasspy ASR Deepspeech Hermes"
    return
  fi

  if [ $servicename == "rhasspy-snips-nlu-hermes" ]; then
    servicename_parsed="Rhasspy Snips NLU Hermes"
    return
  fi

  if [ $servicename == "zigbee2mqtt" ]; then
    servicename_parsed="zigbee2mqtt"
    return
  fi

  # If no service was found,  set servicename as parsed name
  servicename_parsed=$servicename

}

show_servicenames() {
  echo "Invalid servicename $servicename"
  echo "You can choose between these services:"
  echo "* nodered"
  echo "* hermesledcontrol"
  echo "* rhasspy"
  echo "* rhasspy-asr-deepspeech-hermes"
  echo "* rhasspy-snips-nlu-hermes"
  echo "* zigbee2mqtt"
}

show_help() {
  echo ""
  echo "Sherlock Offline Voice Assistant Configuration Tool"
  echo ""
  echo "General Options:"
  echo "    -h, --help                                        show brief help"
  echo ""
  echo "Monitoring:"
  echo "    -c, --check                                       checks if services are running"
  echo "    -j servicename, --journal servicename             prints journal of the service"
  echo ""
  echo "Administration:"
  echo "    -start servicename, --start servicename           restarts specific services"
  echo "    -start all, --start all                           starts all services"
  echo ""
  echo "    -stop servicename, --stop servicename             stopps all services"
  echo "    -stop all, --stop all                             stopps all services"
  echo ""
  echo "    -r all, --restart all                             restarts all services"
  echo "    -r servicename, --restart servicename             restarts specific service"
  echo ""
  exit 0
}

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

  echo ""
  echo "Check services"
  echo ""
  echo "Node-RED                          $NODERED_ACTIVE ($NODERED_ENABLED)"
  echo "Hermes LED Control                $HERMES_LED_CONTROL_ACTIVE ($HERMES_LED_CONTROL_ENABLED)"
  echo "Rhasspy                           $RHASSPY_ACTIVE ($RHASSPY_ENABLED)"
  echo "Rhasspy ASR Deepspeech Hermes     $RHASSPY_ASR_DEEPSPEECH_HERMES_ACTIVE ($RHASSPY_ASR_DEEPSPEECH_HERMES_ENABLED)"
  echo "Rhasspy Snips NLU Hermes          $RHASSPY_SNIPS_NLU_HERMES_ACTIVE ($RHASSPY_SNIPS_NLU_HERMES_ENABLED)"
  echo "zigbee2mqtt                       $ZIGBEE2MQTT_ACTIVE ($ZIGBEE2MQTT_ENABLED)"
  echo ""
}

print_journal_of_service() {
  case "$servicename" in
  nodered | hermesledcontrol | rhasspy | rhasspy-asr-deepspeech-hermes | rhasspy-snips-nlu-hermes | zigbee2mqtt)
    sudo journalctl -fu "$servicename".service
    ;;
  \?)
    show_servicenames
    show_help
    ;;
  esac
}

start_service() {
  if [ "$servicename" == "all" ]; then
    echo ""
    echo "Starting..."

    echo "...Node-RED"
    sudo systemctl start nodered.service

    echo "...Hermes LED Control"
    sudo systemctl start hermesledcontrol.service

    echo "...Rhasspy ASR Deepspeech Hermes"
    sudo systemctl start rhasspy-asr-deepspeech-hermes.service

    echo "...Rhasspy"
    sudo systemctl start rhasspy.service

    echo "...Rhasspy Snips NLU Hermes"
    sudo systemctl start rhasspy-snips-nlu-hermes.service

    echo "...zigbee2mqtt"
    sudo systemctl start zigbee2mqtt.service

    echo "Starting complete"
    echo ""
    exit 1
  fi

  echo "Starting $servicename_parsed service"
  sudo systemctl start "$servicename".service
  echo "Starting complete"
  exit 1
}

stop_service() {
  if [ "$servicename" == "all" ]; then
    echo ""
    echo "Stopping..."

    echo "...Node-RED"
    sudo systemctl stop nodered.service

    echo "...Hermes LED Control"
    sudo systemctl stop hermesledcontrol.service

    echo "...Rhasspy ASR Deepspeech Hermes"
    sudo systemctl stop rhasspy-asr-deepspeech-hermes.service

    echo "...Rhasspy"
    sudo systemctl stop rhasspy.service

    echo "...Rhasspy Snips NLU Hermes"
    sudo systemctl stop rhasspy-snips-nlu-hermes.service

    echo "...zigbee2mqtt"
    sudo systemctl stop zigbee2mqtt.service

    echo "Stopping complete"
    echo ""
    exit 1
  fi

  echo "Stopping $servicename_parsed service"
  sudo systemctl stop "$servicename".service
  echo "Stopping complete"
  exit 1
}

restart_service() {
  if [ "$servicename" == "all" ]; then
    echo ""
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

    echo "Restarting complete"
    echo ""
    exit 1
  fi

  echo "Restarting $servicename_parsed service"
  sudo systemctl restart "$servicename".service
  echo "Restarting complete"
  exit 1
}

# Parsing parameters
while [ $# -gt 0 ]; do
  servicename=$2
  check_if_service_exists "$servicename"

  # options requiring 1 parameter
  if [ "$1" = "-c" -o "$1" = "--check" ]; then
    check_services
    exit 0
  fi

  if [ "$1" = "-h" -o "$1" = "--help" ]; then
    show_help
    exit 0
  fi

  # options requiring 2 parameters
  if [ "$1" = "-r" -o "$1" = "--restart" ]; then
    if [ $service_found == "true" ]; then
      parse_service_name
      restart_service "$servicename"
      exit 0
    fi

    if [ $servicename == "all" ]; then
      restart_service "all"
      exit 0
    fi

  fi

  if [ "$1" = "-start" -o "$1" = "--start" ]; then
    if [ $service_found == "true" ]; then
      parse_service_name
      start_service "$servicename"
      exit 0
    fi

    if [ $servicename == "all" ]; then
      start_service "all"
      exit 0
    fi
  fi

  if [ "$1" = "-stop" -o "$1" = "--stop" ]; then
    if [ $service_found == "true" ]; then
      parse_service_name
      stop_service "$servicename"
      exit 0
    fi

    if [ $servicename == "all" ]; then
      stop_service "all"
      exit 0
    fi
  fi

  if [ "$1" = "-j" -o "$1" = "--journal" ]; then
    if [ $service_found == "true" ]; then
      parse_service_name
      print_journal_of_service "$servicename"
      exit 0
    fi
  fi

  # Default case
  echo "Invalid option -$1 $2"
  show_help

  exit 1
done

# No arguments case
show_help
exit 1
