#!/bin/bash
set +e
docker login -u ${CI_REGISTRY_USER} -p ${$CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker stop sausage-store-frontend || true
docker rm sausage-store-frontend || true
set -e
docker-compose up -d frontend --build
