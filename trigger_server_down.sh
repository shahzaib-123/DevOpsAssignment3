#!/usr/bin/env bash

sudo docker stop db
sudo docker stop flaskapp
sudo docker rm flaskapp
sudo docker rm db
