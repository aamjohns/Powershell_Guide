# Objects

In PowerShell, an object is an instance of a class, which encapsulates data and behavior. An object represents a real-world entity or an abstract concept, making it easy to manipulate and perform operations on complex data. Objects have properties and methods that define their attributes and behaviors, respectively.

In the context of PowerShell, objects are an essential aspect of the language because they allow you to work with structured data and perform complex operations more efficiently. PowerShell is built on the .NET framework, and as such, almost everything in PowerShell is an object, including variables, cmdlet outputs, and even literals like strings and numbers. This object-oriented nature of PowerShell makes it a powerful and versatile scripting language.

For example, when you use the `Get-Process` cmdlet to retrieve a list of running processes, each process is represented as an object with properties like `ProcessName`, `Id`, `CPU`, etc., and methods like `Kill()`, `WaitForExit()`, etc. These objects enable you to easily access and manipulate process information, filter and sort the processes, and perform various operations on them using cmdlets and built-in methods.

### Properties and Methods

Properties are the attributes or characteristics of an object. They store data associated with an object. For example, a file object has properties like Name, Size, and LastWriteTime.
Methods are the actions that an object can perform. They are functions associated with an object that you can call to manipulate the object or perform some operation. For example, a file object might have methods like Delete, Copy, and Move.

To access a property of an object, use the (.) notation:  `$object.PropertyName`.

To call a method on an object, use the (.) notation: `$object.Method()`

To filter and select properties use `Where-Object` and `Select-Object` cmdlets.

To sort objects by property value use the `Sort-Object` cmdlet.

### Creating custom objects

I sometimes want to store and retrieve certain data, usually about multiple object, and one way to accomplish this is create an ArrayList of custom objects.  

Here is an example of creating a custom object:
```
$person = New-Object -TypeName PSObject -Property @{
    FirstName = "John"
    LastName = "Doe"
    Age = 30
}
```
We can now access the three properties we created for $person.
```
$person.FirstName
$person.LastName
$person.Age
```
Above I mentioned storing multiple objects.  To me that is where the real usefulness of custom objects comes into play. 

Here's a script that demonstrates creating multiple custom objects and storing them all as a collection.
```
# Create an ArrayList
$customObjects = New-Object System.Collections.ArrayList

for ($i = 1; $i -le 5; $i++) {
    # Create a custom object using a hashtable with properties and values
    $customObject = New-Object -TypeName PSObject -Property @{
        ID       = $i
        Name     = "Object $i"
    }

    # Add the custom object to the ArrayList
    $customObjects.Add($customObject) | Out-Null
}

# Display the contents of the ArrayList
$customObjects
```
Output
```
ID Name    
-- ----    
 1 Object 1
 2 Object 2
 3 Object 3
 4 Object 4
 5 Object 5
 ```
 Here is a list of reasons why you might want to employ using custom objects.  I mostly use them for combining data from multiple sources and for exporting directly to Excel (using the ImportExcel module and the Export-Excel cmdlet).
 
- Consolidating data from multiple sources: Custom objects allow you to combine data from different cmdlets or data sources into a single, unified object for easier processing and reporting.

- Formatting output: When you want to display specific pieces of information in a particular format, custom objects can help you achieve the desired output by defining custom properties and organizing the data as required.

- Data manipulation: Custom objects can be useful when you need to manipulate or transform data before using it in further processing or exporting it. You can add, remove, or modify properties as needed.

- Grouping related data: Custom objects can be used to represent complex data structures or entities that consist of multiple related properties, making it easier to work with the data as a single unit.

- Creating reusable functions: When writing advanced functions or scripts, custom objects can help you create more flexible and reusable code by defining custom data types that can be passed between functions.

- Creating custom reports: Custom objects are useful for generating custom reports by defining properties that represent the desired columns and formatting the output as needed.
 
