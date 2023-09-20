#!/bin/bash

TOP=$HOME/src
GUA=$TOP/guacamole
FMC="guacamole-client/guacamole/src/main/webapp/app/client/types/ManagedClient.js"
FTS="guacamole-client/guacamole/src/main/webapp/app/rest/services/tunnelService.js"

cd $GUA
rm -rf guacamole-client
cp -a guacamole-client-fresh guacamole-client
cp /tmp/tunnelService.js $FTS
cp /tmp/ManagedClient.js $FMC
./build-client.sh
./install-client.sh
