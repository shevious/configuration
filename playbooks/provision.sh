#!/bin/bash

OPENEDX_RELEASE="open-release/ficus.master"

export PYTHONUNBUFFERED=1
sudo -Hu edx-ansible rm -rf /edx/app/edx_ansible/edx_ansible
sudo -Hu edx-ansible git clone --origin origin --branch ficus.update https://github.com/shevious/configuration.git /edx/app/edx_ansible/edx_ansible
source /edx/app/edx_ansible/venvs/edx_ansible/bin/activate
cd /edx/app/edx_ansible/edx_ansible/playbooks

EXTRA_VARS="-e edx_platform_version=$OPENEDX_RELEASE \
  -e configuration_version=$OPENEDX_RELEASE \
  -e certs_version=$OPENEDX_RELEASE \
  -e forum_version=$OPENEDX_RELEASE \
  -e xqueue_version=$OPENEDX_RELEASE \
  -e demo_version=$OPENEDX_RELEASE \
  -e NOTIFIER_VERSION=$OPENEDX_RELEASE \
  -e ECOMMERCE_VERSION=$OPENEDX_RELEASE \
  -e ECOMMERCE_WORKER_VERSION=$OPENEDX_RELEASE \
  -e PROGRAMS_VERSION=$OPENEDX_RELEASE \
"
CONFIG_VER="ficus.update"

ansible-playbook -i localhost, -c local run_role.yml -e role=edx_ansible -e configuration_version=$CONFIG_VER $EXTRA_VARS
ansible-playbook -i localhost, -c local vagrant-devstack.yml -e configuration_version=$CONFIG_VER $EXTRA_VARS
