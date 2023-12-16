#!/bin/bash

MQTT_IP="ducklingtrend.duckdns.org"
MQTT_ROOM_DESCRIPTION="roomDesc"
MQTT_PORT=1883

echo "roomS"
mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "$(cat ~/mudGame/nxtRm.txt)"
sleep 3
mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "you find a torch in this room"
