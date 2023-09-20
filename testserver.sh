#!/bin/bash

TOP=$HOME/src
GUA=$TOP/guacamole

cd $GUA
rm -rf guacamole-server
./build-server.sh -y
./install-server.sh
