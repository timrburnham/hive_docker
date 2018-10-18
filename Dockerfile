FROM ubuntu:16.04

# Update Ubuntu and install utilities
RUN apt-get update && apt-get upgrade -y
RUN apt-get install wget vim -y

# Add Hortonworks Repos
RUN wget -O /etc/apt/sources.list.d/hdp.list http://public-repo-1.hortonworks.com/HDP/ubuntu16/2.x/updates/2.6.5.0/hdp.list
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
RUN apt-get update

# Install Hive
RUN apt-get install openjdk-8-jdk hive -y

RUN mkdir -p /tmp/hive
RUN chown hive:hive /tmp/hive
RUN chmod 777 /tmp/hive

RUN mkdir -p /user/hive
RUN chown hive:hive /user/hive
RUN chmod 775 /user/hive

USER hive:hive
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HOME=/var/lib/hive
WORKDIR ${HOME}
RUN /usr/hdp/current/hive-server2/bin/schematool -dbType derby -initSchema 2> /dev/null
VOLUME ["/var/lib/hive","/user/hive"]

EXPOSE 10000/tcp
CMD ["/usr/hdp/current/hive-server2/bin/hive.distro","--service","hiveserver2","--hiveconf","hive.root.logger=INFO,console"]
