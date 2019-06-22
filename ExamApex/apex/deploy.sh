#!/bin/sh

apex infra apply -target=module.iam -auto-approve
sleep 10
apex deploy
sleep 10
apex infra apply -auto-approve
