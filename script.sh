#!/bin/bash

# Actualizar la lista de paquetes
apt update

# Instalar zip
apt install -y zip

# Instalar Node.js y npm
apt install -y nodejs npm 

# Instalar Docker
apt install -y docker.io
usermod -aG docker jenkins
chmod 666 /var/run/docker.sock

# Instalar GCLOUD
apt install apt-transport-https ca-certificates gnupg curl
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && apt-get update -y && apt-get install google-cloud-cli -y


echo "Actualización y descarga completadas."