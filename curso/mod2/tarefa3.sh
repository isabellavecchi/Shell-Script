#!/bin/bash
#/usr/bin/env /bash

comeca=0
ate=3
[ $comeca -ge $ate ] && exit 1

for i in $(seq $comeca $ate); do
    for j in $(seq $i $ate); do
        printf "*"
    done
    printf "\n"
done