#!/bin/bash

MQTT_IP="ducklingtrend.duckdns.org"
MQTT_ROOM_DESCRIPTION="roomDesc"
MQTT_PORT=1883
MQTT_ITEM_FOUND="itemFound"

echo "NO_CHANGE"
mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "You find a golden key."
mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ITEM_FOUND" -m "itemFound"
