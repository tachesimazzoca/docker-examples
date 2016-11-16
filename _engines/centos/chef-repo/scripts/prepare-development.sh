#!/bin/sh

cd `dirname ${0}`

./prepare-node.sh "${1}" dev-docker-engine development 'role[docker-engine]'
