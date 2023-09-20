#!/bin/bash

JAVA_VERSION=java-1.11.0-openjdk-amd64
sudo update-java-alternatives -s $JAVA_VERSION
export JAVA_HOME=/usr/lib/jvm/$JAVA_VERSION/
export PATH=$PATH:$JAVA_HOME/bin

PACKAGE=guacamole-server

[ "$1" == "-r" ] && rm -rf ${PACKAGE}
[ -d ${PACKAGE} ] || {
    [ -x ./extract-${PACKAGE}.sh ] || {
        echo "No extract of ${PACKAGE} exists here. Exiting."
        exit 1
    }
    ./extract-${PACKAGE}.sh $1
}

cd ${PACKAGE}

LOG="../guacamole-server-build.log"
rm -f ${LOG}

[ -f Makefile ] && {
  make clean > /dev/null 2>&1
  make distclean > /dev/null 2>&1
}
autoreconf -fi 2>&1 | tee ${LOG}
export CPPFLAGS="-Wno-error=deprecated-declarations"
./configure --with-init-dir=/etc/init.d 2>&1 | tee -a ${LOG}
make 2>&1 | tee -a ${LOG}
