FROM --platform=linux/amd64 jenkins/inbound-agent:latest

USER root

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    unzip

RUN apt-get update && apt-get install -y docker.io

RUN groupadd docker || true
RUN usermod -aG docker jenkins

RUN curl -Lo /tmp/sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.1.0.4477-linux-x64.zip \
    && unzip /tmp/sonar-scanner-cli.zip -d /opt \
    && mv /opt/sonar-scanner-6.1.0.4477-linux-x64 /opt/sonar-scanner \
    && ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner

RUN echo 'export PATH=$PATH:/opt/sonar-scanner/bin' >> /etc/profile.d/sonar-scanner.sh

USER jenkins
