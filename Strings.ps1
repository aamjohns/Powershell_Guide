<#
Strings
A string is a sequence of characters enclosed in single or double quotes. In PowerShell, both single and double quotes are used to define a string.
In PowerShell, you can use both single quotes (') and double quotes (") to define a string, but they behave differently:
Single quotes ('): Use single quotes when you want to define a string without variable or expression interpolation. 
Everything inside single quotes is treated as a literal string, and no variable substitution or escape sequences are processed.
#>
$name = 'John'
$singleQuoteString = 'My name is $name.'
Write-Host $singleQuoteString # Output: My name is $name.
<#
Double quotes ("): Use double quotes when you want to define a string with variable or expression interpolation. 
PowerShell processes variables and escape sequences inside double quotes.
#>
$name = "John"
$doubleQuoteString = "My name is $name."
Write-Host $doubleQuoteString # Output: My name is John.
<#
In summary, use single quotes when you want a literal string without any variable substitution or escape sequence processing, 
and use double quotes when you want to include variables or expressions within the string.
The difference between single quotes and double quotes is important to remember.

Concatenation: You can concatenate strings using the + operator or by simply placing them side by side.
#>
$string1 = "Hello"
$string2 = "World"
$result = $string1 + ", " + $string2
Write-Host $result
<#
String interpolation: You can insert the value of a variable or an expression into a string using double quotes and subexpressions.
#>
$name = "John"
$age = 30
$output = "My name is $name, and I am $age years old."
Write-Host $output
<#
Escape characters: Use the backtick (`) as the escape character in PowerShell strings.
#>
$stringWithQuote = "This is a `"quote`" inside a string."
Write-Host $stringWithQuote
<#
Here-string: A here-string is a multiline string that starts with @" and ends with "@. It can span multiple lines and preserve whitespace and newlines.
#>
$hereString = @"
This is a
multiline
string.
"@
Write-Host $hereString
<#
Common string operations:

Length: $string.Length - Returns the number of characters in the string.
Substring: $string.Substring(startIndex, length) - Extracts a substring from the original string, starting at the specified index and with the specified length.
Replace: $string.Replace("oldValue", "newValue") - Replaces all occurrences of a specified substring with another substring.
Split: $string.Split("delimiter") - Splits a string into an array of substrings based on a specified delimiter.
Join: [string]::Join("delimiter", $arrayOfString) - Joins an array of strings into a single string, with an optional delimiter.
ToUpper: $string.ToUpper() - converts string to all uppercase characters
ToLower: $string.ToLower() - converts string to all lowercase characters
Trim: $string.Trim() - Removes whitespace characters from the beginning and end of a string.
IndexOf: $string.IndexOf("substring") - Returns the index of the first occurrence of the specified character or substring within the string. If the value is not found, it returns -1.
LastIndexOf: $string.LastIndexOf("substring") - Returns the index of the last occurrence of the specified character or substring within the string. If the value is not found, it returns -1
StartsWith: $string.StartsWith("substring") - Determines whether the string begins with the specified character or substring, returning a boolean value
EndsWith: $string.EndsWith("substring") - Determines whether the string ends with the specified character or substring, returning a boolean value

For example, let's get the length (number of characters) in the $hereString
#>
$string = "Hello, World!"
$length = $string.Length # Output: 13
Write-Host "Length = $length" 

$string1 = "Hello, "
$string2 = "World!"
$result = $string1 + $string2 # Output: "Hello, World!"
Write-Host "Concatenate two string = $result"

$string = "Hello, World!"
$substring = $string.Substring(0, 5) # Output: "Hello"
Write-Host "The substring is = $substring"

$string = "Hello, World!"
$replaced = $string.Replace("World", "PowerShell") # Output: "Hello, PowerShell!"
Write-Host "Replaced text = $replaced"

$string = "one,two,three"
$split = $string.Split(",") # Output: @("one", "two", "three")
Write-Host "Here are the split out items = $($split[0]) $($split[1]) $($split[2])"

$array = @("one", "two", "three")
$joined = -join $array # Output: "onetwothree"
Write-Host "Elements of the array joined are = $joined"

$string = "  Hello, World!  "
$trimmed = $string.Trim() # Output: "Hello, World!"
Write-Host $trimmed

$string = "Hello, World!"
$upper = $string.ToUpper() # Output: "HELLO, WORLD!"
$lower = $string.ToLower() # Output: "hello, world!"
Write-Host "To upper = $upper and to lower = $lower"




