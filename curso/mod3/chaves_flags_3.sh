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
#
#   v2.0 20/02/2021, Isabella
#       - $(basename $0) para pegar o nome do arquivo sem './'
#       - substituição do bloco de if's por case
#
#   v3.0 20/02/2021, Isabella
#       - Adição de chave-valor
#       - parâmtero para deixar tudo em maiúsculo
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
        -m - Coloca em MAIÚSCULO
"
VERSAO="v3.0"
CHAVE_ORDENA=0 #(0-off / 1-on)
CHAVE_MAIUSCULO=0
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
case "$1" in
    -h) echo "$MENSAGEM_USO" && exit 0 ;;
    -v) echo "$VERSAO" && exit 0       ;;
    -s) CHAVE_ORDENA=1                 ;;
    -m) CHAVE_MAIUSCULO=1              ;;
     *) echo "$USUARIOS"               ;; #default
esac

[ "$CHAVE_ORDENA" -eq 1 ] && echo "$USUARIOS" | sort
[ "$CHAVE_MAIUSCULO" -eq 1 ] && echo "$USUARIOS" | tr [a-z] [A-Z]
# ------------------------------------------------------------------------ #
