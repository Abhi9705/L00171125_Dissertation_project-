#!/bin/bash


FIS_EXP_ID=$1

# Debugging: Check if FIS_EXP_ID is set
if [ -z "$FIS_EXP_ID" ]; then
  echo "FIS_EXP_ID is not set. Exiting."
  exit 1
fi

echo "FIS_EXP_ID: $FIS_EXP_ID"

# Capture the start time
START_TIME=$(date +%s)
echo "MTTR Start Time: $(date -d @$START_TIME)"

INSTANCE_ID="i-0609b0b289067d17d"

# Wait for the instance to return to the 'running' state
while true; do
  INSTANCE_STATUS=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].State.Name' --output text)
  echo "Current instance status: $INSTANCE_STATUS"
  
  if [ "$INSTANCE_STATUS" == "running" ]; then
    # Capture the end time when the instance is back to running
    END_TIME=$(date +%s)
    echo "MTTR End Time: $(date -d @$END_TIME)"
    
    # Calculate MTTR
    MTTR=$((END_TIME-START_TIME))
    echo "MTTR (seconds): $MTTR"
    break
  fi
  sleep 10
done
