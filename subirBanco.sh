#!/usr/bin/env bash
#
# Autor:      Isabella Vecchi Ferreira
# Manutenção: Equipe de Banco de Dados
#
# ------------------------------------------------------------------------ #
#  Este programa irá tentar subir um banco automaticamente sempre que ele cair
#  Para isto, ele deve estar rodando sempre no background da máquina.
#
#  Exemplos:
#      $ ./subirBanco.sh
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 02/03/2021, Isabella
#       - testa se o postgresql está running
#       - sobe o banco
#   v1.1 09/03/2021, Isabella
#       - pega o PID do postgres e armazena junto com a data no arquivo
#       /var/lib/pgsql/13/data/log/erro.log, caso tenha caído.
#       - pega as últimas 25 saídas de log caso o banco estier inativo
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.2.46
#   postgresql 13
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
PG_DATA="$(systemctl show -p Environment postgresql-13 | sed 's/^Environment=//' | tr ' ' '\n'  | sed -n 's/^PGDATA=//p;s/\/$//p' | tail -n 1)"
[ $PG_DATA = "" ] && PG_DATA="$(su - postgres -c 'echo $PGDATA')"

COMANDO="$(find / -name 'pg_ctl' | sed 's/\/pg_ctl//')"
DATA=DATA="$(date +%Y-%m-%d)"
# DOW="$(date +%a)"
DOW="$(date +%u)"
LOG_DE_ERRO="$PG_DATA/log/erro.log"

STATUS=
PID=
LOG_FILE_NAME=
LINHAS=25


# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #
RemovePostmasters () {
    rm -rf $PG_DATA/postmaster.*
}
GetStatus () {
STATUS="$(systemctl status postgresql-13 | grep Active | sed 's/Active: //;s/since.*//' | cut -d '(' -f 2 | cut -d ')' -f 1)"
}
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
#Banco está ativo?
GetStatus
[ "$STATUS" = "running" ] && echo "Banco funcionando!" && exit 0
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
case $DOW in
    1) LOG_FILE_NAME="postgresql-Mon.log" ;;
    2) LOG_FILE_NAME="postgresql-Tue.log" ;;
    3) LOG_FILE_NAME="postgresql-Wed.log" ;;
    4) LOG_FILE_NAME="postgresql-Thu.log" ;;
    5) LOG_FILE_NAME="postgresql-Fri.log" ;;
    6) LOG_FILE_NAME="postgresql-Sat.log" ;;
    7) LOG_FILE_NAME="postgresql-Sun.log" ;;
esac
# LOG_FILE_NAME="postgresql-$DOW.log"

PID=$(tail -n 1 $PG_DATA/log/$LOG_FILE_NAME | sed 's/.*\[//;s/\].*//')

echo "



    PID = $PID
    DATA = $DATA

    ----------------------------------------------------------------------------------------
    ÚLTIMAS 25 SAÍDAS DE LOG PERTO DO MOMENTO EM QUE O BANCO CAIU:
    
    " >> $LOG_DE_ERRO

tail -n $LINHAS $PG_DATA/log/$LOG_FILE_NAME >> $LOG_DE_ERRO

systemctl start postgresql-13
GetStatus
[ "$STATUS" = "running" ] && {
    echo "
    
    
    resolveu apenas com \"systemctl start postgresql-13\"

    ----------------------------------------------------------------------------------------
    " >> $LOG_DE_ERRO
    exit 0
}

RemovePostmasters
systemctl start postgresql-13
GetStatus
[ "$STATUS" = "running" ] && {
    echo "
    

    teve que remover os arquivos postmasters

    ----------------------------------------------------------------------------------------
    " >> $LOG_DE_ERRO
    exit 0
}

echo "
    
    
    ERRO NÃO SOLUCIONADO

    ----------------------------------------------------------------------------------------
    " >> $LOG_DE_ERRO

exit 1