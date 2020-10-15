#!/bin/bash

# demonstrate function

log() {
    # Sends message to syslog and to standard output if VERBOSE is true
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then 
        echo "${MESSAGE}"
    fi
    logger -t demo02.sh "${MESSAGE}"
}

function logge {
    local VERBOSITY="${1}"
    shift
    local MESSAGE="${@}"
    if [[ "${VERBOSITY}" = 'true' ]]
    then 
        echo "${MESSAGE}"
    fi
}

backup_file() {
    # Creates a backup of a file and returns non-zero status on error.
    local FILE="${1}"

    # Make sure the file exits.
    if [[ -f "${FILE}" ]]
    then
        local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
        log "Backing up ${FILE} to ${BACKUP_FILE}."

        # The exit status fo the function will be the exit status of the cp command.
        cp -p ${FILE} ${BACKUP_FILE} # -p preserves file mode, ownership and time-stamp
    else
        # The file does not exist, so return a non-zero exit status
        return 1
    fi
}

readonly VERBOSE='true'

backup_file '/etc/passwd'

# Make a decision based on the exit statyus of the function
if [[ "${?}" -eq 0 ]]
then 
    log "File backup succeeded"
else    
    log "File backup failed!"
    exit 1
fi
#logge "true" "Hello Logger"
