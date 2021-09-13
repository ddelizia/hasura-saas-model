#!/bin/bash

set -e

hasura_down_migrations () {
  DATABASE=$1

  echo "👉 Execute all down migrations..."
  hasura migrate apply --database-name saas --disable-interactive --project ./hasura --down all 
  
  echo "👉 Checking migration status..."
  hasura migrate status --database-name saas --disable-interactive --project ./hasura 
}

hasura_up_migrations () {
  DATABASE=$1

  echo "👉 Execute all up migrations..."
  hasura migrate apply --database-name $DATABASE --disable-interactive --project ./hasura --up all 
  
  echo "👉 Checking migration status..."
  hasura migrate status --database-name $DATABASE --disable-interactive --project ./hasura 
} 

hasura_restart_migrations () {
  DATABASE=$1

  hasura_down_migrations $DATABASE

  hasura_up_migrations $DATABASE
}

hasura_init () {
  DATABASE=$1

  echo "👉 Applying metadata..."
  hasura metadata apply --project ./hasura 

  echo "👉 Checking metadata diffs..."
  hasura metadata diff --project ./hasura

  hasura_down_migrations $DATABASE

  hasura_up_migrations $DATABASE

  echo "👉 Reload metadata..."
  hasura metadata reload --project ./hasura
}

