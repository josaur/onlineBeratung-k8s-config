#!/usr/bin/env bash

echo "Installing GSCLOUD tool"
curl -sLO https://github.com/gridscale/gscloud/releases/download/v0.11.0/gscloud_0.11.0_linux_amd64.zip
apk add unzip
unzip gscloud_0.11.0_linux_amd64.zip && \

echo "make config for gscloud tool"
./gscloud make-config
apk add nano
sed '1,/""/s//'$INPUT_GSCLOUD_USERID'/' /github/home/.config/gscloud/config.yaml -i
sed '1,/""/s//'$INPUT_GSCLOUD_TOKEN'/' /github/home/.config/gscloud/config.yaml -i
./gscloud kubernetes cluster save-kubeconfig --credential-plugin --cluster $INPUT_GSCLOUD_CLUSTERID

echo "Move all files to new directory since gscloud impacts helm upgrade"
mkdir tmp
shopt -s extglob dotglob
mv !(tmp) ./tmp
shopt -u dotglob

echo "Move out gridscale back to workspace directory"
mv tmp/gscloud ./gscloud
rm tmp/gscloud_0.11.0_linux_amd64.zip

printenv INPUT_VALUES_SECRET_YAML > ./tmp/values-secrets-$INPUT_ENVIRONMENT.yaml

helm upgrade saas ./tmp/k8s -f ./tmp/values-$INPUT_ENVIRONMENT.yaml -f ./tmp/values-secrets-$INPUT_ENVIRONMENT.yaml -n $INPUT_ENVIRONMENT
