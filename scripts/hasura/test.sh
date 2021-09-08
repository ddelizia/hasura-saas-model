#!/bin/bash

set -e

. ./scripts/hasura/functions.sh

DATABASE="saas"

echo "🧪 Resetting the database"
hasura_reset $DATABASE

echo "🧪 Executing all down migrations"
hasura_down_migrations $DATABASE

echo "🧪 Executing all up migrations"
hasura_up_migrations $DATABASE