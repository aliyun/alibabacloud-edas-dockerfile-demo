FROM apaas/edas:latest
MAINTAINER Alibaba Cloud EDAS Team<edas-dev@list.alibaba-inc.com>

# Default put your application package into /home/admin/app/
ENV APP_HOME /home/admin/app/

##### SIMPLE REPLACE YOUR PACKAGE FILE HERE
ARG APP_LOCATION=https://edas-bj.oss-cn-beijing.aliyuncs.com/prod/demo/SPRING_CLOUD_PROVIDER.jar

ENV APP_ARGS="--server.context-path=/ \
              --server.port=8082 \
              --server.tomcat.max-threads=600"

ENV JAVA_OPTS="\
     -Xmx3550m \
     -Xms3550m \
     -Xmn2g \
     -Xss228k"
# Then download to package into /home/admin/app/
ADD ${APP_LOCATION} ${APP_HOME}/

# After you build the image, you can then put your application run inside EDAS:
# See document: https://help.aliyun.com/document_detail/84095.html

