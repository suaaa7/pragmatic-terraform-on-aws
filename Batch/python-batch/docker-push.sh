#!/bin/sh

docker push \
    ${AWS_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${TAG}
