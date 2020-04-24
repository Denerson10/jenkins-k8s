FROM ubuntu:bionic

RUN apt-get update && apt-get install software-properties-common wget curl -y
RUN add-apt-repository ppa:linuxuprising/java
RUN apt-get update && apt-get install default-jre -y

RUN java --version

RUN wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war

# RUN java -jar jenkins.war

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

COPY ./jenkins_home /root/.jenkins
COPY ./jenkins.sh /

RUN usermod -aG docker root

EXPOSE 8080
