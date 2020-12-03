#!/bin/bash
input=input.txt
sorted=$(sort -n $input)                    # O(n log n)
IFS=$'\n' read -d '' -r -a reverse_sorted <<EOF
$(echo "$sorted" | tac)
EOF


i=$((${#reverse_sorted[@]} - 1))
for num1 in $sorted; do
    sum=2021
    while [[ $i -ge 0 ]] && [[ $sum -gt 2020 ]]; do
        num2=${reverse_sorted[$i]}
        sum=$(( $num1 + $num2 ))
        (( i-- ))
    done

    if [[ $sum -eq 2020 ]]; then
        echo $(( $num1 * $num2 ))
        break
    elif [[ $sum -lt 2020 ]]; then
        (( i++ ))
    else
        echo "No valid numbers sum to 2020 :("
        exit 1
    fi
done
