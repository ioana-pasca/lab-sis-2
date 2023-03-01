#!/bin/sh

# -----------------------------------------------------------------
#    File: processes.sh
#    Author: Ioana Carmen Pasca
#    Date: 28/02/2023
#    Goal: Checks the number of processes of a certain user
# -------------------------------------------------------------------

# Constants
MIN_PARAMS=1

# Variables
user="$1"
arg2="$2"

usage() {  # Error of usage
	echo "usage: ./filebysize [OPTION]... UserName" 1>&2
	exit 1
}

error() {  # Message of error
	echo 'error:' "$1" 1>&2
	exit 1
}

# Checks the correct number of parameters
if [ $# -lt $MIN_PARAMS ]; then
	usage
fi

# Chels if the user exists
if ! id $user >/dev/null 2>&1 ; then
	error "user $user does not exists in the system"
fi

case $arg2 in 
	-f)
		# Foreground processes of an user
		processes=$(ps -u $user -o stat | grep R | wc -l)
		echo "$user: $processes"
		;;
	-b)
		# Background processes of an user
		processes=$(ps -u $user -o stat | grep -E 'T|S' | wc -l)
		echo "$user: $processes"
		;;
	-a|"")
		# Total processes of an user
		processes=$(ps -u $user | wc -l)
		echo "$user: $processes"
		;;
	*)
		# Invalid argument
		error "option $arg2 is not valid" 
		;;
esac