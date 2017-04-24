#!/bin/bash
IFS=$'\n'
for item in $(grep -o "Ban[ ]\+[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" fail2ban.log | cut -f 2 -d " " | sort -n | uniq ) 
do
# echo $item >> ip
geoiplookup "$item" | cut -f 2 -d ":" >> country.txt
done
sort country.txt | uniq -c | sort -rn 
rm -f country.txt
