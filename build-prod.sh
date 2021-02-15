#!/usr/bin/env bash

set -e
set -o nounset

REPO="marcoadkins/actions-label-merge-conflict"

set -x

docker build -t "${REPO}:v1" .
docker tag "${REPO}:v1" "${REPO}:latest"
docker push "${REPO}:v1"
docker push "${REPO}:latest"

set +x
