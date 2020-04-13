FROM centos:7
LABEL maintainer="Alibaba Cloud EDAS Team<edas-dev@list.alibaba-inc.com>"

# Install building and running env tools
RUN yum install -y wget \
    unzip \
    telnet \
    lsof \
    net-tools \
    bind-utils \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-headless \
    java-1.8.0-openjdk-devel ; \
    yum clean metadata; \
    yum clean all

# Default set JAVA_HOME and working dir
ENV JAVA_HOME=/usr/java/latest
ENV WORK_HOME=/home/admin
ENV LANG="en_US.UTF-8"
ENV TERM=xterm

# http://edas-hz.oss-cn-hangzhou.aliyuncs.com/agent/prod/files/apache-tomcat-8.5.42.tar.gz
# Exposing arguments
ARG ENDPOINT=http://edas-hz.oss-cn-hangzhou.aliyuncs.com
ARG TOMCAT_LOCATION=${ENDPOINT}/agent/prod/files/apache-tomcat-7.0.91.tar.gz
ARG TOMCAT_FULLNAME=apache-tomcat-7.0.91

ADD ${TOMCAT_LOCATION} ${WORK_HOME}/

# Set catalina location as 'edas-container'
ENV CATALINA_HOME=${WORK_HOME}/${TOMCAT_FULLNAME}

# Export bin path
ENV PATH /home/admin/bin:${JAVA_HOME}/bin:${CATALINA_HOME}/bin:${PATH}

# you can uncomment the following instructions
#ADD http://${ENDPOINT}/demo/hello-edas.war /home/admin/app/

WORKDIR ${WORK_HOME}
ADD bin /home/admin/bin

CMD ["bin/start.sh"]