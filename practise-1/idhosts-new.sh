#!/bin/sh

# -----------------------------------------------------------------
#    File: idhosts-new.sh
#    Author: Ioana Carmen Pasca
#    Date: 3/03/2023
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

checkLab() {  # Checks if the lab exists
    if ! grep -q "$arg2$" "$FILE"; then
        error "the lab $arg2 does not exists"
    fi
}

# Checks if FILE exists
if ! find $FILE -type f >/dev/null 2>&1 ; then
	error "the file $FILE does not exists"
fi

if [ "$arg1" = "" ]; then
    # Prints the total number of all PCs

    pcs_num=$(cat $FILE | grep "urjc" | wc -l)
    echo "Total of hosts: $pcs_num"

elif [ "$arg1" = "-l" ] && [ "$arg3" = "-n" ]; then
    # Prints the name, IP and subdomain of the PCs of a specific lab
    checkLab

    lab=$(cat $FILE | grep "$arg2" | sed -E 's/.*L\.([0-9])\.([0-9]{3}).*/\1\2/')    
    awk -v lab="$lab" -v l="$arg2" \
    'BEGIN {print "\nLab: ", l, "\n"; printf "%-9s %-15s %-22s\n", "Id PC", "IP", "Subdomain"; print "--------- -------------- ---------------------------"} \
    $0 ~ lab {sub(/.*-pc/, "pc", $3); sub(/.*pc[0-9]+\.*/, "", $2); printf "%-9s %-15s %-25s\n", $3, $1, $2; count++} \
    END {print "\nTotal hosts:", count}' $FILE

elif [ "$arg1" = "-l" ] && [ "$arg2" != "" ]; then
    # Searchs for a concrete lab and its hosts
    checkLab

    lab=$(cat $FILE | grep "$arg2" | sed -E 's/.*L\.([0-9])\.([0-9]{3}).*/\1\2/')
    num_hosts=$(grep $lab $FILE | wc -l)
    names_hosts=$(grep "$lab" $FILE | awk '{ print $3 }')
    ip_hosts=$(grep "$lab" $FILE | awk '{ print $1 }')

    first_host=$(echo $names_hosts | tr ' ' '\n' | head -n 1 | sed -E 's/.*-pc([0-9]{2})$/pc\1/')
    first_ip=$(echo $ip_hosts | tr ' '  '\n' | head -n 1)
    last_host=$(echo $names_hosts | tr ' ' '\n' | tail -n 1 | sed -E 's/.*-pc([0-9]{2})$/pc\1/')
    last_ip=$(echo $ip_hosts | tr ' '  '\n' | tail -n 1)
 
    awk -v l="$arg2" -v t=$num_hosts -v fh=$first_host -v fip=$first_ip -v lh=$last_host -v lip=$last_ip \
    'BEGIN { printf("\nLab: %s\n\nTotal: %i\n\nFirst host: %s | %s\n\nLast host: %s | %s\n\n", l, t, fh, fip, lh, lip) }' 

else
    # Invalid argument
    usage
    
fi