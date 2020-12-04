#!/bin/bash
input=${1:-input.txt}

function trees_hit {
    slope_x=$1
    slope_y=$2

    x=0
    y=0
    trees_hit=0

    i=0
    while read line; do
        if [[ $i -eq $slope_y ]]; then
            (( x += $slope_x ))
            position_in_line=$(( x % ${#line} ))
            if [[ ${line:position_in_line:1} == '#' ]]; then
                (( trees_hit++ ))
            fi
            i=1
        else
            (( i++ ))
        fi

        (( y++ ))
    done < $input

    echo $trees_hit
}

echo $(( $(trees_hit 1 1) * $(trees_hit 3 1) * $(trees_hit 5 1) * $(trees_hit 7 1) * $(trees_hit 1 2) ))
