#!/bin/sh

docker push \
    ${AWS_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/$1:$2
