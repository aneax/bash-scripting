#!/bin/bash

# Generate list of random passwords

PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# Three random numbers
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# Use date time as basis for password
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# Randomized by nanoseconds
PASSWORD=$(date +%s%Ns)
echo "${PASSWORD}"

# Better password
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# Even Better
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c32)
echo "${PASSWORD}"

# Even Better

S='!@#$%^&*()_-+=~'
SPECIAL_CHARACTER=$(echo ${S} | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"