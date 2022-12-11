#/bin/bash
#!/usr/bin/env /bash

VAR=""
VAR2=""

if [[ "$VAR" = "$VAR2" ]]; then
    echo "1.São iguais."
fi

if [[ "$VAR" = "$VAR2" ]]
then
    echo "2.São iguais."
fi

if test "$VAR" = "$VAR2"; then
    echo "3.São iguais."
fi

if test "$VAR" = "$VAR2"
then
    echo "4.São iguais."
fi

if [ "$VAR" = "$VAR2" ]
then
    echo "5.São iguais."
fi

#se tiver apenas uma linha de execução dentro do if, pode
#escrever da formareduzida:
[ "$VAR" = "$VAR2" ] && echo "6.São iguais."
[ "$VAR" = "$VAR2" ] || echo "Não são iguais."
