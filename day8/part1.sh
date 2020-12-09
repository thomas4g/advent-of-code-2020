#!/bin/bash
file=()
while IFS= read -r line; do
    file+=("$line")
done

accumulator=0
index=0
running=1
visited=()


while [[ ${visited[index]} != true ]] ; do
    line=(${file[index]})
    visited[$index]=true
    command=${line[0]}
    value=${line[1]}

    if [[ $command == "acc" ]]; then
        (( accumulator += value ))
    fi

    if [[ $command == "jmp" ]]; then
        (( index += value ))
    else
        (( index++ ))
    fi
done

echo $accumulator
