#!/bin/bash

ARQ_CONF="$1"

[ ! -e "$ARQ_CONF" ] && echo -e "\033[0;31mERRO: Arquivo não existe.\033[0m" && exit 1
[ ! -r "$ARQ_CONF" ] && echo -e "\033[0;31mERRO: Sem acesso de leitura.\033[0m" && exit 1

while read -r linha
do
    [ "$(echo $linha | cut -c1)" = "#" ] && continue
    [ ! "$linha" ] && continue

    chave="$(echo $linha | cut -d = -f 1)"
    chave="$(echo $chave | cut -d '' -f 1)"
    valor="$(echo $linha | cut -d = -f 2)"
    valor="$(echo $valor | cut -d '' -f 2)"
    valor="$(echo $valor | sed 's/#.*//')"

    #criando variáveis ambiente e armazenando seus respectivos valores
    echo "CONF_$chave=$valor"
done < "$ARQ_CONF"