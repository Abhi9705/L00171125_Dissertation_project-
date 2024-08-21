#!/bin/bash

LOG_FILE="uptime_downtime.log"

if [ ! -f "$LOG_FILE" ]; then
  echo "Log file not found. Exiting."
  exit 1
fi

# Read log file and calculate total uptime and downtime
total_uptime=0
total_downtime=0
prev_time=0
current_time=0

while read -r line; do
  status=$(echo $line | awk '{print $1}')
  timestamp=$(echo $line | awk '{print $2}')
  if [ "$status" == "Uptime" ]; then
    if [ $prev_time -ne 0 ]; then
      total_downtime=$((total_downtime + timestamp - prev_time))
    fi
    prev_time=$timestamp
  elif [ "$status" == "Downtime" ]; then
    if [ $prev_time -ne 0 ]; then
      total_uptime=$((total_uptime + timestamp - prev_time))
    fi
    prev_time=$timestamp
  fi
done < "$LOG_FILE"

# Assuming the total time is from the first to the last event
total_time=$((prev_time - $(head -n 1 $LOG_FILE | awk '{print $2}')))
uptime_percentage=$(echo "scale=2; ($total_uptime / $total_time) * 100" | bc)

echo "System Uptime: $uptime_percentage%"
