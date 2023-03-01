#!/bin/sh

# -----------------------------------------------------------------
#    File: processes.sh
#    Author: Ioana Carmen Pasca
#    Date: 28/02/2023
#    Goal: 
# -------------------------------------------------------------------

# Constants
MIN_PARAMS=1

# Variables
arg1="$1"
arg2="$2"

usage() {  # Error of usage
	echo "usage: ./filebysize [OPTION]... userName" 1>&2
	exit 1
}

# Checks the correct number of parameters
if [ $# -lt $MIN_PARAMS ]; then
	usage
fi

case $# in 
	-f)
		processes=$(ps -u ioana -o stat | grep R | wc -l)
		echo $arg2: $processes
		;;
	*)
		
	