#!/bin/bash

# Generate Random Password
# Set password lenght by -l and add special characters with -s
# Verbose mode with -v

usage(){
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo 'Generate a random password.'
    echo ' -l LENGTH Specify the password length.'
    echo ' -s Append a special character to the password.'
    echo ' -v Increase verbosity.'
    exit 1 
}

log(){
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}"
    fi
}

# Set  default password length
LENGTH=48

while getopts vl:s OPTION
do 
    case ${OPTION} in
    v)
        VERBOSE='true'
        log 'Verbose mode on.'
        ;;
    l)  
        LENGTH="${OPTARG}"
        ;;
    s)  
        USE_SPECIAL_CHARACTER='true'
        ;;
    ?)  
        usage
        exit 1
        ;;
    esac
done

# echo "Number of args: ${#}"
# echo "All args: ${@}"
# echo "First arg: ${1}"
# echo "Second arg: ${2}"
# echo "Third arg: ${3}"

# Inspect OPTIND
echo "OPTIND: ${OPTIND}" ##OPTIND from getopts

# Remove the options while leaving the remaining arguments
shift "$(( OPTIND - 1)) "

log "Generating a password."
# echo "After the shift"
# echo "All args: ${@}"
# echo "First arg: ${1}"
# echo "Second arg: ${2}"
# echo "Third arg: ${3}"

if [[ "${#}" -gt 0 ]]
then 
    usage
fi

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# Append a special character if requested to do so.
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then    
    log "Selecting a random specical character."
    SPECIAL_CHARACTER=$(echo '!@#$%^&*()-_+=' | fold -w1 | shuf | head -c1)
    PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done'
log 'Here is the password'

# Display the password
echo 
echo "${PASSWORD}"

exit 0





