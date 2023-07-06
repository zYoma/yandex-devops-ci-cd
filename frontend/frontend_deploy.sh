#!/bin/bash
set +e
docker login -u ${CI_REGISTRY_USER} -p ${$CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/std-017-003/sausage-store/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker run -d -p 80:80 --name frontend \
    --network=sausage_network \
    --restart always \
    --pull always \
    gitlab.praktikum-services.ru:5050/std-017-003/sausage-store/sausage-frontend:latest