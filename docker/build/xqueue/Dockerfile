FROM pokops/precise-common
MAINTAINER Marco Re <mrc.re@tiscali.it>

USER docker

WORKDIR /edx/app/edx_ansible/edx_ansible
RUN sudo git fetch --all
RUN sudo git checkout docker
RUN sudo git reset --hard origin/docker
RUN sudo git pull

WORKDIR /edx/app/edx_ansible/edx_ansible/playbooks/edx-east
WORKDIR /edx/app/edx_ansible/edx_ansible/docker/plays
RUN echo "bust-cache"
RUN sudo ansible-playbook xqueue.yml -c local
USER root
COPY ./docker-run.sh /
ENTRYPOINT ["/docker-run.sh"]
EXPOSE 18040 8040
