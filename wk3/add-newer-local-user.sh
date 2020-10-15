#!/bin/bash

# Create new user in local system.
# Input: Username
# Optionally, can provide a comment for account generated.
# Password will be automatically generated
# Display the information

# Execute with root privileges else exit
if [[ "${UID} " -ne 0 ]]
then
    echo "You don't have previlige to do current task!" >&2  
    echo "Please try again as root user." >&2
    exit 1
fi

# Need to supply at least one argument.
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line."
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
    echo "Usage:: ${0} USER_NAME [COMMENT] ..." >&2
    echo "Create an account on the local system with the name of USER_NAME and a comments field of COMMENT" >&2
    exit 1
fi

# Username and Comments
USER_NAME="${1}"
shift
COMMENT="${@}"

# Generate Password
PASSWORD=$(date +%s%N | sha256sum | head -c12)

# Add username
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null ##All output generated will not be displayed

if [[ "${?}" -ne 0 ]]
then
    echo "${USER_NAME} already exists." >&2
    echo "Try new username"
    exit 1
fi

# Set Password
echo ${USER_NAME}:${PASSWORD} | chpasswd &> /dev/null

if [[ "${?}" -ne 0 ]]
then
    echo "Password setup failed." >&2
    echo $(sudo userdel $(USER_NAME)) >&2
    exit 1
fi

# Force password change in first login
passwd -e ${USER_NAME} &> /dev/null

if [[ "${?}" -ne 0 ]]
then
    echo "Change password failed." >&2
    exit 1
fi


# If created successfully display informations.

echo "${USER_NAME} creation successful!"
echo
echo "Full Name: ${COMMENT}" 
echo
echo "Username: ${USER_NAME}"
echo
echo "Password: ${PASSWORD}"
echo
echo "Host: ${HOSTNAME}"

# tail -3 /etc/passwd ## To check the created users

exit 0