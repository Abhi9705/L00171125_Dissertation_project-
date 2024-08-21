#!/bin/bash

LOG_FILE="uptime_downtime.log"

# Ensure the log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "Log file not found. Exiting."
  exit 1
fi

# Initialize variables
total_uptime=0
total_downtime=0
previous_time=0
last_status=""

# Read the log file and calculate total uptime and downtime
while read -r line; do
  status=$(echo "$line" | awk '{print $1}')
  timestamp=$(echo "$line" | awk '{print $2}')
  
  # Convert timestamp to seconds if it's a valid number
  if ! [[ $timestamp =~ ^[0-9]+$ ]]; then
    echo "Invalid timestamp format in log file. Exiting."
    exit 1
  fi

  if [ "$last_status" == "Uptime" ] && [ "$status" == "Downtime" ]; then
    total_uptime=$((total_uptime + timestamp - previous_time))
  elif [ "$last_status" == "Downtime" ] && [ "$status" == "Uptime" ]; then
    total_downtime=$((total_downtime + timestamp - previous_time))
  fi

  previous_time=$timestamp
  last_status=$status
done < "$LOG_FILE"

# Calculate total time from the first log entry to the last
start_time=$(head -n 1 "$LOG_FILE" | awk '{print $2}')
end_time=$(tail -n 1 "$LOG_FILE" | awk '{print $2}')
total_time=$((end_time - start_time))

# Calculate uptime percentage
if [ "$total_time" -gt 0 ]; then
  uptime_percentage=$(echo "scale=2; ($total_uptime / $total_time) * 100" | bc)
else
  uptime_percentage=0
fi

echo "System Uptime: $uptime_percentage%"
