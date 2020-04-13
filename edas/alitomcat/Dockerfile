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

# Address server default set to localhost.
# please refer to the following document to setup a local register server
#   https://help.aliyun.com/document_detail/44163.html
ENV CATALINA_OPTS="-Daddress.server.domain=127.0.0.1"

# Exposing arguments
ARG EDAS_CONTAINER_VERSION=3.5.9
ARG ALI_TOMCAT_VERSION=7.0.92
ARG ENDPOINT=http://edas-hz.oss-cn-hangzhou.aliyuncs.com
ARG TOMCAT_LOCATION=${ENDPOINT}/edas-container/${ALI_TOMCAT_VERSION}/taobao-tomcat-production-${ALI_TOMCAT_VERSION}.tar.gz
ARG PANDORA_LOCATION=${ENDPOINT}/edas-plugins/edas.sar.V${EDAS_CONTAINER_VERSION}/taobao-hsf.tgz
LABEL pandora V${EDAS_CONTAINER_VERSION}

# Download Ali Tomcat into workspace
ADD ${TOMCAT_LOCATION} ${WORK_HOME}/

# Set catalina location as 'edas-container'
ENV CATALINA_HOME=${WORK_HOME}/edas-container
# EDAS AliTomcat's default name is 'taobao-tomcat-production-7.0.59.3'
RUN mv ${WORK_HOME}/taobao-tomcat-production-7.0.59.3 ${CATALINA_HOME}

# Download HSF used Pandora package file into location
ADD ${PANDORA_LOCATION} ${CATALINA_HOME}/deploy/

# Export Pandora location
ENV PANDORA_LOCATION ${CATALINA_HOME}/deploy/taobao-hsf.sar/

# Export bin path
ENV PATH /home/admin/bin:${JAVA_HOME}/bin:${CATALINA_HOME}/bin:${PATH}

#RUN wget http://edas.oss-cn-hangzhou.aliyuncs.com/demo/hello-edas.war -O /tmp/ROOT.war && \
#    unzip /tmp/ROOT.war -d ${CATALINA_HOME}/deploy/ROOT && \
#    rm -rf /tmp/ROOT.war

WORKDIR ${WORK_HOME}
ADD bin /home/admin/bin

CMD ["bin/start.sh"]