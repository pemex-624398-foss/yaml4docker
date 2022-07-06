#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$(realpath "$0")")
PROJECT=$(basename "$SCRIPT_PATH")

bash -c "$SCRIPT_PATH/stop.sh" || { echo "Failed to stop services" && exit 1; }

declare -a NETWORKS=( \
"${PROJECT}_backend" \
"${PROJECT}_frontend" \
)
declare -a VOLUMES=( \
"${PROJECT}_db-mysql-data" \
"${PROJECT}_web-institucional-html" \
"${PROJECT}_web-ch-html" \
"${PROJECT}_mon-portainer-data" \
)

echo "Removing docker networks..."
for NETWORK in "${NETWORKS[@]}"; do
    if docker network ls | awk '{print $2}' | grep -q -E "^$NETWORK\$"; then
        docker network rm "$NETWORK"
    else
        echo "Network $NETWORK does not exist"
    fi
done
echo

docker network ls
echo


echo "Removing docker volumes..."
for VOLUME in "${VOLUMES[@]}"; do
    if docker volume ls -q | grep -q -E "^$VOLUME\$"; then
        docker volume rm "$VOLUME"
    else
        echo "Volume $VOLUME does not exist"
    fi
done
echo

docker volume ls
echo

