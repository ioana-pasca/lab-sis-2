#!/bin/bash

# -----------------------------------------------------------------
#    File: filebysize.sh
#    Author: Ioana Carmen Pasca
#    Date: 25/02/2023
#    Goal: Prints the file with the biggest size 
# -------------------------------------------------------------------

# Constants
arg1="$1"
arg2="$2"
dir=$(pwd)

# Variables
files=$(ls -l | awk '{ size=$5 ; name=$9; printf(size/1024 " " name "\n") }')

usage() {  # Error of usage
	echo "usage: ./filebysize [OPTION]..." 1>&2
	exit 1
}

# No options, biggest size
find $dir -type f | sort -n | head -n 1

# Options
if [ "$arg1" == "-s" ]; then
    find $dir -type f | sort -nr | head -n 1

elif [ "$arg1" == "-r" ]; then
	find $dir -maxdepth 1 -type f | sort -n | head -n 1

elif [ "$arg1" == "-r" ] && [ "$arg2" == "-s" ]; then
	find $dir -maxdepth 1 -type f | sort -nr | head -n 1

fi