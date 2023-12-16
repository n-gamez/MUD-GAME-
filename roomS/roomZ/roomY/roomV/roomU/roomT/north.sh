#!/bin/bash

MQTT_IP="ducklingtrend.duckdns.org"
MQTT_ROOM_DESCRIPTION="roomDesc"
MQTT_ITEM_REPLY="itemReply"
MQTT_ITEM_FOUND="itemFound"
MQTT_PORT=1883

mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "Goblin: GIV US  SUMTHIN SHINY"
sleep 3
mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ITEM_FOUND" -m "?" -q 1
itemFound=$(mosquitto_sub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ITEM_REPLY" -C 1)

if [ "$itemFound" == "true" ]; then
	echo "roomC"
	mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "(gave the goblin a gold coin)"
	sleep 3
	mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "Goblin: YU MAY  PASS THROO HEER"
	sleep 3
	mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "$(cat ~/mudGame/nxtRm.txt)"
	sleep 3
	mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "This room is a  nightmare"
	mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ITEM_FOUND" -m "itemLost"
elif [ "$itemFound" == "false" ]; then
	echo "NO_CHANGE"
	mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "What can I give those guys?"
fi
