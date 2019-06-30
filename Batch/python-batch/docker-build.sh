#!/bin/sh

docker build \
    -t ${AWS_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/$1:$2 \
    --build-arg WEBHOOK_URL=${WEBHOOK_URL} .
