# Data Types

Data types are classifications of data that determine the kind of values that can be stored, manipulated, and processed in PowerShell.

It is good to know about and understand data types... but powershell typically does not require explicit data types. Powershell is a dynamic type language.  `$myString = "Hello World"` is fine.  You don't have to say `[string]$myString = "Hello World"`.  You would normally only need to do things like this if you need to explicitly change a variables data type or you are using something that requires a particular data type.

The following is a list of common data types in PowerShell

- String: A sequence of characters, used to represent text.

- Integer: Whole numbers, both positive and negative.

- Double: Floating-point numbers, used to represent real numbers with decimal points.

- Boolean: Represents true or false values.

- DateTime: Represents dates and times.

- Array: A collection of elements of the same data type, indexed by a number.

- Hashtable: A collection of key-value pairs, where each key is unique.

You can cast a variable's type when you declare or assign it

`[type]$variableName` is the syntax.

Example:

`[double]$doubleValue = "0.005"`

If we use the `.GetType()` method on the variable above it should tell us it is of type double

`Write-Host $doubleValue.GetType()`

As expected, the output is the type we assigned: `System.Double` or double

Let's look at another reason we might care about data type

`$currentTime = Get-Date`

What data type is `$currentTime`?

`Write-Host $currentTime.GetType()`

We see from the output it is a datetime.  Why is that important to know?  When working with different data types, different properties and methods may become available.  Would you rather get the date into a variable, convert it to a string, format it, parse the string and replace a number, or use a method to accomplish the same thing i.e. `$currentTime.AddYears(3)`.  The `.AddYears()` method was avaialable because our data was of type datetime.  Each type of data you work with will have different methods and properties available to it.

When might you want to convert a datetime type to a string? You might want to convert it to a string, that is specifically formatted for input to a database that only accepts string input. For example:

`$dateTime = Get-Date`

`$formattedString = $dateTime.ToString("yyyy-MM-dd HH:mm:ss")`
The `.ToString()` method converts the datatime data type to a string data type and applies the specified formatting.

`Write-Host $formattedString`

This outputs the DateTime value in the format we wanted, as a string:
`2023-03-31 17:28:59`
