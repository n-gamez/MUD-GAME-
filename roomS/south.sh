#!/bin/bash

MQTT_IP="ducklingtrend.duckdns.org"
MQTT_ROOM_DESCRIPTION="roomDesc"
MQTT_DIRECTIONAL_INPUT="directInput"
MQTT_PORT=1883

echo "NO_CHANGE"
mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "The floor is wetMust be a leak"

#may need to edit this depending on whos 10 rooms come first
