#!/bin/bash
set +e
cat > .env <<EOF
SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
SPRING_DATA_MONGODB_URI=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@rc1a-u0nwp06gbwh8qsoq.mdb.yandexcloud.net:27018/${MONGO_USER}?tls=true&tlsAllowInvalidCertificates=true
EOF
docker stop sausage-store-backend || true
docker rm sausage-store-backend || true
set -e
docker-compose up -d --build backend
