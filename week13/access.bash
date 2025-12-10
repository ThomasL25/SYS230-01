#!/bin/bash

logfile="/home/champuser/SYS230-01/week13/fileaccesslog.txt"

# Log the access (with full path to date command, replacing : with -)
echo "File was accessed $(/bin/date | tr ':' '-')" >> "$logfile"

# Send email with log contents (with full paths)
echo "To: thomas.lukasiewicz@mymail.champlain.edu" > /tmp/emailaccess.txt
echo "Subject: Access" >> /tmp/emailaccess.txt
echo "" >> /tmp/emailaccess.txt
/bin/cat "$logfile" >> /tmp/emailaccess.txt
/bin/cat /tmp/emailaccess.txt | /usr/sbin/ssmtp thomas.lukasiewicz@mymail.champlain.edu
