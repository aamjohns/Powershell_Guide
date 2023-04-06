# Error Handling

Error handling is an essential aspect of writing robust PowerShell scripts. It allows you to manage and respond to errors that might occur during the execution of your script. In PowerShell, there are several techniques to handle errors:

### ErrorAction

`ErrorAction` parameter: ErrorAction is a common parameter in PowerShell cmdlets that allows you to control how non-terminating errors are handled during the execution of a cmdlet. It helps you manage the flow of your script when errors occur by specifying what action should be taken in response to an error.

Error action accepts the following values:

`SilentlyContinue`: This option suppresses the error message and continues executing the script without stopping. This can be useful when you expect errors to occur and do not want them to interrupt the script's execution.
```
Get-Content -Path "nonexistentfile.txt" -ErrorAction SilentlyContinue
```
Although the above will error, the script will continue without error

`Stop`: This option causes the cmdlet to throw a terminating error when an error occurs. Terminating errors stop the script's execution immediately, and you can use a try-catch-finally block to handle the error and take appropriate action.
```
Get-Content -Path "nonexistentfile.txt" -ErrorAction Stop
```
Output
```
Get-Content : Cannot find path 'C:\support\Powershell_Demo\nonexistentfile.txt' because it does not exist.
At line:1 char:1
+ Get-Content -Path "nonexistentfile.txt" -ErrorAction Stop
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (C:\support\Powe...xistentfile.txt:String) [Get-Content], ItemNotFoundException
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand
```
`Continue` This is the default behavior for most cmdlets. The cmdlet will display the error message and continue executing the script. This option is useful when you want to see the error messages but do not want the script to stop executing.
```
Get-Content -Path "nonexistentfile.txt" -ErrorAction Continue
```
The same error message as above will be displayed, but the next line of code (in a script) will execute.

`Inquire` This option prompts the user to decide what action to take when an error occurs. The user can choose to continue, halt the script, or suspend the script to examine the error in more detail. This can be helpful when debugging scripts or when the user needs to make decisions based on the error.
```
Get-Content -Path "nonexistentfile.txt" -ErrorAction Inquire
```
### ErrorActionPreference setting
Here's something you should know.  You can set the default error action for you entire script by setting the builtin variable `$ErrorActionPreference`

If you set `$ErrorActionPreference = "Stop"` then any error that occurs will stop your script.  Most commonly you would set `$ErrorActionPreference = "Continue"`.  That way you can see the errors but the script will continue.

### Try-Catch-Finally

Try-Catch-Finally: This block allows you to handle terminating errors by running specific code in response to an error. The basic structure is:
```
try {
    # Code that might cause an error
}
catch {
    # Code to execute if an error occurs
}
finally {
    # Code that always runs, regardless of errors
}
```
For example:
```
try {
    Get-Content -Path "nonexistentfile.txt" -ErrorAction Stop
}
catch {
    Write-Host "An error occurred: $_"
}
finally {
    Write-Host "This message will always be displayed"
}
```
In this example, the Get-Content cmdlet is set to `-ErrorAction Stop`, which makes it throw a terminating error if the file is not found. The catch block captures the error and displays a custom message.

### Try-Catch

You do not have to include `Finally`.  And most often I don't.  Usually I am trying to get information about the error, if an error occurred.  I don't normally have more code to execute after that.  So just know that using
```
try {
    # Some code that might have an error
}
catch {
    # Some code to execute if an error occurs
}
```
Is completely acceptable.  

### $_

The basic error message is stored in the built-in variable `$_`.  During the catch statement, you can access the current error record using the automatic variable `$_` (or `$PSItem`). The error record is an instance of the `System.Management.Automation.ErrorRecord` class and contains several properties that provide detailed information about the error that occurred.
```
try {
    Get-Content -Path "nonexistentfile.txt" -ErrorAction Stop
}
catch {
    Write-Host "An error occurred: $_" # $_ is the error message
}
```
There are various properties of $_ that can be accessed.  The code below gives examples.  
```
try {
    Get-Content -Path "nonexistentfile.txt"
}
catch {
    Write-Host "Error Message: $($_.Exception.Message)"
    Write-Host "Target Object: $($_.TargetObject)"
    Write-Host "Error Category: $($_.CategoryInfo.Category)"
    Write-Host "Script Stack Trace: $($_.ScriptStackTrace)"
}
```
Output
```
Error Message: Cannot find path 'C:\support\Powershell_Demo\nonexistentfile.txt' because it does not exist.
Target Object: C:\support\Powershell_Demo\nonexistentfile.txt
Error Category: ObjectNotFound
Script Stack Trace: at <ScriptBlock>, C:\Users\aamjohns\Documents\GitHub\JunkDrawer\Testing.ps1: line 2
```
If there are particular items you want to see, like the line number, you can access it through the properties of $_ in a catch statement.

### Error variable

PowerShell has a built-in variable called `$Error`, which is an array containing the errors that occurred during the script execution. You can inspect this variable to determine if errors occurred and take appropriate action.
```
Get-Content -Path "nonexistentfile.txt" -ErrorAction SilentlyContinue

if ($Error) {
    Write-Host "An error occurred: $($Error[0])"
}
```
In this example, the `$Error` variable is checked to see if it contains any errors. If so, the most recent error is displayed.



