#!/usr/bin/env bash
#
# cotarBitcoin.sh - Verifica a última cotação do Bitcoin
#
# Site:       https://meusite.com.br
# Autor:      Isabella Vecchi Ferreira
# Manutenção: Isabella Vecchi Ferreira
#
# ------------------------------------------------------------------------ #
#  Este programa irá extrair títulos do blog LXER, colocar em um arquivo de
#  texto e ler mostrando com cores na tela.
#
#  Exemplos:
#      $ ./extrai_titulos.sh
#      Neste exemplo o programa vai extrair os títulos e mostrar na tela.
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 22/02/2020, Isabella:
#       - Montamos a expressão regular com fator em comum
#   v1.1 22/02/2020, Isabella:
#       - Criado primeiro código com cores
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #
# Agradecimentos:
#
# 	Joãozinho - Encontrou um bug na parte de login.
#	  Mariazinha - Enviou uma sugestão de adicionar o -h.
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
ARQUIVO_DE_TITULOS="titulos.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
RST="\033[0m"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
#[ -x "$(which lynx)" ] && echo "Está instaldo" && exit 0
MSG_INSTALL="Instalando Dependências
.
.
."
#Lynx instalado?
[ ! -x "$(which lynx)" ] && echo "$MSG_INSTALL" && sudo apt install lynx -y
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
lynx -source http://lxer.com/ | grep "blurb" | sed 's/<div.*line">//;s/<\/span.*//' > "$ARQUIVO_DE_TITULOS"

while read -r titluo_lxer
do
    echo -e "${VERMELHO}Título: ${VERDE}$titluo_lxer${RST}"
done < "$ARQUIVO_DE_TITULOS"
    # a cada iteração, a cada linha lida do arquivo $ARQUIVO_DE_TITULOS
    # ele adiciona o valor da linha à variável titluo_lxer
# ------------------------------------------------------------------------ #
