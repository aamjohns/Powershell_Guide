# Cmdlets

PowerShell relies on cmdlets as the primary building blocks for executing tasks and managing various aspects of the system. Cmdlets, short for "command-lets," are specialized .NET classes that perform specific actions on a given target, following a consistent verb-noun naming convention. This section will introduce you to the fundamentals of cmdlets, including their syntax, how to use them with parameters, and the concept of pipelining, which allows you to chain cmdlets together for more complex operations.

### Basics

Cmdlets are the primary commands used in PowerShell, designed to be easy to read and understand. They follow a consistent verb-noun naming structure that makes it simple to recognize their purpose and functionality. The verb in the cmdlet's name represents the action it performs, while the noun represents the resource or object it acts upon. This naming convention allows users to quickly comprehend the cmdlet's purpose and anticipate its behavior.

For example, let's consider the cmdlet `Get-Service`. The verb "Get" indicates that the cmdlet retrieves information, while the noun "Service" specifies that the information pertains to system services. Therefore, Get-Service retrieves a list of all services running on the system.

Another example is the cmdlet `Set-Location`, which has the verb "Set" and the noun "Location." This cmdlet sets or changes the current working directory within the PowerShell environment.

Microsoft has a list of approved verbs for use with cmdlets to maintain consistency and clarity across the PowerShell ecosystem. You can view the list of approved verbs by running the Get-Verb cmdlet or referring to the Microsoft documentation.

[Approved Verbs MS Doc](https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.3) or run the PowerShell cmdlet `Get-Verb`

To use a cmdlet you call it by name.  For example, if I run the cmdlet `Get-Service`, I will get a listing of all services on my system.

Here are a few more examples of common cmdlets and their verb-noun structures:

`Get-ChildItem` Retrieves a list of child items (such as files and directories) from a specified location.

`New-Item` Creates a new item, such as a file, directory, or registry key.

`Remove-Item` Deletes an item, like a file, directory, or registry key.

`Import-Csv` Imports data from a CSV file into PowerShell as objects.

### Parameters

cmdlets are almost always used in combination with parameters.

Each cmdlet may have unique parameters.  Although in PowerShell parameters are often predictable.

Some common parameters you will see are `-Filter`, `-Name`, `-Path`, `-Recurse`

cmdlets typically accept parameters that provide additional information, control behavior, or define input/output data

Parameters can be positional or named.  For example, the first positional parameter for `Get-Process` is `Name`.  

So this is valid: `Get-Process "ccmexec"`

The exact same parameter also has a name: `Name`

And we can call parameters by specifying the parameter name followed by the value we are supplying.

For example:

`Get-Process -Name "ccmexec"`

Here, rather than specifying the parameter positionally, I did it by name.  Which in this case was Name.

Here's another parameter Get-Process supports -  `Id`

`Get-Process -Id 123`

That will return the process with process id 123

To know whether a parameter is positional you need to consult the help.  Or check the MS docs online.

What's important is know that you can always specify a parameter by name.  Don't worry if it's positional if you know the name
of the parameter.

Multiple parameters can be used at the same time on one cmdlet

For example:

`Get-ChildItem -Path "C:\Users\ExampleUser\Documents" -Filter "*.txt" -Exclude "*backup*"`

- `Path` specifies the directory to search for files.
- `Filter` sets the search pattern to only include files with the .txt extension.
- `Exclude` sets a pattern to exclude files with the word "backup" in their names.

### Pipeline

cmdlets can be chained together using something called Pipelining.

Use Pipelining to pass the output of the first command (ex: `Get-Process`) as input to the second command (ex: `Stop-Process`) and so on.

`Get-Process -Name "notepad" | Stop-Process`

This will terminate all instances of the notepad process

Notice the `|` character.  That is piping from one cmdlet to another.

Here is another example of using the pipeline to send output of the first cmdlet to the second cmdlet

`Get-ChildItem -Path "C:\Users\username\Documents" -Recurse | Where-Object { $_.Extension -eq ".txt" }`

The first thing that happens is `Get-ChildItem -Path "C:\Users\username\Documents" -Recurse` which gets all files and folders under C:\Users\username\Documents. 

That data is then sent to `Where-Object` as input.  

`Where-Object` applies a filter to the input which is 'where the file extension equals .txt

The result is we get a list of all .txt files in the folder C:\Users\username\Documents and all subfolder (because `-Recurse` parameter was used)

### Summary

1. Naming convention: Cmdlets use a verb-noun naming pattern, where the verb describes the action and the noun describes the resource being acted upon. For example, `Get-Service` retrieves a list of services, while `Start-Service` starts a specified service.

2. Discoverability: You can use the `Get-Command` cmdlet to discover available cmdlets in PowerShell. For example, `Get-Command -Verb Get` will list all cmdlets that start with the verb "Get."

3. Parameters: Cmdlets often accept parameters to customize their behavior or specify input data. Parameters can be positional, which means you can supply them in a specific order without specifying the parameter name, or named, which requires you to specify the parameter name followed by its value. For example, `Get-ChildItem -Path C:\ -Recurse` specifies the `-Path` and `-Recurse` parameters.

4. Pipelining: PowerShell cmdlets can be combined using the pipeline (`|`). Pipelining allows you to pass the output of one cmdlet as input to another cmdlet, enabling you to build more complex operations. For example, `Get-Process | Where-Object { $_.CPU -gt 10 }` retrieves a list of processes and filters them based on CPU usage.

5. Help: Each cmdlet comes with built-in help documentation, which you can access using the `Get-Help` cmdlet. For example, `Get-Help Get-Service` provides detailed information about the `Get-Service` cmdlet, including its parameters, examples, and more.

6. Aliases: Cmdlets can have aliases, which are alternative, shorter names that you can use to call the cmdlet. For example, `gci` is an alias for `Get-ChildItem`. You can discover aliases using the `Get-Alias` cmdlet.
