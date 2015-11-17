#!/bin/bash
cd /edx/app/edx_ansible/edx_ansible/playbooks/edx-east
mongod --fork --smallfiles --config /etc/mongod.conf && sudo ansible-playbook mongo.yml -t firstdeploy -c local -e@/edx/var/mongo-vars.yml -e "MONGO_S3_BACKUP=false" -e "MMSAPIKEY=fake"
