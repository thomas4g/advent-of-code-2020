#!/bin/bash
input=${1:-input.txt}

required=(byr iyr eyr hgt hcl ecl pid)
num_valid=0
current_passport_num_valid_fields=0
while read line; do
    if [[ $line == "" ]]; then
        if [[ $current_passport_num_valid_fields -eq ${#required[@]} ]]; then
            (( num_valid++ ))
        fi
        current_passport_num_valid_fields=0
    else
        entries=( $line )
        for entry in ${entries[@]}; do
            field=$(echo $entry | cut -d':' -f1)
            for required_field in ${required[@]}; do
                if [[ $field == $required_field ]]; then
                    (( current_passport_num_valid_fields++ ))
                    break
                fi
            done
        done
    fi

done < $input

echo $num_valid
