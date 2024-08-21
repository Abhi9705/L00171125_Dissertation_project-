#!/bin/bash

FIS_EXP_ID=$1
echo "FIS_EXP_ID in measure_mttr: $FIS_EXP_ID"

# Capture the start time when the instance is initially running
START_TIME=$(date +%s)
echo "MTTR Start Time: $(date -d @$START_TIME)"

INSTANCE_ID="i-0609b0b289067d17d"

# Flag to indicate if we have detected the instance going down
DOWN_DETECTED=false

# Wait for the instance to return to the 'running' state
while true; do
  INSTANCE_STATUS=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].State.Name' --output text)
  echo "Current instance status: $INSTANCE_STATUS"
  
  if [ "$INSTANCE_STATUS" == "stopping" ] && [ "$DOWN_DETECTED" == false ]; then
    # Record the time when the instance starts shutting down
    DOWN_TIME=$(date +%s)
    echo "Instance started stopping at: $(date -d @$DOWN_TIME)"
    DOWN_DETECTED=true
  elif [ "$INSTANCE_STATUS" == "running" ] && [ "$DOWN_DETECTED" == true ]; then
    # Record the time when the instance is back to running
    END_TIME=$(date +%s)
    echo "Instance is back to running at: $(date -d @$END_TIME)"
    
    # Calculate MTTR
    MTTR=$((END_TIME - DOWN_TIME))
    echo "MTTR (seconds): $MTTR"
    
    break
  fi
  sleep 10
done
