#!/bin/bash

#fazendo testes

#VARIÁVEIS
ARQ_BD="banco_de_dados.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
RST="\033[0m"

#TESTES
#arquivo existe?
[ ! -f "$ARQ_BD" ] && echo -e "${VERMELHO}ERRO: Arquivo não existe." && exit 1
[ ! -r "$ARQ_BD" ] && echo -e "${VERMELHO}ERRO: Arquivo não tem permissão de leitura." && exit 1
[ ! -w "$ARQ_BD" ] && echo -e "${VERMELHO}ERRO: Arquivo não tem permissão de escrita." && exit 1

