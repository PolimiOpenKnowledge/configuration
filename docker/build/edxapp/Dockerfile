FROM pokops/precise-common
MAINTAINER Marco Re <mrc.re@tiscali.it>

USER docker
WORKDIR /edx/app/edx_ansible/edx_ansible
RUN sudo git fetch --all
RUN sudo git checkout docker
RUN sudo git reset --hard origin/docker
RUN sudo git pull
WORKDIR /edx/app/edx_ansible/edx_ansible/docker/plays

COPY ./server-vars.yml /edx/app/edx_ansible/server-vars.yml
COPY ./secure-vars.yml /edx/app/edx_ansible/pok/secure/secure-vars.yml
RUN sudo ansible-playbook pok-edxapp.yml -c local -e "EDXAPP_PYTHON_SANDBOX=false" -e"edx_ansible_var_file=/edx/app/edx_ansible/server-vars.yml" -e"EDXAPP_MYSQL_HOST=edxapp.mysql.docker.pok" -e"EDXAPP_MONGO_HOSTS=edxapp.mongo.docker.pok"
USER root
CMD ["/usr/sbin/rsyslogd"]
CMD ["/edx/app/supervisor/venvs/supervisor/bin/supervisord", "-n", "--configuration", "/edx/app/supervisor/supervisord.conf"]
EXPOSE 18000 48000 18020 18010 48010 8010 8000
