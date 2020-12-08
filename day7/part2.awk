#!/usr/bin/env gawk -f
BEGIN {
    FS=",|contain"
    OFS=""
    desired_bag=ARGV[1]
}

{
    sub("bags", "", $1)
    container_type=gensub(/^ +| *$/, "", "g", $1)
    for (i = 2; i <= NF; i++) {
        child_type=gensub(/^ *| *\.?$/, "", "g", $i)
        child_count=substr(child_type, 1, index(child_type, " "))
        child_type=gensub(/[0-9]+ | bags?/, "", "g", child_type)

        if (child_type != "no other") {
            tree[container_type][child_type] = child_count
        }
    }
}

function count_bags(bag, sum) {
    if (! (bag in tree)) {
        return 0
    }

    for (child_type in tree[bag]) {
        count = tree[bag][child_type]
        sum += count + count * count_bags(child_type, 0)
    }
    return sum
}

END {
     print count_bags("shiny gold", 0)
}
