#!/bin/bash
OPENEDX_RELEASE=open-release/eucalyptus.3

export PYTHONUNBUFFERED=1

if [ -n "$OPENEDX_RELEASE" ]; then
EXTRA_VARS="
    -e edx_platform_version=$OPENEDX_RELEASE \
    -e configuration_version=$OPENEDX_RELEASE \
    -e certs_version=$OPENEDX_RELEASE \
    -e forum_version=$OPENEDX_RELEASE \
    -e xqueue_version=$OPENEDX_RELEASE \
    -e demo_version=$OPENEDX_RELEASE \
    -e NOTIFIER_VERSION=$OPENEDX_RELEASE \
    -e ECOMMERCE_VERSION=$OPENEDX_RELEASE \
    -e ECOMMERCE_WORKER_VERSION=$OPENEDX_RELEASE \
    -e PROGRAMS_VERSION=$OPENEDX_RELEASE \
    -e INSIGHTS_VERSION=$OPENEDX_RELEASE \
  "
  CONFIG_VER="eucalyptus.update"
else
  CONFIG_VER="master"
fi

sudo ansible-playbook -i localhost, -c local edx_sandbox.yml -e configuration_version=$CONFIG_VER $EXTRA_VARS  
#sudo ansible-playbook -i localhost, -c local edx_sandbox.yml -e configuration_version=$CONFIG_VER $EXTRA_VARS  --tags=ecommerce_install

