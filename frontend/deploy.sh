#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
#Переносим артефакт в нужную папку
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPO_FRONTEND_URL}/sausage-store-front/sausage-store/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo cp ./sausage-store.tar.gz /var/www-data/sausage-store.tar.gz
#Распаковываем
cd /var/www-data/
sudo tar -xzvf sausage-store.tar.gz
#Меняем владельцев
sudo chown -R front-user /var/www-data/frontend
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-frontend
