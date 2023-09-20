#!/bin/bash

JAVA_VERSION=java-1.11.0-openjdk-amd64
sudo update-java-alternatives -s $JAVA_VERSION
export JAVA_HOME=/usr/lib/jvm/$JAVA_VERSION/
export PATH=$PATH:$JAVA_HOME/bin

PACKAGE=guacamole-client
# [ -d $PACKAGE ] || {
#     [ -x ./clone-$PACKAGE.sh ] || {
#         echo "No clone of $PACKAGE exists here. Exiting."
#         exit 1
#     }
#     ./clone-$PACKAGE.sh $1
# }
[ -d $PACKAGE ] || {
    [ -x ./extract-$PACKAGE.sh ] || {
        echo "No extract of $PACKAGE exists here. Exiting."
        exit 1
    }
    ./extract-$PACKAGE.sh $1
}
cd $PACKAGE
mvn package
