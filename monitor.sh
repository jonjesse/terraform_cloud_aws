#!/bin/bash
# Joins woker to manager node and deploys an application
run_stack() {
  cd /home/ubuntu/
  git clone https://github.com/jonjesse/example-voting-app.git
  cd /home/ubuntu/example-voting-app/
  sudo docker stack deploy --compose-file docker-stack.yml vote
  if [ $? -eq 0 ]; then
    echo "Docker stack started successfully"
  else
    echo "Failed to start docker stack"
  fi
}

while true; do
  sudo docker node ls > /home/ubuntu/output
  /usr/bin/wc -l /home/ubuntu/output > /home/ubuntu/nodes
  _nodes=$(/usr/bin/awk '{print $1}' /home/ubuntu/nodes)
  echo $_nodes
  if [ $_nodes -ge 4 ]; then
    run_stack 
    exit 0
  else
    echo "looking for 3 nodes"
    sleep 10;
   fi 
done
