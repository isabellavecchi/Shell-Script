#!/bin/bash

#VARIÁVEIS
ARQ_CONF="postgresql.conf"

PORT=
LISTEN_ADDRESSES=
MENSAGEM="mensagem de teste"

ROXO="\033[0;1;35m"
CIANO="\033[0;1;36m"
RST="\033[0m"

#FUNÇÕES
DefinirParametros () {
    local parametro="$(echo "$1" | cut -d = -f 1)"
    local valor="$(echo "$1" | cut -d = -f 2)"

    case "$parametro" in
        "port ") PORT="$valor"                         ;;
        "listen_addresses ") LISTEN_ADDRESSES="$valor" ;;
    esac
}

#TESTES
[ ! -r "$ARQ_CONF" ] && echo "Não temos acesso de leitura" && exit 1

#EXECUÇÃO
while read -r linha
do
    #checa se é comentário: 1o termo = '#'
    [ "$(echo $linha | cut -c1)" = "#" ] && continue
    # A condição [ "$linha" ] será verdadeira casa haja algo na linha
    [ ! "$linha" ] && continue
    #se for comentário ou linha em branco, pula a linha e passa para a próxima
    
    DefinirParametros "$linha"
    
    #echo -e "$linha"
done < $ARQ_CONF

#busca
echo "VALOR port: $PORT"
echo "VALOR listen_addresses: $LISTEN_ADDRESSES"