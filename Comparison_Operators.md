# Comparison Operators

Comparison operators in PowerShell are used to compare values, and they return a Boolean result (True or False) based on the outcome of the comparison. They are essential for creating conditions, filtering data, and controlling the flow of your script.

Here are some common comparison operators in PowerShell:

Equality operators:

`-eq`: Equal to

`-ne`: Not equal to

Example of equality operator use:
```
$number1 = 10
$number2 = 20

if($number1 -ne $number2)
{
    Write-Host "The numbers were not equal"
}
else
{
    Write-Host "The numbers are equal"
}
```
Relational operators:

`-gt`: Greater than

`-ge`: Greater than or equal to

`-lt`: Less than

`-le`: Less than or equal to

Example of relational operator use:
```
$number1 = 10
$number2 = 20

if($number1 -lt $number2) 
{
    Write-Output "Number1 is less than Number2"
} 
else 
{
    Write-Output "Number1 is greater than or equal to Number2"
}
```
Containment operators:

`-contains`: Checks if a collection contains a specific value

`-notcontains`: Checks if a collection does not contain a specific value

`-in`: Checks if a value is present in a collection

`-notin`: Checks if a value is not present in a collection

Example of containment operator use:
```
$fruits = @("Apple", "Banana", "Orange")
$fruitToFind = "Banana"
if($fruits -contains $fruitToFind)
{
    Write-Host "Found Banana in the list"
}
else
{
    Write-Host "Did not find Banana in the list"
}
```
Pattern-matching operators:

`-like`: Checks if a value matches a pattern with wildcard characters (*, ?)

`-notlike`: Checks if a value does not match a pattern with wildcard characters

`-match`: Checks if a value matches a regular expression pattern

`-notmatch`: Checks if a value does not match a regular expression pattern

Example of pattern-matching operator use:
```
$sentence = "I once lived in this house on the corner"
$textToMatch= "this house"
if($sentence -match $textToMatch)
{
    Write-Host "Found this house in the sentence"
}
else
{
    Write-Host "Did not find this house in the sentence"
}
```
Type operators:

`-is`: Checks if an object is of a specific type

`-isnot`: Checks if an object is not of a specific type

Example of the Type operator use:
```
$nonNumber = "Not a number"
if($nonNumber -is [int])
{
    Write-Host "the value was an integer"
}
else
{
    Write-Host "the value was not an integer"
}
```
In the above example we expect to get the results 'the value is not an integer' because the value was a string.
