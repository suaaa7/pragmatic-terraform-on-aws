#!/bin/sh

terraform apply -target=module.ecr -auto-approve
sleep 15
docker push \
    ${AWS_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}
