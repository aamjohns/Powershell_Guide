# Logical Operators

Logical operators are used to combine or modify expressions, mainly for use in conditional statements like `if`, `while`, and others

`-and` This operator returns True if both the left and right expressions are true, otherwise, it returns False.

Example using -and operator:
```
$number1 = 10
$number2 = 20
$number3 = 30
if($number1 -lt $number2 -and $number3 -gt $number2)
{
  Write-Host "The first condition and the second condition are both true"
}
else
{
  Write-Host "The first condition and the second condition are not both true"
}
```
`-or` This operator returns True if either the left or right expression is true, otherwise, it returns False.

Example using -or operator:
```
$number1 = 10
$number2 = 20
$number3 = 30
if($number2 -lt $number1 -or $number3 -gt $number2)
{
  Write-Host "The first condition or the second condition is true"
}
else
{
  Write-Host "The first condition or the second condition is not true"
}
```
`-not` or `!` This operator negates the value of the expression. If the expression is true, it returns False, and if the expression is false, it returns True.

Example using -not operator
```
$number1 = 1
if(-not ($number1 -gt 10))
{
  Write-Host "True, 1 is not greater than 10"
}
else
{
  Write-Host "False, the number was greater than 10"
}
```
Notice in the above we used () around the expression we want to negate.  So we say -not the result of ($number1 -gt 10).

