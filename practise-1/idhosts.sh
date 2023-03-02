#!/bin/sh

# -----------------------------------------------------------------
#    File: idhosts.sh
#    Author: Ioana Carmen Pasca
#    Date: 2/03/2023
#    Goal: Prints the total number of PCs in /etc/hosts
# -------------------------------------------------------------------

# Constants
FILE="/home/ioana/lab-sis-2/practise-1/cases/hosts"

# Variables
arg1="$1"
arg2="$2"
arg3="$3"
arg4="$4"
file_=$(cat $FILE)

usage() {  # Error of usage
	echo "usage: ./idhosts.sh [OPTION]..." 1>&2
	exit 1
}

error() {  # Message of error
	echo 'error:' "$1" 1>&2
	exit 1
}

# Checks if FILE exists
if ! find $FILE -type f >/dev/null 2>&1 ; then
	error "the file $FILE does not exists"
fi

# Prints total number of PCs
num_hosts=$(echo $file_ | grep urjc | wc -l)
echo "Total number of hosts: $num_hosts"

if [ "$arg1" == "-l" ]; then
    if ! find $arg2 >/dev/null 2>&1 ; then
        error "the lab $arg2 does not exists"
    fi

    lab=$(echo $arg2 | sed -E 's/.//' | sed -E 's/L//')
    num_hosts=$(echo $file_ | grep $lab | wc -l)
    echo "$arg2 has $num_hosts hosts"
fi