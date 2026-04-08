#!/bin/bash
case_directory="${1:-cases}"
VERBOSE=false

# Parse flags
if [[ "$*" == *"--verbose"* ]]; then
  VERBOSE=true
fi

# Set the timeout duration in seconds
TIMEOUT_DURATION=10



for file in $case_directory/*.pl; do
  echo $file
  # Run swipl with a timeout
  if [ "$VERBOSE" = true ]; then
    timeout -s 9 $TIMEOUT_DURATION swipl $file
  else
    timeout -s 9 $TIMEOUT_DURATION swipl $file 2> /dev/null
  fi

  # Check the exit status of the timeout command
  # Exit status 124 indicates the command timed out
  if [ $? -eq 124 ]; then
    echo "Tax result: -1"
    echo "Label: -2"
  fi
done

# case_directory="${1:-cases}"
# TIMEOUT_DURATION=10
# VERBOSE=false

# # Check for --verbose flag
# if [[ "$*" == *"--verbose"* ]]; then
#   VERBOSE=true
# fi

# trap "exit" SIGINT

# for file in "$case_directory"/*.pl; do
#   echo "$file"
#   if [ "$VERBOSE" = true ]; then
#     timeout -s SIGINT "$TIMEOUT_DURATION" swipl "$file"
#   else
#     timeout -s SIGINT "$TIMEOUT_DURATION" swipl "$file" 2>/dev/null
#   fi
#   if [ $? -eq 124 ]; then
#     echo "Tax result: -1"
#     echo "Label: -2"
#   fi
# done
