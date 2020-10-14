#!/bin/bash

# This script displays various information to the screen.
# Display "Hello"
echo 'Hello'

# Assign a value to a variable
WORD='script' ##no space in between

# Display the value
echo "$WORD"

# Sigle quotes
echo '$WORD'

# Variable with text
echo "This is a shell $WORD."

#Alternative
echo "This is a shell ${WORD}."

#Append text to the variable.
echo "${WORD}ing is fun!"

# How not to append. Prefer all upper case variables
echo "$WORDing is fun" ##Bash doesn't know

# Create a new variable
ENDING='ed'

# COmbine
echo "This is ${WORD}${ENDING}."

# Reassignment
ENDING='ing'
echo "${WORD}${ENDING} is fun."
 