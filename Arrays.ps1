# Instead storing a single value, you can store multiple values in a variable
$names = @("Blaine","George","Certis","Andrew","Aaron") #create a new array of names
Write-Host "--------------------------------------------------------------------------------------------------------------"
# This foreach loop will iterate through each item in our $names array
foreach($name in $names)
{
    Write-Host $name #Write-Host will output the value of $name to the console
}
Write-Host "--------------------------------------------------------------------------------------------------------------"
# What if we wanted to sort the names alphabetically
$sortedNames = $names | Sort-Object #Sort-Object takes what's on the pipeline and sorts it ascending by default

# Iterate through the members of $sortedNames and see if it is actually sorted or not
# This foreach loop will iterate through each item in our $names array
# It should be an alphabestical list
foreach($name in $sortedNames)
{
    Write-Host $name
}
Write-Host "--------------------------------------------------------------------------------------------------------------"
#What if we just want the last name on the list
$lastItem = $sortedNames | Select-Object -Last 1
Write-Host $lastItem
Write-Host "--------------------------------------------------------------------------------------------------------------"

# What if you only want names that contain the letter A
$containsLetterA = $names -match 'A'
foreach($name in $containsLetterA)
{
    Write-Host $name
}
Write-Host "--------------------------------------------------------------------------------------------------------------"

#End script