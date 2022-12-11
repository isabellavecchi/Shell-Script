# ------------------------------- VARIÁVEIS ----------------------------------------- #
MENSAGEM_HELP="
    $(basename $0) - [OPÇÕES]
    
        -h - Menu de ajuda
        -d - ativa modo debug
            - 1 ou 2, para selecionar nivel de debug
            exemplo: ./tarefa5.sh -d 2
"
CHAVE_DEBUG=0
NIVEL_DEBUG=0

ESTILIZAR="\033["
_EST="m"
ROXO="35"
CIANO="36"
NEGRITO="1"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #
Debugar () {
    [ $1 -le $NIVEL_DEBUG ] && echo -e "${2}Debug $* ------"    #pega os parâmetros passados na chamada da função
}

Soma () {
    local total=0

    for i in $(seq 1 6);do
        Debugar 1 "\033[0;35;1mEntrei no for com o valor:" "\033[0;31m$i\033[0m"
        total=$(($total+$i))
        Debugar 2 "\033[0;36;1mDepois da soma:" "\033[0;32m$total"
    done
    echo $total
}
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
echo "$(basename $0)"
case "$1" in
    -h) echo "$MENSAGEM_HELP" && exit 0              ;;
    -d) CHAVE_DEBUG=1                                ;;
     *) echo "função debug desativada. -h para help" ;;
esac

if [ $CHAVE_DEBUG -eq 1 ]; then
    test [$2] && NIVEL_DEBUG=$2
    Soma
    exit 0
fi

Soma
# ------------------------------------------------------------------------ #
