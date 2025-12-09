#!/bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
    allLogs=$(cat "$file" | awk '{print $1, $4, $7}' | tr -d "[")
}

function ips(){
    ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)
}

function pageCount(){
    pagesAccessed=$(grep -oP '"GET \K[^ ]+' "$file" | sort | uniq -c)
}

function countingCurlAccess(){
    curlAccess=$(grep -i "curl" "$file" | awk '{print $1, $NF}' | sort | uniq -c)
}

countingCurlAccess
echo "$curlAccess"
