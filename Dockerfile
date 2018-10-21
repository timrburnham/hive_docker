FROM ubuntu:16.04

# Add Hortonworks repos
ADD http://public-repo-1.hortonworks.com/HDP/ubuntu16/2.x/updates/2.6.5.0/hdp.list /etc/apt/sources.list.d/hdp.list
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD

# Update Ubuntu and install software
RUN     apt-get update &&\
        apt-get upgrade -y &&\
        apt-get install -y \
        vim \
        openjdk-8-jdk \
        hive

COPY hive-site.xml hive-log4j.properties /etc/hive/conf/
COPY tez-site.xml /etc/tez/conf/
COPY start.sh /var/lib/hive/

RUN     mkdir -p /tmp/hive &&\
        chown hive:hive /tmp/hive &&\
        chmod 777 /tmp/hive &&\
        mkdir -p /user/hive &&\
        chown hive:hive /user/hive &&\
        chmod 755 /user/hive &&\
        chown hive:hive /var/lib/hive/start.sh &&\
        chmod 755 /var/lib/hive/start.sh

USER hive:hive
WORKDIR /var/lib/hive

ENV     JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
        HADOOP_HEAPSIZE=1024
RUN /usr/hdp/current/hive-server2/bin/schematool -dbType derby -initSchema 2> /dev/null
VOLUME ["/var/lib/hive", "/user/hive"]

EXPOSE 10000/tcp
CMD ["./start.sh"]