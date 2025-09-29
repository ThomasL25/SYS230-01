. (Join-Path $PSScriptRoot 'gatherClasses.ps1')

clear

# Test run to gather classes
$FullTable = gatherClasses

# Now change the days to more be more readable
$FullerTable = daysTranslator $FullTable

# List all the classes of Instructor Furkan Paligu
$FullerTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
             Where-Object { $_."Instructor" -ilike "*Furkan Paligu*"} | Format-Table -AutoSize

# List all the classes of JOYC 310 on Mondays, only display Class Code and Times
# Sort by Start Time
$FullerTable | Where-Object{ ($_.Location -ilike "JOYC 310") -and ($_.days -ilike "Monday") } | `
              Sort-Object "Time Start" | `
              Select-Object "Time Start", "Time End", "Class Code" | Format-Table -AutoSize

# Make a list of all the instructors that teach at least 1 course in
# SYS, SEC, NET, FOR, CSI, DAT
# Sort by name, and make it unique
$ITSInstructors = $FullerTable | Where-Object{ ($_."Class Code" -ilike "SYS*") -or `
                                          ($_."Class Code" -ilike "NET*") -or `
                                          ($_."Class Code" -ilike "SEC*") -or `
                                          ($_."Class Code" -ilike "FOR*") -or `
                                          ($_."Class Code" -ilike "CSI*") -or `
                                          ($_."Class Code" -ilike "DAT*") } | `
                             Select-Object "Instructor" | `
                             Sort-Object "Instructor" -Unique
$ITSInstructors | Format-Table -AutoSize

# Group all the instructors by the number of classes they are teaching
$FullerTable | Where-Object { $_.Instructor -in $ITSInstructors.Instructor  } | `
             Group-Object "Instructor" | Select-Object Count,Name | Sort-Object Count -Descending | Format-Table -AutoSize