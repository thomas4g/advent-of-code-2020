#!/bin/bash
input=${1:-input.txt}
valid=0
while read line; do
    cols=($line)
    IFS="-" read -ra minmax <<< "${cols[0]}"
    min=${minmax[0]}
    max=${minmax[1]}
    policy_letter=${cols[1]:0:1}
    password=${cols[2]}

    count=0
    while read -n1 letter; do
        if [[ $letter == $policy_letter ]]; then
            (( count++ ))
            if [[ $count -gt $max ]]; then
                break
            fi
        fi
    done <<< "$password"
    if [[ $count -ge $min ]] && [[ $count -le $max ]]; then
        (( valid++ ))
    fi
done < $input

echo $valid
