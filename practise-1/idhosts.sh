#!/bin/sh

# -----------------------------------------------------------------
#    File: idhosts.sh
#    Author: Ioana Carmen Pasca
#    Date: 2/03/2023
#    Goal: Prints the total number of pcs
# -------------------------------------------------------------------

# Variables
arg1="$1"
arg2="$2"
arg3="$3"
arg4="$4"

usage() {  # Error of usage
	echo "usage: ./idhosts.sh [OPTION]..." 1>&2
	exit 1
}

error() {  # Message of error
	echo 'error:' "$1" 1>&2
	exit 1
}