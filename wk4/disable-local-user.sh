#!/bin/bash

# Delete/Disable user account
# If promted -r removes home directory
# If promted -a archives the home directory
# If any other options, exit with exit status 1
# Accept list of username as argument with minimum one username
# Refuse to disable username with UID less than 1000
# Inform user
# Display user name and the performed action

ARCHIVE_DIR='/archive'

if [[ ${UID} -ne 0 ]]
then    
    echo "Permission denied. Please run as root user." >&2
    exit 1
fi

usage(){
    echo "Usage: ${0} [-vrda] USERNAME [USERNAME] ..." >&2
    echo 'Disable the user account.' >&2
    echo ' -d Deletes the associated account.' >&2
    echo ' -r Removes the home directory with associated account.' >&2
    echo ' -a Archives the home directory with associated account.' >&2
    exit 1 
}

log(){
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}"
    fi
}

while getopts dra OPTION
do 
    case ${OPTION} in
        d) DELETE_USER='true' ;;
        r) REMOVE_OPTION='-r' ;;
        a) ARCHIVE='true' ;;
        ?) usage ;;
    esac
done

## Remove the options
shift "$(( OPTIND - 1 ))"

# Check if user supplied at least one user
if [[ "${#}" -lt 1 ]]
then
    usage
    exit 1
fi

# Loop through usernames
for USERNAME in "${@}"
do 
    echo "Processing user: ${USERNAME}"

    # Check UID
    USERID=$(id -u ${USERNAME})
    if [[ "${USERID}" -lt 1000 ]]
    then    
        echo "Can't delete/disable ${USERNAME} with UID ${USERID}." >&2
        exit 1
    fi

    # Create archive if requested
    if [[ "${ARCHIVE}" = 'true' ]]
    then

        # Check if archive directory exits
        if [[ ! -d "${ARCHIVE_DIR}" ]]
        then 
            echo "Creating ${ARCHIVE_DIR} directory."
            mkdir -p ${ARCHIVE_DIR}

            if [[ "${?}" -ne 0 ]]
            then         
                echo "The archive directory ${ARCHIVE_DIR} could not be created." >&2
                exit 1
            fi
        fi

        # Archive now.
        HOME_DIR="/home/${USERNAME}"
        ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
        if [[ -d "${HOME_DIR}" ]]
        then
            echo "Archiveing ${HOME_DIR} to ${ARCHIVE_FILE}."
            tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
            if [[ "${?}" -ne 0 ]]
            then
                echo "Couldn't create tar ${ARCHIVE_FILE} file." >&2
                exit 1
            fi  
        else
            echo "${HOME_DIR} does not exist or is not a directory." >&2
            exit 1 
        fi

    fi

    # Check if delete is true.
    if [[ "${DELETE_USER}" = 'true' ]]
    then
        # Delete
        userdel ${REMOVE_OPTION} ${USERNAME}

        # Did it succeed.
        if [[ "${?}" -ne 0 ]]
        then
            echo "The account ${USERNAME} couldn't be deleted."
            exit 1
        fi
        echo    "The account ${USERNAME} was deleted."
    else
        # Expire the account
        chage -E 0 ${USERNAME} 
        
        # Did it succeed.
        if [[ "${?}" -ne 0 ]]
        then
            echo "The account ${USERNAME} couldn't be disabled."
            exit 1
        fi
        echo    "The account ${USERNAME} was disabled."
    fi
done

exit 0




