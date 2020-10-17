#!/bin/bash

# File is input as argument
# Count number of failed login attempts by IP address
# If more than 10 failed attempts print number of attempts, IP address and location of IP
# Write in CSV file


LIMIT='10'
FILE="${1}"

# Check if file exits
if [[ ! -e "${FILE}" ]]
then
    echo "Can't open the log file: ${FIEL}" >&2
    exit 1
fi

# CSV
echo 'Count,IP,Location' > attack.csv

# Loop through the list of failed attempts and their IP addresses
grep Failed syslog-sample | awk '{print $(NF-3)}' | sort -n | uniq -c | sort -nr | while read COUNT IP
do 
    # If failed attempt is more than 10
    if [[ "${COUNT}" -gt "${LIMIT}" ]]
    then
        LOCATION=$(geoiplookup ${IP} | awk -F ',' '{print $2}')
        echo "${COUNT},${IP},${LOCATION}" >> attack.csv
    fi
done 
exit 0


# grep Failed syslog-sample | awk -F 'from ' '{print $2}' | awk '{print $1}'
# grep Failed syslog-sample | awk '{print $(NF-3)}'