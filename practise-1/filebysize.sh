#!/bin/sh

# -----------------------------------------------------------------
#    File: filebysize.sh
#    Author: Ioana Carmen Pasca
#    Date: 25/02/2023
#    Goal: Prints the file with the biggest size or smallest
# -------------------------------------------------------------------

# Variables
arg1="$1"
arg2="$2"
dir=$(pwd)

usage() {  # Error of usage
	echo "usage: ./filebysize.sh [OPTION]..." 1>&2
	exit 1
}

# Options
if [ "$arg1" = "" ]; then
	# No options, biggest size file
	find $dir -type f | sort -n | head -n 1

elif [ "$arg1" = "-s" ]; then
	# Smallest size file
    find $dir -type f | sort -nr | head -n 1

elif [ "$arg1" = "-r" ] && [ "$arg2" = "-s" ]; then
	# Smallest size file, recursive search
	find $dir -maxdepth 1 -type f | sort -nr | head -n 1

elif [ "$arg1" = "-r" ]; then
	# Biggest size file, recursive search
	find $dir -maxdepth 1 -type f | sort -n | head -n 1

else
	usage
fi

exit 0