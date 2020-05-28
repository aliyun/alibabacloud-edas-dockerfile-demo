#!/usr/bin/env bash

# first, correct JAVA_HOME
if [ ! -L "${JAVA_HOME}" ]; then
  mkdir -p `dirname ${JAVA_HOME}` &&
  ln -s `readlink -f /usr/lib/jvm/java` ${JAVA_HOME};
fi

APPHOME="/home/admin/app/"

function startwar {
  FILE="$1"

  CATALINA_OPTS="${CATALINA_OPTS} -Djava.security.egd=file:/dev/./urandom "

  # Remove original webapps
  WEBAPPS="${CATALINA_HOME}/webapps"
  [ -d "${WEBAPPS}" ] && rm -rf ${WEBAPPS}/*

  # set ROOT
  ROOT="${WEBAPPS}/ROOT"


  [ -d "${CATALINA_HOME}/deploy" ] && \
    ROOT=${CATALINA_HOME}/deploy/ROOT

  # extracting the war file
  mkdir -p ${ROOT}
  unzip ${FILE} -d ${ROOT}

  # Executing `catalina.sh run`, which will put java output into stdout
  cd ${APPHOME}
  BIN="${CATALINA_HOME}/bin/catalina.sh"
  /bin/sh -x ${BIN} run
}

function startjar {
  FILE="$1"

  if [ -e "${PANDORA_LOCATION}" ]; then
      CATALINA_OPTS="${CATALINA_OPTS} -Dpandora.location=${PANDORA_LOCATION} "
  fi

  # set default JAVA_OPTS
  JAVA_OPTS="$JAVA_OPTS -Dorg.apache.catalina.security.SecurityListener.UMASK=`umask`"

  # set default application args
  if [[ "${APP_ARGS}" != *"--server.context-path"* ]]; then
      APP_ARGS="${APP_ARGS} --server.context-path=/"
  fi

  if [[ "${APP_ARGS}" != *"--server.tomcat.uri-encoding"* ]]; then
      APP_ARGS="${APP_ARGS} --server.tomcat.uri-encoding=ISO-8859-1"
  fi

  if [[ "${APP_ARGS}" != *"--server.port"* ]]; then
      APP_ARGS="${APP_ARGS} --server.port=8080"
  fi

  if [[ "${APP_ARGS}" != *"--server.tomcat.max-threads"* ]]; then
      APP_ARGS="${APP_ARGS} --server.tomcat.max-threads=400"
  fi


  # Set /home/admin/app as the working dir.
  cd ${APPHOME}

  # Startup the application
  exec ${JAVA_HOME}/bin/java -jar \
      ${JAVA_OPTS} \
      ${CATALINA_OPTS} \
      -Djava.security.egd=file:/dev/./urandom \
      -Dcatalina.logs=${CATALINA_HOME}/logs \
      "${FILE}" \
      ${APP_ARGS}
}


function extract_and_startup {
  # show content
  ls -la ${APPHOME}

  # get first file
  filename=`ls ${APPHOME} | head -n 1`

  # exit if fail to get a filename
  if [ "$?" != "0" ]; then
      echo "application package is not found, exiting ..."
      exit 901
  fi

  # only support war or jar file.
  suffix=${filename##*.}
  if [ "${suffix}" == "war" ]; then
      startwar ${APPHOME}/${filename}
  elif [ "${suffix}" == "jar" ]; then
      startjar ${APPHOME}/${filename}
  else
      echo "unable to startup app package: ${filename}"
      exit 902
  fi
}

# extract the downloading file,
# and then startup the application
extract_and_startup



