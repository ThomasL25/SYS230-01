#! /bin/bash

# IOC webpage link
link="http://10.0.17.47/IOC.html"

# Get the page with curl
fullPage=$(curl -sL "$link")

# Extract from the table
echo "$fullPage" | \
xmlstarlet select --html --recover --template \
--match "//table//tr[position()>1]/td[1]" \
--value-of "." --nl \
2>&1 | grep -v "^-:" | \
grep -v "^$" \
> IOC.txt

echo "IOC list saved to IOC.txt"
