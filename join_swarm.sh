#/bin/bash

_ip=$(cat /home/ubuntu/master_ip)
_token=$(wget -qO- http://$_ip/token)
echo $_token
echo $_ip
sudo docker swarm join --token $_token $_ip:2377
