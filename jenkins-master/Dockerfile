FROM jenkins/jenkins:lts

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dhudson.security.csrf.GlobalCrumbIssuerConfiguration=true" 

USER root

# JOB as a code
RUN /usr/local/bin/install-plugins.sh job-dsl
# PAM Authentication
RUN /usr/local/bin/install-plugins.sh pam-auth
# LDPA
RUN /usr/local/bin/install-plugins.sh ldap
# Email Extension
RUN /usr/local/bin/install-plugins.sh email-ext
# Mailer
RUN /usr/local/bin/install-plugins.sh mailer
# Plugin Pipeline
RUN /usr/local/bin/install-plugins.sh workflow-aggregator 
#Github Branch Source
RUN /usr/local/bin/install-plugins.sh github-branch-source
# Timestamper
RUN /usr/local/bin/install-plugins.sh timestamper
# Workspace CleanUp
RUN /usr/local/bin/install-plugins.sh ws-cleanup
# Pipeline Github Groovy Libraries
RUN /usr/local/bin/install-plugins.sh pipeline-github-lib
# Git
RUN /usr/local/bin/install-plugins.sh git
# Ant
RUN /usr/local/bin/install-plugins.sh ant
# Gradle
RUN /usr/local/bin/install-plugins.sh gradle
# Pipeline Stage View
RUN /usr/local/bin/install-plugins.sh pipeline-stage-view
# Subversion
RUN /usr/local/bin/install-plugins.sh subversion
# Folders
RUN /usr/local/bin/install-plugins.sh cloudbees-folder
# OWASP Markup Formatter
RUN /usr/local/bin/install-plugins.sh antisamy-markup-formatter
# Build Tomeout
RUN /usr/local/bin/install-plugins.sh build-timeout
# Matix Authoriztion Strategy
RUN /usr/local/bin/install-plugins.sh matrix-auth 
# Credentials Binding      
RUN /usr/local/bin/install-plugins.sh credentials-binding
# Configuration as a Code
RUN /usr/local/bin/install-plugins.sh configuration-as-code
# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh ssh-slaves
# Scaling
RUN /usr/local/bin/install-plugins.sh kubernetes
# install Maven
RUN apt-get update && apt-get install -y maven


# install aws-cli
RUN apt-get update
RUN apt install python3-pip -y
RUN pip3 install awscli --upgrade

# install git
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git 

# prerequisites for docker
RUN apt-get update \
    && apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

#install cointainerd
RUN curl -O https://download.docker.com/linux/ubuntu/dists/bionic/pool/edge/amd64/containerd.io_1.2.2-3_amd64.deb \
    && apt install ./containerd.io_1.2.2-3_amd64.deb 

# docker repos
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" \
    && apt-get update && apt-cache policy docker-ce

# installing docker
RUN apt-get -y install docker-ce

# docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# give docker docker rights
RUN usermod -aG docker jenkins

# start docker
RUN sed -i 's/ulimit -n 1048576/ulimit -n 65536/' /etc/init.d/docker
# RUN service docker start

RUN mkdir jenkins_config && chmod 777 -R /jenkins_config
COPY ./config /jenkins_config
RUN chmod -R 777 /jenkins_config

COPY ./keys /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa
RUN chmod 644 /root/.ssh/id_rsa.pub

RUN rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins

EXPOSE 8080