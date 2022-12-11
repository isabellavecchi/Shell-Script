#!/bin/bash

echo "==== For 1"
for (( i = 0; i < $1; i++ )); do
    echo $i
done

echo "


=== For 2 (seq)"
#seq 10
#seq 2 10

for i in $(seq $1)
do
    echo $i
done


echo "


=== For 3 (array)"
Frutas=(
    'Laranja'
    'Ameixa'
    'Abacaxi'
    'Melancia'
    'ovo'
)
#poderia ter colocado [0], [1] ou [2]. [@] significa todos
for i in "${Frutas[@]}"; do
    echo "$i"
done

echo "


=== While"
contador=0
# ${#Frutas[@]} -> tamanho do array
while [[ $contador -lt ${#Frutas[@]} ]]; do
    echo $contador
    contador=$(($contador+1))
done