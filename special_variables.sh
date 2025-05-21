#! /bin/bash

echo "All variables passed to script: $@"
echo "Number of varibles passed: $#"
echo "Script name is : $0"
echo "Current directory is: $PWD"
echo " User running the script: $USER"
echo "PID of script: $$"
sleep 10 &
echo "PID of background process: $?"