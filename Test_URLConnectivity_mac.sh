#!/bin/bash

csv_path="./network-troubleshoot.csv"
timestamp=$(date +"%Y%m%d_%H%M%S")
outputfileName="./connectivity_output_$timestamp.csv"

# Function to test connectivity
test_connectivity() {
    address=$1
    port=$2

    if nc -z -w 5 "$address" "$port"; then
        pingSucceed=true
        portSucceed=true
        errorMessage="Connection successful"
    else
        pingSucceed=false
        portSucceed=false
        errorMessage="Connection failed"
    fi
}

# Read CSV and test connectivity
while IFS=, read -r address port; do
    test_connectivity "$address" "$port"

    echo "URL,Port,PingSucceed,PortSucceed,ErrorMessage" >> "$outputfileName"
    echo "$address,$port,$pingSucceed,$portSucceed,$errorMessage" >> "$outputfileName"
done < "$csv_path"
