#!/usr/bin/env bash


function ensure_correct_pandora {
    if [ -z "${UPGRADED_CONTAINER_VERSION}" ]; then
        echo "UPGRADED_CONTAINER_VERSION is Empty, ignore"
        return
    fi

    echo "will upgrade pandora to ${UPGRADED_CONTAINER_VERSION}"

    VERSION=${UPGRADED_CONTAINER_VERSION}

    ENDPOINT=http://edas-hz.oss-cn-hangzhou.aliyuncs.com
    PANDORA_LOCATION=${ENDPOINT}/edas-plugins/edas.sar.V${VERSION}
    PANDORA_LOCATION=${PANDORA_LOCATION}/taobao-hsf.tgz
    PANDORA_DIR="/home/admin/edas-container/deploy/"

    rm -rf ${PANDORA_DIR}/*
    wget ${PANDORA_LOCATION} -O ${PANDORA_DIR}/taobao-hsf.tgz
    cd ${PANDORA_DIR}; tar xvfz ${PANDORA_DIR}/taobao-hsf.tgz
}

ensure_correct_pandora

