#!/bin/bash

# Create new user in local system.
# Input: Full Name, Username, Password

# Execute with root privileges else exit
USER_NAME=$(id -un)
USER_NAME_ROOT='root'

if [[ "${UID} " -ne 0 ]]
then
    echo "You don't have previlige to do current task!"
    echo "Please try again as root user."
    exit 1
fi

# if [[ "${USER_NAME} "!= "${USER_NAME_ROOT}" ]]
# then
#     echo "You don't have previlige to do current task!"
#     echo "Please try again as root user."
#     exit 1
# fi

# Username, full name and initial password
read -p "Enter new username: " USER_NAME

read -p "Enter full name: " NAME
read -p "Enter a password: " PASSWORD
read -p "Reenter your password: " APASSWORD

if [[ "${PASSWORD}" != "${APASSWORD}" ]]
then
    echo "Two password didn't match"
    echo "Try again"
    exit 1
fi

# Add username
useradd -c "${NAME}" -m ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
    echo "${USER_NAME} already exists."
    echo "Try new username"
    exit 1
fi

# Set Password
echo ${USER_NAME}:${PASSWORD} | chpasswd

if [[ "${?}" -ne 0 ]]
then
    echo "Password setup failed."
    exit 1
fi

# Force password change in first login
passwd -e ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
    echo "Change password failed."
    exit 1
fi


# If created successfully display informations.

echo
echo "${USER_NAME} creation successful!"
echo
echo "Full Name: ${NAME}" 
echo
echo "Username: ${USER_NAME}"
echo
echo "Password: ${PASSWORD}"
echo
echo "Host: ${HOSTNAME}"

exit 0