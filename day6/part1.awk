#!/usr/bin/env gawk -f

BEGIN {
  RS=""
  FS=""
  sum=0
}
{
    for (i=1; i<=NF; i++) {
        if ($i != "\n") {
            a[$i] = 1
        }
    }
} 
// {
    for (i in a) {
        sum += 1
    }
    delete a
}
END {
    print sum
}
