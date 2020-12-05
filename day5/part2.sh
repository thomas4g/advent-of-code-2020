#!/bin/bash
./get_seat_ids.sh "$@" | while read seat_id; do 
    if [[ $last_seat_id -gt 0 ]] && [[ $(( $seat_id - 1 )) -gt $last_seat_id ]]; then
        echo $(( $seat_id - 1 ))
        break
    fi
    last_seat_id=$seat_id
done
