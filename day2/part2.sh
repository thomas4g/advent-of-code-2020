#!/bin/bash
input=${1:-input.txt}
valid=0
while read line; do
    cols=($line)
    IFS="-" read -ra minmax <<< "${cols[0]}"
    pos1=$(( ${minmax[0]} - 1 ))
    pos2=$(( ${minmax[1]} - 1 ))
    policy_letter=${cols[1]:0:1}
    password=${cols[2]}
   
    [[ ${password:$pos1:1} == $policy_letter ]] && in_first_place=true || in_first_place=false
    [[ ${password:$pos2:1} == $policy_letter ]] && in_second_place=true || in_second_place=false

    if ( $in_first_place || $in_second_place ) && ! ( $in_first_place && $in_second_place ); then
        (( valid++ ))
    fi
done < $input

echo $valid
