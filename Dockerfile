FROM jenkins/jenkins:2.501-jdk17

USER root

# Instalar dependencias y Docker
COPY script.sh /script.sh
RUN chmod +x /script.sh && bash /script.sh

USER jenkins

