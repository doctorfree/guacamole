#!/bin/bash

PROJ="guacamole-server"
[ "$1" == "-v" ] && {
    PROJ=="${PROJ}-$2"
}

[ -d "$PROJ" ] || {
    echo "Cannot locate build directory. Exiting."
    exit 1
}

cd ${PROJ}
sudo systemctl stop guacd
sudo systemctl stop tomcat9
sudo make install
sudo ldconfig
sudo systemctl daemon-reload
sudo systemctl start guacd
sudo systemctl start tomcat9
