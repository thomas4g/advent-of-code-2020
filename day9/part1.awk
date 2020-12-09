#!/usr/bin/env gawk -f
BEGIN {
    num_oldest_record = 0 
    buffer_size = ARGV[2]
}

{
    number=$1

    if (FNR > buffer_size) {
        found_match = 0
        for (i in buffer) {
            first_number = buffer[i]
            second_number = number - first_number
            if (lookup[second_number] > 0) {
                found_match = 1
                break
            }
        }
        

        if (!found_match) {
            print number
            exit 0
        }
    } 

    # add this number
    lookup[number] += 1
    buffer[FNR] = number

    # bump oldest number
    oldest_number_index = FNR - buffer_size
    oldest_number = buffer[oldest_number_index]
    delete buffer[oldest_number_index]
    lookup[oldest_number] -= 1
    if (lookup[oldest_number] <= 0) {
        delete lookup[oldest_number]
    }

}
