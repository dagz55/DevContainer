#!/bin/bash

# Download and extract Istio
curl -L https://istio.io/downloadIstio | sh -

# Move to the Istio package directory
cd istio-* || { echo "Failed to change directory to istio-*"; exit 1; }

# Add istioctl to the PATH
export PATH=$PWD/bin:$PATH

# Install Istio using the demo configuration profile
istioctl install --set profile=demo -y

# Label the default namespace for Istio sidecar injection
kubectl label namespace default istio-injection=enabled

# Clean up the downloaded Istio directory
cd ../
rm -rf istio-*