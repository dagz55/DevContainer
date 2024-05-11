#!/bin/bash

# Fetch the latest Istio version
ISTIO_VERSION=$(curl -L https://istio.io/downloadIstio | grep -oP 'istio-\K\d+\.\d+\.\d+')

# Download and install Istio
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=${ISTIO_VERSION} sh -

# Move the istioctl binary to /usr/local/bin/
mv istio-${ISTIO_VERSION}/bin/istioctl /usr/local/bin/

# Clean up the downloaded Istio directory
rm -rf istio-${ISTIO_VERSION}