#!/bin/bash

sudo docker swarm init
_token=$(sudo docker swarm join-token worker -q)
echo $_token > /home/ubuntu/token
sudo cp /home/ubuntu/token /var/www/html/
