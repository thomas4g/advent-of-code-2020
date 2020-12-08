#!/usr/bin/env gawk -f
BEGIN {
    FS=",|contain"
    OFS=""
    desired_bag=ARGV[1]
}

{
    sub("bags", "", $1)
    container_type=gensub(/^ +| +$/, "", "g", $1)
    for (i = 2; i <= NF; i++) {
        child_type=gensub(/[0-9]+|bags?/, "", "g", $i)
        child_type=gensub(/^ +| +\.?$/, "", "g", child_type)
        tree[child_type][container_type] = 1
    }
}

function check_parents(bag_type) {
    for (parent_type in tree[bag_type]) {
        if (! (parent_type in allowed_bag_types)) {
            allowed_bag_types[parent_type] = 1
            if (parent_type in tree) {
                check_parents(parent_type)
            }
        }
    }
}

END {
    check_parents("shiny gold")
    print length(allowed_bag_types)
}
