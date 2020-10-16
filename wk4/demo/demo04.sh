#!/bin/bash

# Delete user

# Run as root

if [[ "${UID}" -ne 0 ]]
then 
    echo "Please run as root user." >&2
    exit 1
fi

# Take first argument as user to delete
USER="${1}"

# Delete
userdel ${USER}

# Check if it got deleted
if [[ "${?}" -ne 0 ]]
then
    echo "The account ${USER} was NOT deleted." >&2
    exit 1
fi

# 
echo "The account ${USER} deletion succeeded."
exit 0
