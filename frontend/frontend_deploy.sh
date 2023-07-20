#!/bin/bash
set +e
docker stop sausage-store-frontend || true
docker rm sausage-store-frontend || true
set -e
docker-compose up -d --build frontend