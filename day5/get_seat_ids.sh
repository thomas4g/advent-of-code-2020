#!/bin/bash
input=${1:-input.txt}

function binary_search {
    line=$1
    min=$2
    max=$3
    min_char=$4
    max_char=$5

    if [[ $min -eq $max ]]; then
        echo $min
        return 0
    else
        midpoint=$(( ($max + $min) / 2 ))
        if [[ ${line:0:1} == $min_char ]]; then
            if [[ ${#line} -eq 1 ]]; then
                echo $min
            else
                echo $(binary_search ${line:1} $min $midpoint $min_char $max_char)
            fi
            return 0
        else
            if [[ ${#line} -eq 1 ]]; then
                echo $max
            else
                echo $(binary_search ${line:1} $(( $midpoint + 1 )) $max $min_char $max_char)
            fi
            return 0
        fi
    fi
}

while read line; do
    row=$(binary_search ${line:0:7} 0 127 F B)
    col=$(binary_search ${line:7:3} 0 7 L R)
    echo $(( $row*8 + $col ))
done < $input | sort -n
