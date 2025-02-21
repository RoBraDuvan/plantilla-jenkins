#!/bin/bash

echo "Ejecutando entrypoint como: $(whoami)"

# Asegurar que se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Debe ejecutarse como root. Cambiando a root..."
    exec sudo /entrypoint.sh
    exit 1
fi

# Obtener el ID del grupo 'docker' en el host
DOCKER_GROUP_ID=$(stat -c "%g" /var/run/docker.sock)

# Si el grupo 'docker' no existe en el contenedor, lo creamos con el mismo ID que el host
if ! getent group docker >/dev/null; then
    groupadd -g $DOCKER_GROUP_ID docker
fi

# Agregar el usuario jenkins al grupo docker
usermod -aG docker jenkins

# Corregir permisos en /var/jenkins_home
chown -R jenkins:jenkins /var/jenkins_home

# Cambiar al usuario Jenkins y ejecutar Jenkins normalmente
exec gosu jenkins /usr/local/bin/jenkins.sh
