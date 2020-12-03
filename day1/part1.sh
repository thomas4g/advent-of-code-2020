#!/bin/bash
input=${1:-input.txt}
sorted=$(sort -n $input)                    # O(n log n)
IFS=$'\n' read -d '' -r -a reverse_sorted <<EOF
$(echo "$sorted" | tac)
EOF

i=0
for num1 in $sorted; do
    sum=2021
    while [[ $i -lt ${#reverse_sorted[@]} ]] && [[ $sum -gt 2020 ]]; do
        num2=${reverse_sorted[$i]}
        sum=$(( $num1 + $num2 ))
        (( i++ ))
    done

    if [[ $sum -eq 2020 ]]; then
        echo $num1, $num2
        echo $(( $num1 * $num2 ))
        break
    elif [[ $sum -lt 2020 ]]; then
        (( i-- ))
    else
        echo "No valid numbers sum to 2020 :("
        exit 1
    fi
done
