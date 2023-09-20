#!/bin/bash

PROJ="guacamole-client"
VER="1.3.0"
ETC="/etc/guacamole"

[ "$1" == "-v" ] && {
    PROJ="${PROJ}-$2"
}

[ -d "$PROJ" ] || {
    echo "Cannot locate build directory. Exiting."
    exit 1
}

# Install extension jars that we use
EXT_DIR="${PROJ}/extensions"
JDBC_DIR="${EXT_DIR}/guacamole-auth-jdbc/modules/guacamole-auth-jdbc-mysql/target"
JDBC_JAR="${JDBC_DIR}/guacamole-auth-jdbc-mysql-${VER}.jar"
CAS_DIR="${EXT_DIR}/guacamole-auth-cas/target"
CAS_JAR="${CAS_DIR}/guacamole-auth-cas-${VER}.jar"
LDAP_DIR="${EXT_DIR}/guacamole-auth-ldap/target"
LDAP_JAR="${LDAP_DIR}/guacamole-auth-ldap-${VER}.jar"
ISSUES="${PROJ}/Known_Issues.txt"

[ -d ${ETC} ] || sudo mkdir ${ETC}
[ -d ${ETC}/extensions ] || sudo mkdir ${ETC}/extensions

sudo systemctl stop tomcat9
sudo systemctl stop guacd
sudo systemctl stop apache2

for jar in ${JDBC_JAR} ${CAS_JAR} ${LDAP_JAR}
do
    if [ -f $jar ]
    then
        sudo cp $jar ${ETC}/extensions
    else
        echo "$jar not found - skipping installation"
    fi
done

# Install Known Issues document if it exists
[ -f ${ISSUES} ] && {
    sudo cp ${ISSUES} ${ETC}
}

FIL="${PROJ}/guacamole/target/guacamole-${VER}.war"
[ -f "$FIL" ] || {
    echo "Cannot locate Guacamole client WAR file $FIL. Exiting."
    exit 1
}
TIR="/var/lib/tomcat9/webapps"
[ -d "$TIR" ] || {
    echo "Cannot locate Tomcat webapps directory. Exiting."
    exit 1
}
TGT="${TIR}/guacamole.war"

sudo cp ${FIL} ${TGT}
sudo rm -rf ${TIR}/guacamole

sudo systemctl daemon-reload
sudo systemctl start apache2
sudo systemctl start guacd
sudo systemctl start tomcat9
