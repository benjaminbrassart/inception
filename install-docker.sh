#!/bin/bash

set -e

PKGS="ca-certificates curl gnupg lsb-release"
DOCKER_PKGS="docker-ce docker-ce-cli containerd.io docker-compose-plugin"

apt update
apt install -y ${PKGS}

mkdir -p /etc/apt/keyrings

curl -fsSL 'https://download.docker.com/linux/debian/gpg' | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

ARCH="$(dpkg --print-architecture)"
RELEASE="$(lsb_release -cs)"
DEB="deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian ${RELEASE} stable"

echo "${DEB}" | tee /etc/apt/sources.list.d/docker.list

apt update
apt install -y ${DOCKER_PKGS}

docker run hello-world
