#!/usr/bin/env gawk -f

BEGIN {
  RS=""
  FS=""
  sum=0
}
{
    member_count=1
    for (i=1; i<=NF; i++) {
        if ($i == "\n") {
            member_count += 1
        } else {
            answers[$i] += 1
        }
    }

    for (answer in answers) {
        if (answers[answer] == member_count) {
            sum += 1
        }
    }
    delete answers
}
END {
    print sum
}
