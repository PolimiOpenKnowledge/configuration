FROM ubuntu:precise
MAINTAINER Marco Re <mrc.re@tiscali.it>

RUN apt-get update && \
    apt-get -y install sudo && \
    useradd docker && echo "docker:docker" | chpasswd
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN mkdir -p /home/docker && chown -R docker:docker /home/docker
RUN apt-get install -y python2.7 python2.7-dev python-pip python-apt python-yaml python-jinja2 git net-tools isc-dhcp-client landscape-common update-notifier-common ssh
USER docker

# bootstrap
RUN sudo git clone --recursive https://github.com/edx/ansible /tmp/ansible
WORKDIR /tmp/ansible
ENV PATH /tmp/ansible/bin:/bin:/sbin:/usr/sbin:/usr/bin

# Install the configuration repository to install
# edx-ansible role
RUN sudo git clone http://github.com/marcore/configuration.git /tmp/configuration
ADD inventory /etc/ansible/hosts
WORKDIR /tmp/configuration
RUN sudo git checkout docker
RUN sudo pip install -r pre-requirements.txt
RUN sudo pip install -r requirements.txt
WORKDIR /tmp/configuration/playbooks/edx-east
# Remove ifconfig mtu operation not permitted in docker container ? Need investigation
COPY ./main.yml /tmp/configuration/playbooks/roles/aws/tasks/
RUN sudo /tmp/ansible/bin/ansible-playbook edx_ansible.yml -c local -e "configuration_version=docker" -e"edx_ansible_source_repo=https://github.com/marcore/configuration.git"

# cleanup
RUN sudo rm -rf /tmp/ansible && \
    sudo rm -rf /tmp/configuration
