#!/bin/bash

## Shift and while loops

# Display the first three parameters.

echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"
echo


# While loop

# while [[ "${X}" -eq 1 ]]
# do
#     echo "This is the value of X: ${X}"
#     X=7
# done

# Loop through all positional parameters
while [[ "${#}" -gt 0 ]]
do 
    echo "Number of parameters: ${#}"
    echo "Parameter 1: ${1}"
    echo "Parameter 2: ${2}"
    echo "Parameter 3: ${3}"
    echo
    shift [3]
done

# while [[ true ]]
# do
#     echo "${RANDOM}"
#     sleep 1
# done