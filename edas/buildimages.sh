#!/usr/bin/env bash


function build_alitomcat {
  EDAS_CONTAINER_VERSION=${1}
  ALI_TOMCAT_VERSION=${2}
  TOMCAT_LABEL=${3}

  ENDPOINT=http://edas-hz.oss-cn-hangzhou.aliyuncs.com
  TOMCAT_LOCATION=${ENDPOINT}/edas-container/${ALI_TOMCAT_VERSION}/taobao-tomcat-production-${ALI_TOMCAT_VERSION}.tar.gz
  PANDORA_LOCATION=${ENDPOINT}/edas-plugins/edas.sar.V${EDAS_CONTAINER_VERSION}/taobao-hsf.tgz

  TOMCAT_FILE="build/tmp/taobao-tomcat.tar.gz"
  PANDORA_FILE="build/tmp/taobao-hsf.tar.gz"

  mkdir -p build/tmp
  wget ${TOMCAT_LOCATION} -O  ${TOMCAT_FILE}
  wget ${PANDORA_LOCATION} -O ${PANDORA_FILE}

  # set version as tomcatversion.replace(pandoraversion, '.', '')
  VERSION=${ALI_TOMCAT_VERSION}.${EDAS_CONTAINER_VERSION//./}
  docker build -f alitomcat/Dockerfile ./ \
    --build-arg TOMCAT_LOCATION=${TOMCAT_FILE} \
    --build-arg PANDORA_LOCATION=${PANDORA_FILE} \
    -t apaas/edas-centos-openjdk8-${TOMCAT_LABEL}:${VERSION} \
    -t apaas/edas-centos-openjdk8-${TOMCAT_LABEL}:latest
  #docker push apaas/edas-centos-openjdk8-${TOMCAT_LABEL}:${VERSION}
  #docker push apaas/edas-centos-openjdk8-${TOMCAT_LABEL}:latest
}

function build_tomcat {
  TOMCAT_VERSION=${1}
  TOMCAT_LABEL=${2}

  ENDPOINT=http://edas-hz.oss-cn-hangzhou.aliyuncs.com
  TOMCAT_LOCATION=${ENDPOINT}/agent/prod/files/apache-tomcat-${TOMCAT_VERSION}.tar.gz

  TOMCAT_FILE="build/tmp/tomcat.tar.gz"

  mkdir -p build/tmp
  wget ${TOMCAT_LOCATION} -O  ${TOMCAT_FILE}

  docker build -f tomcat/Dockerfile ./ \
    --build-arg TOMCAT_LOCATION=${TOMCAT_FILE} \
    --build-arg TOMCAT_FULLNAME=apache-tomcat-${TOMCAT_VERSION} \
    -t apaas/edas-centos-openjdk8-${TOMCAT_LABEL}:${TOMCAT_VERSION} \
    -t apaas/edas-centos-openjdk8-${TOMCAT_LABEL}:latest \
    -t apaas/edas:latest

  #docker push apaas/edas-centos-openjdk8-${TOMCAT_LABEL}:${TOMCAT_VERSION}
  #docker push apaas/edas-centos-openjdk8-${TOMCAT_LABEL}:latest
  #docker push apaas/edas:latest
}

function build_anolis {
  TOMCAT_VERSION=${1}
  TOMCAT_LABEL=${2}

  ENDPOINT=http://edas-hz.oss-cn-hangzhou.aliyuncs.com
  TOMCAT_LOCATION=${ENDPOINT}/agent/prod/files/apache-tomcat-${TOMCAT_VERSION}.tar.gz

  TOMCAT_FILE="build/tmp/tomcat.tar.gz"

  mkdir -p build/tmp
  wget ${TOMCAT_LOCATION} -O  ${TOMCAT_FILE}

  docker build -f openanolis/Dockerfile ./ \
    --build-arg TOMCAT_LOCATION=${TOMCAT_FILE} \
    --build-arg TOMCAT_FULLNAME=apache-tomcat-${TOMCAT_VERSION} \
    -t apaas/edas-openanolis-openjdk8-${TOMCAT_LABEL}:${TOMCAT_VERSION} \
    -t apaas/edas-openanolis-openjdk8-${TOMCAT_LABEL}:latest \
    -t apaas/edas-openanolis:latest

  #docker push apaas/edas-centos-openjdk8-${TOMCAT_LABEL}:${TOMCAT_VERSION}
  #docker push apaas/edas-centos-openjdk8-${TOMCAT_LABEL}:latest
  #docker push apaas/edas:latest
}



build_alitomcat "3.5.9" "7.0.92" "alitomcat7"
build_alitomcat "3.5.9" "8.5.37" "alitomcat8"

build_tomcat "7.0.93" "tomcat7"
build_tomcat "8.5.42" "tomcat8"
build_anolis "7.0.93" "tomcat7"
build_anolis "8.5.42" "tomcat8"
