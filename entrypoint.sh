#!/bin/bash
# Set default settings, pull repository, build
# app, etc., _if_ we are not given a different
# command.  If so, execute that command instead.
#
# Based on https://github.com/CyCoreSystems/docker-meteor

# Default values
: ${APP_DIR:="/opt/app/bundle"}
: ${MONGO_URL:="mongodb://${MONGO_PORT_27017_TCP_ADDR}:${MONGO_PORT_27017_TCP_PORT}/${DB}"}
: ${PORT:="3000"}
: ${ROOT_URL:="http://localhost"}

# Find the node and npm executables
: ${BIN:="`find ~/.meteor -wholename '*dev_bundle/bin'`"}
: ${NODE:="${BIN}/node"}
: ${NPM:="${BIN}/npm"}

# Install npm dependencies
if [ -e ${APP_DIR}/programs/server ]; then
   pushd ${APP_DIR}/programs/server/
   ${NPM} install
   popd
else
   echo "Unable to locate server directory; hold on: we're likely to fail"
fi

# Run meteor
cd ${APP_DIR}
export MONGO_URL=${MONGO_URL} PORT=${PORT} ROOT_URL=${ROOT_URL}
exec ${NODE} ./main.js
