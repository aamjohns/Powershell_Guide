# Properties and Methods

### Properties

Properties are like attributes or characteristics of an object.

They store data about the object and can usually be read or modified directly.

Properties are accessed using the object's name, followed by a dot (.), and then the property name, e.g., `$object.PropertyName`.

In PowerShell, you can use `Get-Member -MemberType Properties` to list the properties of an object.

For example, a DateTime object has properties like Year, Month, and Day, which describe the specific date.

### Methods

Methods are actions or functions that an object can perform.

They are used to manipulate the object's state or perform operations related to the object.

Methods are invoked using the object's name, followed by a dot (.), the method name, and 
parentheses containing any required arguments, e.g., `$object.MethodName(arguments)`.

In PowerShell, you can use `Get-Member -MemberType Methods` to list the methods of an object.

For example, a DateTime object has methods like `AddDays()`, `AddMonths()`, and `ToString()`, which allow you to manipulate the date or convert it to a string.

### Summary

Properties represent the data or attributes of an object, while methods are actions or functions that the object can perform.
