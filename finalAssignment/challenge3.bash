#! /bin/bash

reportFile="report.txt"
htmlFile="report.html"

# Start HTML 
echo "<html>" > "$htmlFile"
echo "<body>" >> "$htmlFile"
echo "<h2>Access logs with IOC indicators:</h2>" >> "$htmlFile"
echo "<table border='1'>" >> "$htmlFile"

# Read each line from report.txt
while read -r line; do
    # Split the line
    ip=$(echo "$line" | awk '{print $1}')
    date=$(echo "$line" | awk '{print $2}')
    page=$(echo "$line" | awk '{print $3}')
    
    # Create table row with three cells
    echo "<tr><td>$ip</td><td>$date</td><td>$page</td></tr>" >> "$htmlFile"
done < "$reportFile"

# End HTML
echo "</table>" >> "$htmlFile"
echo "</body>" >> "$htmlFile"
echo "</html>" >> "$htmlFile"

# Move to web 
sudo cp "$htmlFile" /var/www/html/

