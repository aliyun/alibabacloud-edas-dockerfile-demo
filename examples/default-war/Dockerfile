FROM apaas/edas:latest
LABEL maintainer="Alibaba Cloud EDAS Team<edas-dev@list.alibaba-inc.com>"

# Default put your application package into /home/admin/app/
ENV APP_HOME /home/admin/app/

##### SIMPLE REPLACE YOUR PACKAGE FILE HERE
ARG APP_LOCATION=http://edas-bj.oss-cn-beijing.aliyuncs.com/prod/demo/DUBBO_PROVIDER.war

# Then download to package into /home/admin/app/
ADD ${APP_LOCATION} ${APP_HOME}/

# After you build the image, you can then put your application run inside EDAS:
# See document: https://help.aliyun.com/document_detail/84095.html

