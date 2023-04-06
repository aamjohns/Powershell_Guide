<#
Numbers are a fundamental data type in PowerShell, as well as in most programming languages. 
There are several types of numeric data in PowerShell, including integers, floating-point numbers, and decimals.

Integers are whole numbers without a decimal point. They can be positive, negative, or zero. 
In PowerShell, you can declare an integer variable by simply assigning a whole number value:
#>
$positiveNumber = 42
$negativeNumber = -13
$zero = 0
<#
Floating-point numbers are numbers with a decimal point. 
They can represent fractional values, as well as very large or very small numbers. 
In PowerShell, you can declare a floating-point variable using the double data type:
#>
[double]$doubleNumber = 3.14159
<#
Decimal numbers are another type of numeric data that provides high precision and a 
larger number of significant digits compared to floating-point numbers. They are particularly 
useful when working with financial calculations or other situations that require high accuracy. 
In PowerShell, you can declare a decimal variable using the decimal data type:
#>
[decimal]$decimalValue = 12345.6789
<#
Numeric operators

Addition: +
Subtraction: -
Multiplication: *
Division: /
Modulus (remainder): %
#>
$number1 = 10
$number2 = 3

$sum = $number1 + $number2
$difference = $number1 - $number2
$product = $number1 * $number2
$quotient = $number1 / $number2
$remainder = $number1 % $number2

Write-Host "Sum: $sum"
Write-Host "Difference: $difference"
Write-Host "Product: $product"
Write-Host "Quotient: $quotient"
Write-Host "Remainder: $remainder"
