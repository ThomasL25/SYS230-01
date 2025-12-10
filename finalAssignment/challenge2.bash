#! /bin/bash

# Check for correct number of arguments
if [[ $# -ne 2 ]]; then
    echo "Usage: bash finalC2.bash <log_file> <ioc_file>"
    exit 1
fi

logFile="$1"
iocFile="$2"
reportFile="report.txt"

# Clear report file
> "$reportFile"

while read -r ioc; do
    # Search for the IOC in the log file
    grep "$ioc" "$logFile" | awk '{print $1, $4, $7}' | sed 's/\[//g' >> "$reportFile"
done < "$iocFile"

echo "Report saved to $reportFile"
