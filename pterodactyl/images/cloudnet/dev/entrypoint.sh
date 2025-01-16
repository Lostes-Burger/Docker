#!/bin/bash

cd /home/container || exit 1

CYAN='\033[0;36m'
RESET_COLOR='\033[0m'

# Print Installed Java version
java -version

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

if [ "${CLOUDNET_IP}" == "Pterodactyl_IP" ]; then
  IP="${INTERNAL_IP}"
else
  IP="${CLOUDNET_IP}"
fi

export IP

echo -e "${CYAN}The Internal IP is ${IP}"

# Edit CloudNet's Downloaded Config.json
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

    echo -e "CloudNet Host Adress set to ${IP}"
    jq ".hostAddress = \"${IP}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Added Container ID to whitelist ${P_SERVER_UUID}"
    jq ".ipWhitelist[0] = \"${P_SERVER_UUID}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Added Docker network IP to whitelist ${IP}"
    jq ".ipWhitelist[1] = \"${IP}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Max Ram set to: ${SERVER_MEMORY}"
    jq ".maxMemory= \"${SERVER_MEMORY}\"" config.json > config.json.tmp
    mv config.json.tmp config.json
else
    echo -e "${CYAN}config.json does not exist"
fi

# Replace Startup Variables
# shellcheck disable=SC2086
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "${CYAN}/home/container: ${MODIFIED_STARTUP} ${RESET_COLOR}"

# Run the Server
# shellcheck disable=SC2086
eval ${MODIFIED_STARTUP}