#!/bin/bash
DEBUG=false
file=()
file_length=0
while IFS= read -r line; do
    file+=("$line")
    (( file_length ++ ))
done


function check_loops {
    local accumulator=0
    local visited=()
    local index=0
    $DEBUG && >&2 echo "starting new round at $index"
    while [[ $index -lt $file_length ]] &&
        [[ ${visited[index]} != true ]]; do
        line=(${file[index]})
        visited[$index]=true
        command=${line[0]}
        value=${line[1]}
        $DEBUG && >&2 echo -e "\t$command $value"
        if [[ $command == "acc" ]]; then
            $DEBUG && >&2 echo -en "\t\t$accumulator -> "
            (( accumulator += value ))
            $DEBUG && >&2 echo -e "$accumulator"
        fi

        if [[ $command == "jmp" ]]; then
            (( index += value ))
        else
            (( index++ ))
        fi
    done
    echo $accumulator
    if [[ $index -ge $(( file_length - 1 )) ]]; then
        return 0
    else
        return 1
    fi
}

change_index=0
while [[ $change_index -lt $file_length ]]; do
        line=(${file[change_index]})
        command=${line[0]}
        value=${line[1]}
        try_swap=0
        if [[ $command == "nop" ]]; then
            old="nop"
            new="jmp"
            try_swap=1
        elif [[ $command == "jmp" ]]; then
            old="jmp"
            new="nop"
            try_swap=1
        fi

        if [[ $try_swap == 1 ]]; then
            file[$change_index]="${new} ${value}"
            last_accumulator=$(check_loops)
            exit_code=$?
            if [[ $exit_code == 0 ]]; then
                echo "we changed line $change_index to: ${file[change_index]}"
                echo "accumulator value: $last_accumulator"
                exit 0
            else
                # no luck, change back
                file[$change_index]="${old} ${value}"
            fi
        fi


    (( change_index++ ))
done

echo $accumulator
