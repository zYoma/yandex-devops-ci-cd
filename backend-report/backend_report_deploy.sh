#!/bin/bash
set +e
cat > .env <<EOF
PORT=8081
DB=${DB}
EOF
docker stop sausage-store-backend-report || true
docker rm sausage-store-backend-report || true
set -e
docker-compose up -d --build backend-report
