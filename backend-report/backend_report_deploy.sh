#!/bin/bash
set +e
cat > .env <<EOF
PORT=8081
DB=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@rc1a-u0nwp06gbwh8qsoq.mdb.yandexcloud.net:27018/${MONGO_USER}?tls=true&tlsAllowInvalidCertificates=true
EOF
docker stop sausage-store-backend-report || true
docker rm sausage-store-backend-report || true
set -e
docker-compose up -d --build backend-report
