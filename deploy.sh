#!/bin/bash

set -e

APP_DIR="/opt/app"

echo "===> Обновляем систему"
sudo apt update

echo "===> Устанавливаем git"
sudo apt install -y git

echo "===> Удаляем старый проект"
sudo rm -rf $APP_DIR

echo "===> Клонируем репозиторий"
sudo docker compose down -v || true
sudo git clone https://github.com/PeterP-DevOps/Practical-Application-of-Docker.git $APP_DIR

echo "===> Создаём .env"
sudo tee $APP_DIR/.env > /dev/null <<EOF
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=virtd
MYSQL_USER=app
MYSQL_PASSWORD=very_strong
EOF

cd $APP_DIR

echo "===> Запускаем docker compose"
sudo docker compose up -d --build

echo "===> Готово!"

