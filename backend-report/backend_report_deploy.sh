#!/bin/bash
set +e
cat > .env <<EOF
PORT=${PORT}
DB=${DB}
EOF
docker login -u ${CI_REGISTRY_USER} -p ${$CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/std-017-003/sausage-store/sausage-backend-report:latest
docker stop backend-report || true
docker rm backend-report || true
set -e
docker-compose up -d backend-report --build
