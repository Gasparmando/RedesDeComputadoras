#!/bin/bash


sudo docker ps -a -q >> DOCKERS
sudo docker rm -f $DOCKERS
sudo docker network prune
Y


