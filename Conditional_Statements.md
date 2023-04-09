# Conditional Statements

Conditional statements allow you to execute different parts of your script based on specific conditions. The conditions must evaluate to a boolean value, either True or False.

### if

`if` The if statement is used to test a condition, and if that condition is true, the code block within the `if` statement is executed.

An `if` statement is constructed using `if` followed by `(` and then the condition to evaluate followed by a closing `)`.  Next the `if` statement uses `{` and `}` to enclose all of the code to be executed if the if statement evaluates to True.
```
$text = "Hello from Froger"
if($text)
{
  Write-Host "The condition was true"
}
```
The above is a simple if statement.  Notice that the condition is just the variable `$text`.  As long as `$text` equals something, this will return True.

To see a similiar example, we will create the condition that the length of the string in the variable needs to be more than 5 characters (our string is so it should be true)
```
$text = "Hello from Froger"
if($text.Length -gt 5)
{
  Write-Host "The condition was true"
}
```
### elseif

The `elseif` statement is used after an `if` statement to test additional conditions if the previous `if` condition is False. You can chain multiple `elseif` statements, and PowerShell will execute the first block where the condition is True. If none of the `elseif` conditions are true, it will move to the `else` block (if present).

The following `if` statement will check if the first condition is True, if it is not, it will check if the second condition (`elseif`) is True.
```
$text = "Hello from Froger"
if($text.Length -gt 25)
{
  Write-Host "The string was more than 25 characters"
}
elseif($text.Length -lt 25)
{
  Write-Host "The string was less than 25 characters"
}
```
In the above, our first condition `($text.Length -gt 25)` is not going to be true because the string in our variable is not greater than 25 characters.  Powershell will now move to the `elseif` to check if it is true.  In this case, our string is less than 25 characters long, so it is true.

### else

`else` The else statement is used after an `if` or `elseif` statement to execute a block of code when none of the previous conditions are true.

In this example, we will make it so the `if` and the `elseif` evaluate to false, so the `else` statement will get executed.
```
$text = "Hello from Froger"
if($text.Length -eq 25)
{
  Write-Host "The string is 25 characters"
}
elseif($text.Length -eq 10)
{
  Write-Host "The string is 10 characters"
}
else
{
  Write-Host "The string is something other than 25 characters or 10 characters long"
}
```
In the example above, both the `if` and `elseif` conditions are False because the string in our variable is neither 25 characters nor 10 characters long. As a result, PowerShell moves to the `else` block and executes the code within it, displaying the message "The string is something other than 25 characters or 10 characters long".

