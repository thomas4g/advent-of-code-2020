#!/bin/bash
input=${1:-input.txt}

required=(byr iyr eyr hgt hcl ecl pid)
eye_colors=(amb blu brn gry grn hzl oth)
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
            IFS=':' read -a field_and_value <<< "$entry"
            field=${field_and_value[0]}
            value=${field_and_value[1]}
            for required_field in ${required[@]}; do
                if [[ $field == $required_field ]]; then
                    ([[ $required_field == "byr" ]] && [[ $value -ge 1920 ]] && [[ $value -le 2002 ]]) ||
                    ([[ $required_field == "iyr" ]] && [[ $value -ge 2010 ]] && [[ $value -le 2020 ]]) ||
                    ([[ $required_field == "eyr" ]] && [[ $value -ge 2020 ]] && [[ $value -le 2030 ]]) ||
                    ([[ $required_field == "hgt" ]] &&
                        (
                         [[ ${value:3:2} == "cm" && ${value:0:3} -ge 150 && ${value:0:3} -le 193 ]] ||
                         [[ ${value:2:2} == "in" && ${value:0:2} -ge 59 && ${value:0:2} -le 76 ]]
                        )) ||
                    ([[ $required_field == "hcl" ]] && [[ $value =~ ^#[0-9a-f]{6}$ ]]) ||
                    ([[ $required_field == "ecl" ]] && [[ " ${eye_colors[@]} " =~ " $value " ]]) ||
                    ([[ $required_field == "pid" ]] && [[ $value =~ ^[0-9]{9}$ ]]) &&
                        (( current_passport_num_valid_fields++ ))
                    break
                fi
            done
        done
    fi

done < $input
if [[ $current_passport_num_valid_fields -eq ${#required[@]} ]]; then
    (( num_valid++ ))
fi

echo $num_valid
