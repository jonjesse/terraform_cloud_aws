# USAGE

This script will perform the follwing:
1. Deploy 3 docker nodes. One docker node will be deployed as manager, two others will be deployed as worker and automatically join the master
2. Deploy an application, details about application in monitor.sh

Get latest terraform docker

```
docker pull hashicorp/terraform:latest
```

Run terraform:

First initialize:

```
docker run -it --rm -v $PWD:/home -v /root/aws:/root -w /home hashicorp/terraform:latest init
```

Run terraform:
```
docker run -it --rm -v $PWD:/home -v /root/aws:/root -w /home hashicorp/terraform:latest plan -var-file="/root/production.tfvars"
```
Run apply

You may forgo "-var-file", terraform will ask you for the variable when you run it
