#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
function displayCoursesInLocation(){
echo -n "Please Input a Class Name: "
read className

echo ""
echo "Courses in $className :"
cat "$courseFile" | grep "$className" | \
cut -d';' -f1,2,5,6,7 | \
sed 's/;/ | /g'
echo ""
}

# TODO - 2
# Make a function that displays all the courses that has availability
function displayAvailableCourses(){
echo -n "Please Input a Subject Name: "
read subjectName

echo ""
echo "Available courses in $subjectName :"
cat "$courseFile" | grep "^$subjectName" | \
awk -F';' '$4 > 0 {print $1, "|", $2, "|", $4, "|", $5, "|", $6, "|", $7}'
echo ""
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses of a classroom"
	echo "[4] Display available courses of subject"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		displayCoursesInLocation

	elif [[ "$userInput" == "4" ]]; then
		displayAvailableCourses

	# TODO - 3 Display a message, if an invalid input is given
	else
		echo "Invalid option."
	fi
done
