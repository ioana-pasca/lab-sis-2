#!/bin/sh

# -----------------------------------------------------------------
#    File: idhosts.sh
#    Author: Ioana Carmen Pasca
#    Date: 2/03/2023
#    Goal: Prints the total number of PCs in /etc/hosts
# -------------------------------------------------------------------

# Constants
FILE="/etc/hosts"

# Variables
arg1="$1"
arg2="$2"
arg3="$3"
arg4="$4"
pcs_names=""

usage() {  # Error of usage
	echo "usage: ./idhosts.sh [OPTION]..." 1>&2
	exit 1
}

error() {  # Message of error
	echo 'error:' "$1" 1>&2
	exit 1
}

checkLab() {
    if ! grep -q "$arg2$" "$FILE"; then
        # Checks if the lab exists
        error "the lab $arg2 does not exists"
    fi
}

# Checks if FILE exists
if ! find $FILE -type f >/dev/null 2>&1 ; then
	error "the file $FILE does not exists"
fi

if [ "$arg1" = "" ]; then
    # Prints total number of PCs
    num_hosts=$(cat $FILE | grep urjc | wc -l)
    echo "Total number of hosts: $num_hosts"

elif [ "$arg1" = "-l" ] && [ "$arg3" = "-n" ]; then
    # Prints the numbers of the PCs of a specific lab
    checkLab

    lab=$(cat $FILE | grep "$arg2" | sed -E 's/.*L\.([0-9])\.([0-9]{3}).*/\1\2/')    
    for name in $(cat $FILE | grep "$lab" | awk '{ printf($3"\n") }'); do
        name_pc=$(echo $name | sed -E 's/.*-pc([0-9]{2})$/pc\1/')
        pcs_names=$(printf "%s %s" "$pcs_names" "$name_pc") # Concatenate strings
    done

    echo "$arg2:$pcs_names" 

elif [ "$arg1" = "-l" ]; then
    checkLab

    # Searchs for a concrete lab and its hosts
    lab=$(cat $FILE | grep "$arg2" | sed -E 's/.*L\.([0-9])\.([0-9]{3}).*/\1\2/')
    num_hosts=$(cat $FILE | grep "$lab" | wc -l)
    echo "$arg2 has $num_hosts hosts"

else
    usage
    
fi