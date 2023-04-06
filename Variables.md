# Variables

Variables in PowerShell are used to store and manipulate data. They can hold different types of data, such as strings, numbers, arrays, and objects.

Variable names start with a $ and can be any text characters you want after the $.  Variables should be properly cased (discussed below) and named in such a way as to convey meaning regarding the value it holds.  For example, let's say we are going to read the contents of a book from a file into a variable.  What should we name the variable?  How about $bookContents?  Or even $book.  It doesn't matter, just pick something that makes sense when you look at it later.

`$newFile`

Above we created a new variable called $newFile

Normally when we create the variable, we also assign it a value

Use the = sign to assign a value to a variable

`$newFile = "C:\Support\DemoFile.txt"`

Now we have a variable called $newFile and it stores the string we specified "C:\Support\DemoFile.txt"

What if we want to verify what $newFile's value is? We can output the value to the console using Write-Host

`Write-Host "The value stored in the variable is: $newFile"`

In the console we get the output 'The value stored in the variable is: C:\Support\DemoFile.txt'

Variables can store different types of data.  *Note* Powershell is a dynamically typed language which means that the interpreter automatically infers the data type of a variable based on the value it holds, without the need for explicit type declarations or casting.

It could be a string like "Hello World"

`$stringValue = "Hello World"`

Or it could be an Array like:

`$newArray = 1,2,3,4,5`

It could store a collection of objects like:

`$processes = Get-Process`

Or it could store a single object

`$process = Get-Process -Id 10196`

What if you want to know the type of a variable?  Use the `.GetType()` method.  How do you use this method? Take your variable and append `.GetType()` to it.
So in the case of a variable called `$newFile` it would be `$newFile.GetType()`.  To output this value to your console you type `$newFile.GetType()` and hit enter.  Run that from the console, or the ISE.  Just remember to first run `$newFile = "C:\Support\test.txt"` so it has a value!  You can also output to the console using Write-Host.

`Write-Host $newFile.GetType()`

BTW - the output of the above is `System.String`.  That is to be expected.  We put a string in "C:\Support\test.txt" and Powershell dynamically typed the variable for us.

#### Casing

Another thing to know when you are creating new variable names (or fuctions) is choosing a casing
style and stick with it throughout your script.  Be consistent.

There are two types of casing typically used when naming variable or functions:

1) PascalCase: In PascalCase, the first letter of each word in a variable name is capitalized, and there 
are no underscores between words. This casing style is commonly used for cmdlet names, functions, 
and module names in PowerShell, as well as for variable names

Example of PascalCase ($StartTime)

`$StartTime = Get-Date`

2) camelCase: In camelCase, the first letter of the first word in a variable name is lowercase, 
while the first letter of each subsequent word is capitalized. There are no underscores between words. 
This casing style is often used for variable names in PowerShell scripts, particularly when following programming 
conventions from other languages like C or JavaScript.

Example of camelCase ($startTime)

`$startTime = Get-Date`

How you use case is up to you.  It is recommended that you stay consistent whatever you choose

I tend to use PascalCase for function names, and camelCase for variable names

#### Defining the type of variable

Sometimes you may want to make sure your variable is a specific type

Do this by using [type] syntax before the variable name.  For example

To declare the variable type as string use:

`[string]$myString = "Hello World"`

Here's another example of declaring a type (ArrayList)

`[System.Collections.ArrayList]$arrListComputers`

#### Summary

Variables are a symbolic name or placeholder that is used to store and manipulate data.  Variable names should convey meaning and adhere to some form of casing.  Variables can be assigned types, but normally this is not necessary, as Powershell is dynamically typed. Variable are accessed by referencing their name.  
