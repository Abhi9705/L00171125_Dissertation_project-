#!/bin/bash

INSTANCE_ID="i-0609b0b289067d17d"
LOG_FILE="uptime_downtime.log"

# Function to get the current state of the instance
get_instance_status() {
    aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].State.Name' --output text
}

# Log the start time of uptime or downtime
log_time() {
    echo "$1: $(date +%s)" >> $LOG_FILE
}

# Initialize
echo "Tracking uptime and downtime for instance $INSTANCE_ID" > $LOG_FILE

# Start tracking uptime and downtime
previous_status=$(get_instance_status)
if [ "$previous_status" == "running" ]; then
    log_time "Uptime Start"
else
    log_time "Downtime Start"
fi

# Track the instance status changes
while true; do
    current_status=$(get_instance_status)
    if [ "$current_status" != "$previous_status" ]; then
        if [ "$current_status" == "running" ]; then
            log_time "Uptime Start"
        else
            log_time "Downtime Start"
        fi
        previous_status=$current_status
    fi
    sleep 60  # Check every minute
done
