FROM --platform=linux/amd64 jenkins/inbound-agent:latest

USER root

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    unzip \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# docker-cli kur
RUN apt-get update && apt-get install -y docker.io && rm -rf /var/lib/apt/lists/*

RUN groupadd docker || true
RUN usermod -aG docker jenkins

# Node.js 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Yarn
RUN npm install -g yarn

# SonarQube Scanner
RUN curl -Lo /tmp/sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.1.0.4477-linux-x64.zip \
    && unzip /tmp/sonar-scanner-cli.zip -d /opt \
    && mv /opt/sonar-scanner-6.1.0.4477-linux-x64 /opt/sonar-scanner \
    && ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner \
    && rm /tmp/sonar-scanner-cli.zip

RUN echo 'export PATH=$PATH:/opt/sonar-scanner/bin' >> /etc/profile.d/sonar-scanner.sh

USER jenkins
