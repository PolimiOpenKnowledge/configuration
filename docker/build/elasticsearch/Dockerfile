FROM pokops/precise-common
MAINTAINER Marco Re <mrc.re@tiscali.it>

USER docker
WORKDIR /edx/app/edx_ansible
WORKDIR /edx/app/edx_ansible/edx_ansible/playbooks/edx-east
RUN sudo git checkout pok-release-cypress
RUN sudo git reset --hard origin/pok-release-cypress
RUN sudo git pull
COPY ./elasticsearch-docker.yml /edx/app/edx_ansible/edx_ansible/playbooks/edx-east/
RUN sudo ansible-playbook elasticsearch-docker.yml -c local
USER root
WORKDIR /etc/elasticsearch
CMD ["/usr/share/elasticsearch/bin/elasticsearch","-f"]
EXPOSE 9200 9300
