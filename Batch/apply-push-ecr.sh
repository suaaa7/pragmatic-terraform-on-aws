#!/bin/sh

terraform apply -target=module.ecr -var "project=$1" -var "tag=$2" -auto-approve
cd python-batch
sleep 10
bash docker-push.sh $1 $2
