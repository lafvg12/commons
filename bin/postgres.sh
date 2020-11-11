#!/bin/bash

run_pg_command() {
  route="$1";
  pgcommand="$2";
  docker-compose exec postgres_global_9 psql -U postgres -c "${pgcommand}" || echo "Error with command";
  echo "$route"
  cd $route;
}

run_pg_command "$1" "$2";
