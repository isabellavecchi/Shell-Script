#/bin/bash
#!/usr/bin/env /bash
#ao invés de colocar só /bin/bash, colocar assim para ele ser portável (rodar em outros pc´s)

#chmod +x file.sh para torná-lo executável

echo "funcão que imprime na tela"

#VARIÁVEL
NOME="Isabella

   Vecchi"
echo $NOME
echo "$NOME"
#aspas garantem a formatação

#GLOBAL local (caixa alta/baixa no nome)

NUMERO_1=24
NUMERO_2=45

TOTAL=$(($NUMERO_1+$NUMERO_2))

echo $TOTAL

SAIDA_CAT=$(cat /etc/passwd | grep isabella)
echo "$SAIDA_CAT"

#o ideal é tudo entre aspas
SAIDA_CAT="$(cat /etc/passwd | grep isabella)"
echo "$SAIDA_CAT"

echo "------------------------------------------"


#VARIÁVEIS RESERVADAS: variáveis que já têm valor padrão,
#n podemos passar um novo
echo "Parametro 1: $1"
echo "Parametro 2: $2"
#./variaveis.sh -a -b
# $1 := a; $2 := b
echo "Todos os parâmetros: $*"

echo "Quantos parâmetros? $#"

echo "Saída do último comando $?"
# 0 = sucesso!

#cada vez que se executa um programa em Shell, um novo PID
#é criado
echo "PID: $$"

echo "Nome do script sendo executado: $0"
#legal colocar ele no início do programa