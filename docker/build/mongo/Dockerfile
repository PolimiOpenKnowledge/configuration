FROM pokops/precise-common
MAINTAINER Marco Re <mrc.re@tiscali.it>

USER docker
#WORKDIR /edx/app/edx_ansible
#ENV PATH /bin:/sbin:/usr/sbin:/usr/bin
ADD inventory /etc/ansible/hosts
WORKDIR /edx/app/edx_ansible/edx_ansible/playbooks/edx-east
RUN sudo apt-get install -y dnsutils && \
    sudo apt-get install -y telnet && \
    sudo git fetch --all && \
    sudo git checkout pok-release-cypress && \
    sudo git pull
# Remove waiting for service start on port as doesn't works in a docker container
COPY ./main.yml /edx/app/edx_ansible/edx_ansible/playbooks/roles/mongo/tasks/
USER root
RUN echo "MONGO_CLUSTERED: false" > /edx/var/mongo-vars.yml
USER docker
RUN sudo ansible-playbook mongo.yml --skip-tags=firstdeploy -c local -e@/edx/var/mongo-vars.yml -e "MONGO_S3_BACKUP=false" -e "MMSAPIKEY=fake"
USER root
#RUN sed -i -e 's/keyFile = \/etc\/mongodb_key//' /etc/mongod.conf
RUN echo "bust cache"
COPY ./start.sh /scripts/start.sh
RUN chmod +x /scripts/start.sh
RUN "/scripts/start.sh"
CMD  ["mongod", "--smallfiles", "--config", "/etc/mongod.conf"]
EXPOSE 27017 27018 27019
