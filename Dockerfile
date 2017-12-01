FROM jenkins/jenkins:lts

USER root
RUN apt-get -qq update && apt-get install -qq sudo
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz \
    && tar -xvzf docker-17.09.0-ce.tgz \
    && mv docker/* /usr/bin/
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

USER jenkins
RUN /usr/local/bin/install-plugins.sh docker-plugin kubernetes gitlab-hook blueocean \
    jenkins-multijob-plugin pipeline-model-definition
