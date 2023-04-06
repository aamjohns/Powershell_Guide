# Booleans
<#
        A boolean is a data type in PowerShell, as well as in most programming languages, 
        that represents two possible values: True or False. Booleans are commonly used in 
        conditional statements, comparisons, and various other situations where a true/false result is required.
#>
# To set a varaiable to True in Powershell
$value = $true
# Write the value of the variable out to the console
Write-Host "The value is $value"
#  Just know that in Powershell you use $true and $false rather than true and false

# Let's see if $value will evaluate to true
if($value -eq $true)
{
    Write-Host "Yes, it evaluated as $true"
}
else
{
    Write-Host "No, it evaluated as $false"
}

Write-Host "Just a moment while we test a connection..."
# Let's look at a cmdlet that returns $true or $false
$isOnline = Test-Connection -ComputerName "IN-OTA-192234" -Quiet # using the -Quiet parameter tells Test-Connection to return a boolean
Write-Host "Test-Connection result was $isOnline" #if you are on the IU network, this should write True to the console
Write-Host "Just a moment while we test a connection..."
#Since we know Test-Connection returns a boolean you can use it in an if statement
if(Test-Connection -ComputerName "NotReal" -Quiet) # I used a fake computer name so this will return $false
{
    Write-Host "Computer is online"
}
else
{
    Write-Host "Computer is offline"
}
<#
Boolean operators
PowerShell provides boolean operators that can be used to manipulate and combine boolean values:

-and: Returns $true if both operands are $true.
-or: Returns $true if at least one of the operands is $true.
-not or !: Reverses the boolean value.
#>
$condition1 = $true
$condition2 = $false

if ($condition1 -and $condition2) {
    Write-Host "Both conditions are true"
} elseif ($condition1 -or $condition2) {
    Write-Host "At least one condition is true"
} else {
    Write-Host "Both conditions are false"
}