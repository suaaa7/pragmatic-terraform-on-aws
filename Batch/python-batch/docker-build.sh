#!/bin/sh

docker build \
    -t ${AWS_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${TAG} \
    --build-arg WEBHOOK_URL=${WEBHOOK_URL} \
    --build-arg BUCKET_NAME=${BUCKET_NAME} --no-cache .
