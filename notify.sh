free_memory=$1

mem_less_than_1=$(bc <<< "$free_memory < 1")
mem_less_than_pt5=$(bc <<< "$free_memory < 0.5")

if [ $mem_less_than_pt5 -eq 1 ]; then
    notify-send "Less than 0.5GiB of memory is free."
elif [ $mem_less_than_1 -eq 1 ]; then
    notify-send "Less than 1GiB of memory is free."
fi