# Functions

Creating functions in PowerShell is an essential skill, as they allow you to reuse code and simplify complex tasks. Functions are self-contained blocks of code that can be called by a name, accept input parameters, and return output.

Defining a function is simple.  Use the keywoard `function` followed by the name of the function (whatever you want)
```
function Function-Name {
    # Code to execute
}
```
Let's create the simplest of all functions.  You call it and it returns a value.
```
function Return-Five {
    return 5
}
```

To call a function we type it's name:

`Return-Five`

Output
```
5
```
Functions are much more powerful than the above.  To really unlock the power of functions we need to pass values into the function using parameters.  Functions are like little factories that do work.  Functions can be simple, or complex.  It depends on the task the function is performing.  Most of the time, we need the function to perform calculations on some values we supply.  That is what input parameters are for.  Functions can have no parameters, or 10.  Again, it will depend on the purpose of the function.  

### Parameters

Here is how a parameter is declared when defining a function
```
function Function-Name {
    param(
        [ParameterType] $ParameterName
    )
    # Code to execute
}
```
Let make a function that we supply a string as input, and it will return the string to us, but in all uppercase letters.

To see what this looks like in Powershell ISE with calling the function included:
```
function Convert-ToUpperCase {
    param(
        [string] $stringValue
    )
    return $stringValue.ToUpper()
}

Convert-ToUpperCase -stringValue "convert this text"
```
Output in the console
```
CONVERT THIS TEXT
```
In the above we defined a new function named `Convert-ToUpperCase` and defined that it takes one parameter, `$stringValue`.  When we go to use the function the parameter name will be the parameter name we defined without the dollar sign.  We defined the parameter as `$stringValue` but to use it is `-stringValue`.

### Returning values

Notice in the functions the use of the keyword `return`.  Functions typically hand back a value to the caller.  In the above function, we supplied an input value, and the function took that value, converted it to upper case, and returned it to where it was called.

For example, if I do this: 

`$result = Convert-ToUpperCase -stringValue "this text was lower case"`

`Convert-ToUpperCase` function takes our input string `"this text was lower case"` and returns the upper case version.  This 'return' is stored in the variable `$result`.  If we want to see what the function returned to `$result`, just type `$result` or run `Write-Host $result`

As stated earlier, functions can be defined to take multiple parameters
```
function Add-Numbers {
    param(
        [int] $Number1,
        [int] $Number2,
        [int] $Number3
    )
    return $Number1 + $Number2 + $Number3
}
$result = Add-Numbers -Number1 3 -Number2 5 -Number3 7
Write-Host "The sum is: $result"

```
### Advanced Function Concepts

The CmdletBinding attribute is used in PowerShell to convert a simple function into an advanced function, providing several advantages and features that are not available in basic functions.
```
function My-AdvancedFunction {
    [CmdletBinding()]
    param(
        # Your parameters here
    )
    # Your function code here
}
```
#### Reasons to use CmdletBinding include

- Consistent behavior with built-in cmdlets: Advanced functions behave similarly to built-in PowerShell cmdlets, providing a more consistent experience for users.

- Common parameters: Advanced functions automatically get access to common parameters such as -Verbose, -Debug, -ErrorAction, -ErrorVariable, -WarningAction, -WarningVariable, -InformationAction, -InformationVariable, and -WhatIf. These parameters provide better control over the function's behavior and output.

- Parameter validation: You can use parameter validation attributes (like [ValidateNotNull()], [ValidateRange()], [ValidateScript()], etc.) with advanced functions to ensure that the input parameters meet specific criteria before the function processes them.

- Default parameter values: With advanced functions, you can set default values for parameters using the $PSDefaultParameterValues preference variable.

- Pipeline input: Advanced functions allow you to accept input from the pipeline using the ValueFromPipeline and ValueFromPipelineByPropertyName parameter attributes.

- Supports should process: Advanced functions can use the ShouldProcess functionality, which allows for the automatic generation of -WhatIf and -Confirm switches to help users understand what the function will change before it executes.

#### Parameter Validation

Parameter validation is a way to ensure that the input parameters for a function meet specific criteria before the function processes them. Validation attributes can be added to function parameters to enforce certain constraints or conditions on the input data. Some commonly used validation attributes in PowerShell are:

- [ValidateNotNull()] - Ensures the parameter value is not null.

- [ValidateNotNullOrEmpty()] - Ensures the parameter value is not null or an empty string.

- [ValidateRange()] - Ensures the parameter value falls within a specific numeric range.

- [ValidateScript()] - Validates the parameter value using a custom script block.

- [ValidateSet()] - Ensures the parameter value is one of a predefined set of values.

- [ValidatePattern()] - Validates the parameter value against a regular expression pattern.

Here is an example of validating parameter input:
```
function Test-Range {
    param(
        [ValidateRange(1, 10)]
        [int]$Number
    )

    Write-Output "Number is within the range: $Number"
}
```
#### Default Parameter Values

Default parameter values are used when a user does not provide a value for a specific parameter. By setting default values for parameters, you can make your functions more user-friendly and reduce the chance of errors caused by missing input.

To set a default value for a parameter, assign it using the = operator in the param() block:
```
function Test-DefaultValue {
    param(
        [string]$Greeting = "Hello, World!"
    )

    Write-Output $Greeting
}

Test-DefaultValue # This will output Hello, World!

Test-DefaultValue -Greeting "Greetings from the Moon!" # This will output Greetings from the Moon!
```
Even though `Test-DefaultValue` takes a parameter `-Greeting`, by assigning a default value to the parameter, if the caller does not specify the parameter, the default parameter will be used.  But, if the `-Greeting` parameter is used when calling the function, that value will be used, not the default value.

Output
```
Hello, World!
Greetings from the Moon!
```
### Pipelining

To use pipelining with functions you create in PowerShell, you need to design your functions to accept input from the pipeline by using the `ValueFromPipeline` and/or `ValueFromPipelineByPropertyName` attributes in the param() block. Here's a brief overview of these attributes:

`ValueFromPipeline` Indicates that the parameter can accept input directly from the pipeline.

`ValueFromPipelineByPropertyName` Indicates that the parameter can accept input from the pipeline based on a property name match.

In this example, we have a simple function called Get-StringLength that accepts a string input and outputs its length. The ValueFromPipeline = $true attribute in the param() block indicates that the $InputString parameter can accept input directly from the pipeline.
```
function Get-StringLength {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string]$InputString
    )

    process {
        Write-Output "Length of $InputString is $($InputString.Length)"
    }
}
"Five" | Get-StringLength
```
Output
```
Length of Five is 4
```
