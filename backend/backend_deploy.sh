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
then
  if [ "$( docker container inspect -f '{{.State.Running}}' 'green' )" = "true" ];
  then
    docker stop green;
  fi
  until docker container ls --filter health=healthy | grep blue
  do
    sleep 5
  done
  echo "UP green"
  docker-compose up -d green && docker stop blue;
else
  until docker container ls --filter health=healthy | grep green
  do
    sleep 5
  done
  docker-compose up -d blue && docker stop green;
  echo "UP blue"
fi
