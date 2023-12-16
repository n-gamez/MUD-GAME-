#!/bin/bash

MQTT_IP="ducklingtrend.duckdns.org"
MQTT_ROOM_DESCRIPTION="roomDesc"
MQTT_PORT=1883

echo ".."
mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "$(cat ~/mudGame/description.txt)"
sleep 3
mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "A pungent smell fills the air."
