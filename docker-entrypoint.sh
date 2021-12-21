#!/bin/bash

DOMOTICZ_DIR=/opt/domoticz
USER_DATA_DIR=$DOMOTICZ_DIR/userdata

CMD_ARGS="-www $WWW_PORT"
CMD_ARGS="$CMD_ARGS -noupdates -sslwww $SSL_PORT -userdata $USER_DATA_DIR"

if [ -n "$LOG_PATH" ]; then
  CMD_ARGS="$CMD_ARGS -log $LOG_PATH"
fi

if [ -n "$DATABASE_PATH" ]; then
  CMD_ARGS="$CMD_ARGS -dbase $DATABASE_PATH"
fi

if [ -n "$EXTRA_CMD_ARG" ]; then
  CMD_ARGS="$CMD_ARGS $EXTRA_CMD_ARG"
fi

if ! [ -d $USER_DATA_DIR/plugins ]; then
  ln -s $DOMOTICZ_DIR/plugins $USER_DATA_DIR/plugins
fi

if [ $1 == "$DOMOTICZ_DIR/domoticz" ]; then
  exec $@ $CMD_ARGS
else
  exec "$@"
fi
