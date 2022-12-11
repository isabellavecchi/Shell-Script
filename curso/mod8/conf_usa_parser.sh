#!/bin/bash

ARQ_CONF="postgresql.conf"
PORT=
LISTEN_ADDRESSES=

#para pegar a saída echo do parser.sh:
eval $(./parser.sh "$ARQ_CONF")

[ "$(echo $CONF_port)" = "5432" ] && PORT=5432
[ "$(echo $CONF_listen_addresses)" = "'*'" ] && LISTEN_ADDRESSES="*"

echo $PORT
echo $LISTEN_ADDRESSES