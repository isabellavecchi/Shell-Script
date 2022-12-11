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
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #
Debugar () {
    [ $1 -le $NIVEL_DEBUG ] && echo "Debug $* ------"
}

Soma () {
    local total=0

    for i in $(seq 1 6);do
        Debugar 1 "Entrei no for com o valor: $i"
        total=$(($total+$i))
        Debugar 2 "Depois da soma: $total"
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
