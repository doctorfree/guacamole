#!/bin/bash

TOP=$HOME/src
GUA=$TOP/guacamole

cd $GUA
rm -rf guacamole-client
./build-client.sh -y
./install-client.sh
