#!/bin/bash
set +e
cat > .env <<EOF
CURRENT_VERSION=${CURRENT_VERSION}
VERSION=${VERSION}
DEV_HOST=${DEV_HOST}
EOF
docker login -u ${CI_REGISTRY_USER} -p ${$CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/std-017-003/sausage-store/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker run -d --name frontend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    --port 80:80 \
    gitlab.praktikum-services.ru:5050/std-017-003/sausage-store/sausage-frontend:latest