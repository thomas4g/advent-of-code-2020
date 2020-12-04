#!/bin/bash
input=${1:-input.txt}

position=0
trees_hit=0

while read line; do
    position_in_line=$(( position % ${#line} ))
    if [[ ${line:position_in_line:1} == '#' ]]; then
        (( trees_hit++ ))
    fi
    (( position += 3 ))
done < $input

echo $trees_hit
