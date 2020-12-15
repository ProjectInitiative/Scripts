#!/usr/bin/env bash

# Current IP address and path to IP cache file
#IP_ADDRESS=`dig +short myip.opendns.com @resolver1.opendns.com`
IP_ADDRESS=$(ifconfig wlan0 | grep "inet " | awk -F'[: ]+' '{ print $3 }')
CACHE_PATH="/etc/ddns/cache.txt"

# Fetch last value of IP address sent to server or create cache file
if [ ! -f $CACHE_PATH ]; then touch $CACHE_PATH; fi
CURRENT=$(<$CACHE_PATH)

# If IP address hasn't changed, exit, otherwise save the new IP
if [ "$IP_ADDRESS" == "$CURRENT" ]; then exit 0; fi
echo $IP_ADDRESS > $CACHE_PATH


# SSH ip change
HOSTNAME="HOSTNAME"
USERNAME="USERNAME"
PASSWORD="PASSWORD"

curl -s "https://$USERNAME:$PASSWORD@domains.google.com/nic/update?hostname=$HOSTNAME&myip=$IP_ADDRESS"