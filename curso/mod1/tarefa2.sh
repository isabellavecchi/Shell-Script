#!/bin/bash
#/usr/bin/env /bash
echo "$0"
for i in $(seq 0 10); do
    [ $(($i % 2)) -eq 0 ] && echo "$i é par."
done