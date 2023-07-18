#!/bin/bash
set +e
cat > .env <<EOF
PORT=${PORT}
DB=${DB}
EOF
docker login -u ${CI_REGISTRY_USER} -p ${$CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker stop sausage-store-backend-report || true
docker rm sausage-store-backend-report || true
set -e
docker-compose up -d backend-report --build

