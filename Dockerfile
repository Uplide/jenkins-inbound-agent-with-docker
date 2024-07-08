FROM --platform=linux/amd64 jenkins/inbound-agent:latest

USER root

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

RUN apt-get update && apt-get install -y docker.io

RUN groupadd docker || true
RUN usermod -aG docker jenkins

USER jenkins
