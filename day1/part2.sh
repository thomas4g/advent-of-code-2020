#!/bin/bash
input=${1:-input.txt}
sorted=$(sort -n $input)                   # O(n log n)
IFS=$'\n' read -d '' -r -a reverse_sorted <<EOF
$(echo "$sorted" | tac)
EOF

i=0
j=1
for num1 in $sorted; do
    sum=2021

    last_i=$i
    last_j=$j
    while [[ $i -lt ${#reverse_sorted[@]} ]] && [[ $j -lt ${#reverse_sorted[@]} ]] && [[ $sum -gt 2020 ]]; do
        num2=${reverse_sorted[$i]}
        num3=${reverse_sorted[$j]}
        sum=$(( $num1 + $num2 + $num3 ))

        last_i=$i
        last_j=$j
        if [[ $i -le $j ]]; then
            (( i++ ))
            if [[ $i -eq $j ]]; then
                (( i++ ))
            fi
        else
            (( j++ ))
            if [[ $j -eq $i ]]; then
                (( j++ ))
            fi
        fi


    done

    if [[ $sum -eq 2020 ]]; then
        echo $num1, $num2, $num3
        echo $(( $num1 * $num2 * $num3 ))
        break
    elif [[ $sum -lt 2020 ]]; then
        i=$last_i
        j=$last_j
    else
        echo "No valid numbers sum to 2020 :("
        exit 1
    fi
done
