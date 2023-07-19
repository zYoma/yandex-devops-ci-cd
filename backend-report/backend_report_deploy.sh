#!/bin/bash
set +e


docker stop sausage-store-backend-report || true
docker rm sausage-store-backend-report || true
set -e
docker-compose up -d --build backend-report
