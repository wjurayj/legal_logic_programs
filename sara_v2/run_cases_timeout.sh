#!/bin/bash

case_directory="${1:-cases}"
TIMEOUT_DURATION=10
VERBOSE=false

# Check for --verbose flag
if [[ "$*" == *"--verbose"* ]]; then
  VERBOSE=true
fi

trap "exit" SIGINT

for file in "$case_directory"/*.pl; do
  echo "$file"
  if [ "$VERBOSE" = true ]; then
    timeout -s SIGINT "$TIMEOUT_DURATION" swipl "$file"
  else
    timeout -s SIGINT "$TIMEOUT_DURATION" swipl "$file" 2>/dev/null
  fi
  if [ $? -eq 124 ]; then
    echo "Tax result: -1"
    echo "Label: -2"
  fi
done
