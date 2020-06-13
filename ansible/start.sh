#!/bin/bash
ansible-playbook aks_cli_create.yml -vvv
./../setup/aks_connect.sh -u calvinlym
ansible-playbook application_deployment.yml -e env=prod -vvv
