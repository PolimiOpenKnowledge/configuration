FROM pokops/precise-common
MAINTAINER Marco Re <mrc.re@tiscali.it>

USER docker
WORKDIR /edx/app/edx_ansible/edx_ansible
RUN sudo git fetch --all
RUN sudo git checkout docker
RUN sudo git reset --hard origin/docker
RUN sudo git pull
WORKDIR /edx/app/edx_ansible/edx_ansible/docker/plays
RUN sudo ansible-playbook nginx.yml -c local \
   -e@roles/edxapp/defaults/main.yml \
   -e@roles/xqueue/defaults/main.yml \
   -e@roles/ora/defaults/main.yml \
   -e@roles/certs/defaults/main.yml \
   -e@roles/apache/defaults/main.yml

USER root
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
WORKDIR /etc/nginx
CMD ["/usr/sbin/nginx"]
EXPOSE 18000 48000 18010 48010 18020
