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
#       - adicionado -s, -h  e -v
#
#   v1.1 20/02/2021, Isabella
#       - Adicionado basename
#       - substituição de IF's por CASE
#
#   v1.2 20/02/2021, Isabella
#       - Adicionadas 2 flags
#       - Adicionado -m
#
#   v1.3 20/02/2021, Isabella
#       - Atualizadas números das Versões e Histórico
#       - 
#
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
VERSAO="v1.3"
CHAVE_ORDENA=0 #(0-off / 1-on)
CHAVE_MAIUSCULO=0
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
while test -n "$1"
do
    case "$1" in
        -h) echo "$MENSAGEM_USO" && exit 0                      ;;
        -v) echo "$VERSAO" && exit 0                            ;;
        -s) CHAVE_ORDENA=1                                      ;;
        -m) CHAVE_MAIUSCULO=1                                   ;;
         *) echo "Opção inválida, valide a opção -h." && exit 1 ;; #default
    esac
    shift
done

[ "$CHAVE_ORDENA" -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | sort)
[ "$CHAVE_MAIUSCULO" -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | tr [a-z] [A-Z])

echo "$USUARIOS"
# ------------------------------------------------------------------------ #
