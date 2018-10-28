free_memory=$(free -m | awk '{print $7}')
free_memory=$(($free_memory/1024)).$(($free_memory%1024))
total_memory=$(free -m | awk 'NR==2{print $2}')
total_memory=$(($total_memory/1024)).$(($total_memory%1024))
used_memory=$(bc <<< "$total_memory-$free_memory")

echo "total memory: $total_memory GiB     used memory: $used_memory GiB     free memory: $free_memory GiB"