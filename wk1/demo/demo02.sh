#!/bin/bash

# Display UID and username of the user executing the script and display if it is the root user or not.

# Display UID
echo "Your UID is ${UID}."

# Display username
USER_NAME=$(id -un)
# USER_NAME=`id -un`
echo "Your username is ${USER_NAME}."

# Display if the user is the root user or not.
if [[ "${UID}" -eq 0 ]]; ##spacing is important
then
    echo 'You are root.';
else
    echo 'You are not root.';
fi
## Sanity Checking