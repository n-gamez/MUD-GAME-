#!/bin/bash

MQTT_IP="ducklingtrend.duckdns.org"
MQTT_ROOM_DESCRIPTION="roomDesc"
MQTT_ITEM_REPLY="itemReply"
MQTT_ITEM_FOUND="itemFound"
MQTT_PORT=1883

mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "The door is locked."
sleep 3
mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ITEM_FOUND" -m "?" -q 1
itemFound=$(mosquitto_sub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ITEM_REPLY" -C 1)

if [ "$itemFound" == "true" ]; then
    echo "roomE"
    mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "(put the key in the door)"
    sleep 3
    mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "$(cat ~/mudGame/description.txt)"
    sleep 3
    mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "The door slowly creaks open."
    sleep 3
    mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "I don't think I'm going back."
    mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ITEM_FOUND" -m "itemLost"
elif [ "$itemFound" == "false" ]; then
    echo "NO_CHANGE"
    mosquitto_pub -h "$MQTT_IP" -p "$MQTT_PORT" -t "$MQTT_ROOM_DESCRIPTION" -m "Maybe I should use a key."
fi
