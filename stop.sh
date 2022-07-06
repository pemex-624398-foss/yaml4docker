#!/usr/bin/env bash

export COMPOSE_IGNORE_ORPHANS=True

echo "Stoping services..."

docker-compose -f compose.03.mon.yml down && \
  docker-compose -f compose.02.web.yml down && \
  docker-compose -f compose.01.db.yml down

EXIT_CODE=$?

echo

docker ps -a

echo

exit $EXIT_CODE
