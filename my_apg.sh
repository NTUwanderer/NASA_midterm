#!/usr/bin/env bash
arg="$*"
IFS=$'\n'

num_of_pass=$(echo "$arg" | grep -o '\-n [0-9]\+' | cut -d' ' -f2)
if [ ! -z "$num_of_pass" ]; then
   arg=$(echo "$arg" | sed 's/-n [0-9]\+ \?//g')
else
   num_of_pass=6
fi

min_pass_len=$(echo "$arg" | grep -o '\-m [0-9]\+' | cut -d' ' -f2)
if [ ! -z "$min_pass_len" ]; then
   arg=$(echo "$arg" | sed 's/-m [0-9]\+ \?//g')
else
   min_pass_len=8
fi

max_pass_len=$(echo "$arg" | grep -o '\-x [0-9]\+' | cut -d' ' -f2)
if [ ! -z "$max_pass_len" ]; then
   arg=$(echo "$arg" | sed 's/-x [0-9]\+ \?//g')
else
   max_pass_len=10
fi
if [[ $min_pass_len -gt $max_pass_len ]]; then
   max_pass_len=$min_pass_len
fi
# printf "n=%s m=%s x=%s\n" "$num_of_pass" "$min_pass_len" "$max_pass_len"

# arg=$(echo $arg | sed 's/ //g')
if [ ! -z "$arg" ]; then
   ( >&2 printf "Invalid arguments : %s\n" "$arg")
   exit 1
fi

for i in $(seq 1 $num_of_pass); do
   range=$(expr $max_pass_len - $min_pass_len + 1)
   len=$(expr $RANDOM % $range + $min_pass_len)
   # len=$(expr $len + $min_pass_len)
   cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $len | head -n 1
done
