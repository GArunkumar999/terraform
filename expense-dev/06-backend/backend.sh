#!/bin/bash

dnf install ansible -y

ansible-pull -i localhost, -U https://github.com/GArunkumar999/Ansibleroles.git main.yaml -e component=backend -e environment=$1