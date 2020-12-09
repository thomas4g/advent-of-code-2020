#!/usr/bin/env gawk -f
BEGIN {
    sum_goal = ARGV[2]

    current_sum = 0
    buffer_size = 0
}

{
    number=$1

    current_sum += number
    buffer[FNR] = number
    buffer_size += 1

    while (current_sum > sum_goal) {
        # overshot, drop first
        first_idx = FNR - buffer_size
        current_sum -= buffer[first_idx]
        delete buffer[first_idx]
        buffer_size -= 1
    }

    if (current_sum == sum_goal) {
        # we found it, output desired
        min = number # use current as baseline
        max = number
        for (i in buffer) {
            num = buffer[i]
            if (num < min) {
                min = num
            }

            if (num > max) {
                max = num
            }
        }

        print min + max
        exit 0
    }
}
