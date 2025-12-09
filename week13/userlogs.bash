#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser" 
}

# Todo - 1
# a) Make a little research and experimentation to complete the function
# b) Generate failed logins and test
function getFailedLogins(){
 logline=$(cat "$authfile" | grep "Failed password")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11)
 echo "$dateAndUser"
}

# Sending logins as email - Do not forget to change email address
# to your own email address
echo "To: thomas.lukasiewicz@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp thomas.lukasiewicz@mymail.champlain.edu

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as email 
echo "To: thomas.lukasiewicz@mymail.champlain.edu" > emailform_failed.txt
echo "Subject: Failed Logins" >> emailform_failed.txt
getFailedLogins >> emailform_failed.txt
cat emailform_failed.txt | ssmtp thomas.lukasiewicz@mymail.champlain.edu
