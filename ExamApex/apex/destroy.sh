#!/bin/sh

apex delete -f
sleep 10
apex infra destroy -auto-approve
