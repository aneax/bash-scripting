#!/bin/bash

# Create account on local system

# Ask for username
read -p 'Enter the username to create: ' USER_NAME

# Ask for real name
read -p 'Enter the real name of the person who this account is for: ' COMMENT

# Ask for password
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for user
echo ${USER_NAME}:${PASSWORD} | chpasswd

# Force password change the first login
passwd -e ${USER_NAME}