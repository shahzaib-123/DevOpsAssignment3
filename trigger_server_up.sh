#!/usr/bin/env bash

IMAGE_NAME="flaskapp"

sudo docker run -p 3306:3306 --name db -v /home/ubuntu/db_volume:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=test -d mariadb
if docker image inspect "$IMAGE_NAME" &> /dev/null; then
    echo "Removing existing Docker image: $IMAGE_NAME"
    docker image rm "$IMAGE_NAME"
fi
sudo docker build -t flaskapp .
sudo docker run -p 5000:5000 --name flaskapp flaskapp




