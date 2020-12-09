For day 9, the AWK scripts accept arguments, since the goal
changes depending on whether or not you are using the example.

This means to run the script, you have to explicitly specify
STDIN as the first argument, then pass the actual argument, like so:

    ./part1.awk - 5 < example.txt
    ./part1.awk - 25 < input.txt
