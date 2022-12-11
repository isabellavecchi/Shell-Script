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
#   v2.0 20/02/2021, Isabella
#       - $(basename $0) para pegar o nome do arquivo sem './'
#       - substituição do bloco de if's por case
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
#    -d = delimitador (:)
#    -f = num da coluna (1 é a primeira)
MENSAGEM_USO="
    $(basename $0) - [OPÇÕES]
    
        -h - Menu de ajuda
        -v - Versão
        -s - Ordenar a saída
"
VERSAO="v2.0"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
case "$1" in
    -h) echo "$MENSAGEM_USO" && exit 0    ;;
    -v) echo "$VERSAO" && exit 0          ;;
    -s) echo "$USUARIOS" | sort && exit 0 ;;
     *) echo "$USUARIOS"                  ;; #default
esac
# ------------------------------------------------------------------------ #
