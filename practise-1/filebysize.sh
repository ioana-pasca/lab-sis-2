#!/bin/bash

# -----------------------------------------------------------------
#    File: filebysize.sh
#    Author: Ioana Carmen Pasca
#    Date: 25/02/2023
#    Goal: 
#          then the program shows their their addition, subtraction,
#          division and multiplication
# -------------------------------------------------------------------

# Constants
arg1="$1"

# Variables
files=$(ls -l | awk '{ size=$5 ; name=$9; printf(size/1024 " " name "\n") }')

usage() {  # Error of usage
	echo "usage: .filebysize [OPNION]..." 1>&2
	exit 1
}

file

# No options
echo files | sort -h -r | awk 'NR == 2 { printf($2) }'

# Options
if [ $arg1 = '-s' ]; then
    echo files | sort -h | awk 'NR == 2 { printf($2) }'

elif [ $arg1 = '-r' ]; then
