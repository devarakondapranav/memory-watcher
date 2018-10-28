free_memory=$(free -m | awk '{print $7}')
free_memory=$(($free_memory/1024)).$(($free_memory%1024))

limit=$1
mem_less_than_1=$(bc <<< "$free_memory < $limit")
mem_less_than_pt5=$(bc <<< "$free_memory < 0.5")

if [ $mem_less_than_pt5 -eq 1 ]; then
    notify-send "Less than 0.5GiB of memory is free."
elif [ $mem_less_than_1 -eq 1 ]; then
    notify-send "Less than $limit GB of memory is free."
fi