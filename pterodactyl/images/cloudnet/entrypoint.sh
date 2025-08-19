#!/bin/bash

cd /home/container || exit 1

CYAN='\033[0;36m'
RESET_COLOR='\033[0m'
RED="\033[0;31m"
RED_BIG="\033[1;31m"
GREEN="\033[0;32m"
GREEN_BIG="\033[1;32m"

java -version

echo -e " "
echo -e "${RED_BIG}Please follow the setup tutorial on my github page! \e[0m"
echo -e "${GREEN_BIG}https://github.com/Lostes-Burger/Docker/tree/main/pterodactyl/eggs/cloudnet#setup-cloudnet \e[0m"

INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

echo -e "${CYAN}Internal docker IP address: ${INTERNAL_IP}"

if [ -e config.json ]
then
    echo -e "CloudNet Identify Host Adress set to ${INTERNAL_IP}"
    jq ".identity.listeners[0].host = \"${INTERNAL_IP}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "CloudNet Port Set ${CLOUDNET_PORT}"
    jq ".identity.listeners[0].port = \"${CLOUDNET_PORT}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "HttpListener set to to 0.0.0.0"
    jq ".httpListeners[0].host = \"0.0.0.0\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "HttpListener WebServer port set to ${CLOUDNET_WEBSERVER}"
    jq ".httpListeners[0].port = \"${CLOUDNET_WEBSERVER}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "CloudNet Host Adress set to ${INTERNAL_IP}"
    jq ".hostAddress = \"${INTERNAL_IP}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Added Docker network IP to whitelist ${INTERNAL_IP}"
    jq ".ipWhitelist[1] = \"${INTERNAL_IP}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Max Ram set to: ${SERVER_MEMORY}"
    jq ".maxMemory= \"${SERVER_MEMORY}\"" config.json > config.json.tmp
    mv config.json.tmp config.json
else
    echo -e "${RED_BIG}config.json does not exist!"
    echo -e " "
    echo -e "${RED_BIG}Cancel"
    exit -1
fi

# Replace Startup Variables
# shellcheck disable=SC2086
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "${CYAN}/home/container: ${MODIFIED_STARTUP} ${RESET_COLOR}"

# Run the Server
# shellcheck disable=SC2086
eval ${MODIFIED_STARTUP}