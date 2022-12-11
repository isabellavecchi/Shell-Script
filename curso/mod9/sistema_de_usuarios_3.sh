#!/bin/bash

#Validar se existe o usuário para inserir e futuramente remover

#VARIÁVEIS
ARQ_BD="banco_de_dados.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
RST="\033[0m"

SEP=:

#TESTES
#arquivo existe?
[ ! -f "$ARQ_BD" ] && echo -e "${VERMELHO}ERRO: Arquivo não existe." && exit 1
[ ! -r "$ARQ_BD" ] && echo -e "${VERMELHO}ERRO: Arquivo não tem permissão de leitura." && exit 1
[ ! -w "$ARQ_BD" ] && echo -e "${VERMELHO}ERRO: Arquivo não tem permissão de escrita." && exit 1

#FUNÇÕES
DisplayUsuario () {
    local id="$(echo "$1" | cut -d $SEP -f 1)"
    local nome="$(echo "$1" | cut -d $SEP -f 2)"
    local email="$(echo "$1" | cut -d $SEP -f 3)"

    echo -e "${VERDE}ID: ${VERMELHO}$id"
    echo -e "${VERDE}Nome: ${VERMELHO}$nome"
    echo -e "${VERDE}Email: ${VERMELHO}$email"
}

ListaUsuarios () {
    while read -r user
    do
        [ "$(echo $user | cut -c1)" = "#" ] && continue
        [ ! "$user" ] && continue

        DisplayUsuario "$user"
    done < "$ARQ_BD"
}

        #Validar se existe o usuário para inserir e futuramente remover

ValidaUsuario () {
    grep -i -q "$1$SEP" "$ARQ_BD"
}

InsereUsuario () {
    local nome="$(echo $1 | cut -d $SEP -f 2)"

    if ValidaUsuario "$nome"
    then
        echo "ERRO: usuário já existente"
    else
        echo "$*" >> "$ARQ_BD"
    fi
}


#EXECUÇÃO
ListaUsuarios