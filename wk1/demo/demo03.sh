#!/bin/bash

# Display the UID
echo "Your UID is ${UID}."

# Only display if the UID does not match 1000.
UID_TO_TEST_FOR='1000'

if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
    echo "Your UID doesn't match ${UID_TO_TEST_FOR}."
    exit 1
fi

# Display username.
USER_NAME=$(id -un)

# Test if the command succeeded.
if [[ "${?}" -ne 0 ]]
then
    echo "The id command didn't execute successfully."
    exit 1
fi

echo "Your username is ${USER_NAME}."

# String test conditional.
USER_NAME_TO_TEST='aneax'

if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST}" ]] ## "" = "" comparision not assignment ( == is pattern match and = equal match)
then
    echo "Your username matches ${USER_NAME_TO_TEST}."
fi

# Test for !=
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST}" ]]
then
    echo "Your username doesn't matches ${USER_NAME_TO_TEST}."
    exit 1
fi

exit 0