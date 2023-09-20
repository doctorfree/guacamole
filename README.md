# guacamole

Convenience scripts to document and assist in the build, installation, and
configuration of the Guacamole Server, Guacamole Client, Tomcat, VNC, and
Apache. These installation and configuration steps are broken down into
individual standalone scripts. It may be preferable to perform these steps
individually by invoking each script manually.

The process is meant to be performed in `~/src/guacamole/`

```sh
# Install the build dependencies
./bin/inst_deps

# Get the server source
./bin/get_server

# Configure the Guacamole Server source
./bin/configureserver

# Compile the Guacamole Server source
./bin/mkserver

# Install the Guacamole Server source
./bin/installguacd

# Start Guacamole Server
./bin/startguacd
# Check Guacamole Server Status
./bin/statusguacd
# Enable Guacamole Server
./bin/enableguacd

# Install Tomcat
./bin/inst_tomcat
# Setup Tomcat roles and users
./bin/tomcatuser

# Retrieve the Guacamole Client source
./bin/get_client
# Build the Guacamole Client WAR file
./bin/mkclient
# Install the Guacamole Client WAR
./bin/instwar

# Configure Guacamole
./bin/confguac

# Install RDP
./bin/inst_rdp

# Install VNC
./bin/inst_vnc

# Configure VNC
./bin/conf_vnc

# Install Apache
./bin/inst_apache
```
