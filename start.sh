#!/usr/bin/env bash

PROJECT=$(basename "$(dirname "$(realpath "$0")")")

declare -a IMAGES=(
	"mysql:8.0.29"
	"phpmyadmin/phpmyadmin:5.0.0"
	"joomla:4.1.5"
	"wordpress:6.0.0"
	"portainer/portainer-ce:2.14.0"
)
declare -a NETWORKS=(
	"${PROJECT}_backend"
	"${PROJECT}_frontend"
)
declare -a VOLUMES=(
	"${PROJECT}_db-mysql-data"
	"${PROJECT}_web-institucional-html"
	"${PROJECT}_web-ch-html"
	"${PROJECT}_mon-portainer-data"
)

echo "Downloading docker images..."
for IMAGE in "${IMAGES[@]}"; do
	docker pull "$IMAGE" || exit 1
	echo
done
echo

echo "Creating docker networks..."
for NETWORK in "${NETWORKS[@]}"; do
	if ! docker network ls | awk '{print $2}' | grep -q -E "^$NETWORK\$"; then
		echo -n "$NETWORK: "
		docker network create "$NETWORK" || exit 1
	else
		echo "Network $NETWORK already exists"
	fi
done
echo

echo "Creating docker volumes..."
for VOLUME in "${VOLUMES[@]}"; do
	if ! docker volume ls -q | grep -q -E "^$VOLUME\$"; then
		docker volume create "$VOLUME" || exit 1
	else
		echo "Volume $VOLUME already exists"
	fi
done
echo

export COMPOSE_IGNORE_ORPHANS=True

echo "Starting database services..."
docker-compose -f compose.01.db.yml up -d
echo "Wating for readiness..."
echo

sleep 10

declare -a DBS=("web_institucional" "web_ch")
for DB in "${DBS[@]}"; do
	echo "Preparing database $DB"
	docker exec "${PROJECT}_db-mysql" mysql -e "create database if not exists $DB default charset utf8mb4 default collate utf8mb4_unicode_ci"
	docker exec "${PROJECT}_db-mysql" mysql -e "create user if not exists $DB identified by 'supersecret'"
	docker exec "${PROJECT}_db-mysql" mysql -e "grant all privileges on $DB.* to '$DB'@'%'"
	echo
done
echo

echo "Starting web applications..."
docker-compose -f compose.02.web.yml up -d
echo

echo "Starting monitoring services..."
docker-compose -f compose.03.mon.yml up -d
echo

sleep 5

echo "Services now running"
echo

if [[ "$1" == "-w" ]]; then
	watch docker ps -a
else
	docker ps -a
fi

open http://localhost:9000
