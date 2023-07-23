#!/bin/bash
set +e
cat > .env <<EOF
SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
SPRING_DATA_MONGODB_URI=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@rc1a-u0nwp06gbwh8qsoq.mdb.yandexcloud.net:27018/${MONGO_USER}?tls=true&tlsAllowInvalidCertificates=true
EOF
set -e
if [ "$( docker container inspect -f '{{.State.Running}}' 'blue' )" = "true" ];
then docker stop green && docker-compose up -d --build green && docker stop blue;
else docker stop blue && docker-compose up -d --build blue && docker stop green;
fi
