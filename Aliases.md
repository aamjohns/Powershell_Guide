# Aliases

While aliases can be helpful for typing commands quickly and bridging the gap between different command-line environments, they can also make scripts less readable for users who are unfamiliar with the specific aliases. When writing scripts that will be shared with others or used in a production environment, it's generally best to use the full cmdlet names for clarity and maintainability.

With that said (and I personally almost never use aliases), here is an overview of aliases in Powershell

Aliases are short, alternative names for cmdlets, functions, or scripts. They are designed to save time and make it easier for users familiar with other scripting languages or command-line environments to use PowerShell more efficiently. Aliases are particularly useful for commonly used cmdlets, as they provide a shorthand way to execute them without typing the full cmdlet name.

For example:

`Get-ChildItem -Path "C:\Support"`

can be stated using an alias `gci`

`gci "C:\Support"`

PowerShell comes with several built-in aliases for common cmdlets. These aliases are designed to make PowerShell more accessible to users familiar with other command-line environments, such as Unix-like shells or the Windows Command Prompt. Some examples of built-in aliases include:

`dir` or `gci` for `Get-ChildItem`

`cd` for `Set-Location`

`cls` for `Clear-Host`

`del` for `Remove-Item`

`echo` for `Write-Output`

`ls` for `Get-ChildItem` (similar to Unix-like shells)

When working with the console I use cd, cls, and ls all the time.  In scripts, I do not use those aliases at all.  

In script I typically use the full cmdlet name and I typically name all of the parameters I am using when writing scripts.

Using aliases can make the code less readable for others.

You can also make your own aliases.  That's not something I will go into but just know you can.

