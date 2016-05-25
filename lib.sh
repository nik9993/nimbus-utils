#!/bin/sh

# include the json sh library
. /usr/share/libubox/jshn.sh

##########################
# Shell Function Library #
##########################

##########################
# Process Commands

# prints ps output of process matching argument1
#   argument1: process name
#   argument2: optional string to ignore
#   returns ps output via echo
ps_proc () {
    # find any matching processes
    local process=`ps | grep -v grep | grep $1`

    #optional ignore
    if [ "$2" != "" ]; then
        process=`ps | grep -v grep | grep $1 | grep -v $2`
    fi

    echo "$process"
}

##################################
# Remote Process Call Functions

# function to parse json params object
#   argument1: if it is 'nodash', do not add a dash to the keys
#   returns a string via echo
parse () {
    # check if dash required
    local dash="-"
    if [ "$1" == "nodash" ]; then
        dash=""
    fi

    local retArgumentString=""

    # select the arguments object
    json_select params
    
    # read through all the arguments
    json_get_keys keys

    for key in $keys
    do
        # get the key value
        json_get_var val "$key"
        
        # specific key modifications
        if  [ "$key" == "ssid" ] ||
            [ "$key" == "password" ];
        then
            # add double quotes around ssid and password
            val="\"$val\""
        fi

        # wrap value in double quotes if it contains spaces
        if  [ "$(echo $val | grep ' ')" != "" ] ||
            [ "$(echo $val | grep '\n')" != "" ]
        then
            val="\"$val\""
        fi

        retArgumentString="$retArgumentString$dash$key $val "
    done

    echo "$retArgumentString"
}
