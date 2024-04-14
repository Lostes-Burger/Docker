#!/bin/bash

cd /home/container || exit 1

# Configure colors
CYAN='\033[0;36m'
RESET_COLOR='\033[0m'

# Print Current Java Version
java -version

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

echo -e "${CYAN}The Internal IP is ${INTERNAL_IP}"

# Edit the config.json
if [ -e config.json ]
then
    echo -e "Set identity.listeners[0].host to ${INTERNAL_IP}"
    jq ".identity.listeners[0].host = \"${INTERNAL_IP}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Set identity.listeners[0].port to ${CLOUDNET_PORT}"
    jq ".identity.listeners[0].port = \"${CLOUDNET_PORT}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Set httpListeners[0].host to 0.0.0.0"
    jq ".httpListeners[0].host = \"0.0.0.0\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Set httpListeners[0].port to ${CLOUDNET_WEBSERVER}"
    jq ".httpListeners[0].port = \"${CLOUDNET_WEBSERVER}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Set hostAddress to ${INTERNAL_IP}"
    jq ".hostAddress = \"${INTERNAL_IP}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Set connectHostAddress to ${INTERNAL_IP}"
    jq ".connectHostAddress = \"${INTERNAL_IP}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Set ipWhitelist[0] to ${P_SERVER_UUID}"
    jq ".ipWhitelist[0] = \"${P_SERVER_UUID}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Set ipWhitelist[1] to ${INTERNAL_IP}"
    jq ".ipWhitelist[1] = \"${INTERNAL_IP}\"" config.json > config.json.tmp
    mv config.json.tmp config.json

    echo -e "Set maxMemory to ${SERVER_MEMORY}"
    jq ".maxMemory= \"${SERVER_MEMORY}\"" config.json > config.json.tmp
    mv config.json.tmp config.json
else
    echo -e "${CYAN}config.json not exist"
fi

# Replace Startup Variables
# shellcheck disable=SC2086
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "${CYAN}/home/container: ${MODIFIED_STARTUP} ${RESET_COLOR}"

# Run the Server
# shellcheck disable=SC2086
eval ${MODIFIED_STARTUP}
