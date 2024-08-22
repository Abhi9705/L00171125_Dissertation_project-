#!/bin/bash

LOG_FILE="uptime_downtime.log"

if [ ! -f "$LOG_FILE" ]; then
  echo "Log file not found. Exiting."
  exit 1
fi

# Initialize counters
total_uptime=0
total_downtime=0
previous_time=0
current_time=0
last_status=""

# Read log file and calculate total uptime and downtime
while read -r line; do
  status=$(echo "$line" | awk '{print $1}')
  timestamp=$(echo "$line" | awk '{print $2}')
  
  if [[ ! "$timestamp" =~ ^[0-9]+$ ]]; then
    echo "Invalid timestamp format in log file. Exiting."
    exit 1
  fi

  if [ -z "$last_status" ]; then
    # Initial status setup
    last_status="$status"
    previous_time=$timestamp
  else
    if [ "$status" == "Uptime" ]; then
      if [ "$last_status" == "Downtime" ]; then
        total_downtime=$((total_downtime + timestamp - previous_time))
      fi
      previous_time=$timestamp
    elif [ "$status" == "Downtime" ]; then
      if [ "$last_status" == "Uptime" ]; then
        total_uptime=$((total_uptime + timestamp - previous_time))
      fi
      previous_time=$timestamp
    fi
    last_status="$status"
  fi
done < "$LOG_FILE"

# Handle the last period
if [ "$last_status" == "Uptime" ]; then
  total_uptime=$((total_uptime + $(date +%s) - previous_time))
else
  total_downtime=$((total_downtime + $(date +%s) - previous_time))
fi

# Calculate total time from first log entry to now
start_time=$(head -n 1 "$LOG_FILE" | awk '{print $2}')
current_time=$(date +%s)
total_time=$((current_time - start_time))

# Calculate uptime percentage
if [ $total_time -gt 0 ]; then
  uptime_percentage=$(echo "scale=2; ($total_uptime / $total_time) * 100" | bc)
else
  uptime_percentage=0
fi

echo "System Uptime: $uptime_percentage%"
