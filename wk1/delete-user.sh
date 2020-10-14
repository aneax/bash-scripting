#!/bin/bash

if [[ "${UID} " -ne 0 ]]
then
    echo "You don't have previlige to do current task!"
    echo "Please try again as root user."
    exit 1
fi

read -p "Enter username to delete: " USER_NAME

id ${USER_NAME}

# if [[ "${?}" -eq 0 ]]
# then
#     echo "Username not found!"
#     echo "Exiting"
#     exit 1
# fi

userdel ${USER_NAME}

if [[ "${?}" -eq 0 ]]
then
    echo "Deletion successful!"
    echo "Exiting"
fi

exit 0