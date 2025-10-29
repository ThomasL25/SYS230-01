#!/bin/bash

# List all the ips in the given network prefix
# /24 only

# Usage: bash IPList.bash 10.0.17
[ $# -ne 1 ] &&  echo "Usage: $0 <Prefix>" && exit 1

# Prefix is the first input taken
prefix=$1

# Verify Input Length
[ ${#prefix} -lt 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1

for i in {0..255}
do
   ping -c 1 -W 1 $prefix.$i | grep "64 bytes" | \
   grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
done
