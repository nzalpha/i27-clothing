#!/bin/bash

ENVIRONMENT="${1-dev}"

case "$ENVIRONMENT" in

   dev)
      echo "Starting in app in dev mode"
      npm run start:dev
      ;;
   test)
       echo "Starting app in test mode"
       npm run start:test
       ;;
    prod) 
        echo "Starting the application in Production mode..."
        npm run start:prod
        ;;
    *)
        echo "Invalid environment specified, Valid options are 'dev', 'test', 'prod'"
        exit 1
        ;;
esac