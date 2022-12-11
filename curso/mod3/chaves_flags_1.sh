#!/usr/bin/env bash
#
# listaUsuarios.sh - Extrai usuários do /etc/passwd
#
# Site:       https://4fasters.com.br
# Autor:      Isabella Vecchi
# Manutenção: Isabella Vecchi
#
# ------------------------------------------------------------------------ #
#  Irá extrair usuários do /etc/passwd, havendo a possibilidade de colocar
#  em maiúsculo e em ordem alfabética
#
#  Exemplos:
#      $ ./listaUsuarios.sh -s -m
#      Neste exemplo extrai em ordem alfabética e em maiúsculo
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 20/02/2021, Isabella
#       - 
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
#    -d = delimitador (:)
#    -f = num da coluna (1 é a primeira)
MENSAGEM_USO="
    $0 - [OPÇÕES]
    
        -h - Menu de ajuda
        -v - Versão
        -s - Ordenar a saída
"
VERSAO="v1.0"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
if [ "$1" = "-h" ]; then
    echo "$MENSAGEM_USO" && exit 0
fi
if [ "$1" = "-v" ]; then
    echo "$VERSAO" && exit 0
fi
if [ "$1" = "-s" ]; then
    echo "$USUARIOS" | sort && exit 0
fi

echo "$USUARIOS"
# ------------------------------------------------------------------------ #
