# Filtering and Manipulating Objects

There are cmdlets available that allow filtering, selecting, sorting, comparing, and grouping objects.  

### Where-Object

`Where-Object` filter objects based on specific criteria.

For example:
```
Get-Process | Where-Object { $_.WorkingSet64 -gt 20MB } 
 ```
The entire command `Get-Process | Where-Object { $_.WorkingSet64 -gt 20MB }` retrieves the list of running processes and filters them to return only the processes with a working set size greater than 20MB.
 
Let's break it down:
- `Get-Process`: This cmdlet retrieves the list of processes running on the local computer or a remote computer. It returns a collection of `System.Diagnostics.Process` objects, each representing a process.

- `|` (Pipeline): The pipeline | is used to pass the output of one cmdlet to another cmdlet for further processing. In this case, the output of Get-Process (the list of processes) is passed to the Where-Object cmdlet.

- `Where-Object` This cmdlet is used to filter objects based on specific criteria. It takes the input from the pipeline, processes it using the script block provided, and returns only the objects that meet the specified condition.

`{ $_.WorkingSet64 -gt 20MB }`: This is the script block provided to the `Where-Object` cmdlet

Inside the script block we have:

`$_` This is an automatic variable that represents the current object being processed in the pipeline. In this case, it represents a single `System.Diagnostics.Process` object.

`.WorkingSet64` This is a property of the `System.Diagnostics.Process` object that represents the amount of physical memory (in bytes) allocated for the process.

`-gt` This is a comparison operator that stands for "greater than". It is used to compare two values.

`20MB` This represents 20 megabytes of memory. PowerShell allows you to use suffixes like KB, MB, and GB to specify the memory size in a more human-readable way.

The script block `{ $_.WorkingSet64 -gt 20MB }` checks if the WorkingSet64 property of the current process object (`$_`) is greater than 20MB. If it is, the Where-Object cmdlet will return the process object as part of its output.

### Select-Object

`Select-Object` is a PowerShell cmdlet that allows you to select specific properties from input objects or modify the objects themselves. It is commonly used in conjunction with other cmdlets in a pipeline to extract specific information or create new objects with a particular set of properties.

If you only need certain properties from input objects, you can use Select-Object to extract them. For example, if you have a list of processes from the Get-Process cmdlet and only want their ProcessName and Id properties, you can use the following command:
```
Get-Process | Select-Object -Property ProcessName, Id
```
You can use `Select-Object` to create new properties based on existing ones or by performing calculations. You define these calculated properties using a hashtable with the keys Name (new property name) and Expression (script block to calculate the property value). For example, to add a MemoryInMB property to the process objects, you can use:
```
Get-Process | Select-Object -Property ProcessName, Id, @{
    Name = 'MemoryInMB'
    Expression = { $_.WorkingSet64 / 1MB }
}
```
You can use `Select-Object` to limit the number of objects returned from the pipeline. For example, to get the top 5 processes with the highest working set size, you can use:
```
Get-Process | Sort-Object -Property WorkingSet64 -Descending | Select-Object -First 5
```
### Sort-Object

`Sort-Object` is a PowerShell cmdlet that sorts input objects by one or more properties. It enables you to organize your data in ascending or descending order based on the specified property or properties. `Sort-Object` is often used in combination with other cmdlets as part of a pipeline to process and analyze data more effectively.

To sort objects by a specific property, you can pass the property name to the `-Property` parameter. For example, to sort processes by their WorkingSet64 property (which represents memory usage), you can use the following command:
```
Get-Process | Sort-Object -Property WorkingSet64
```
Notice from the output, the default sort order is Ascending.  In this case, WS should be in ascending order.

To sort in Descending order use:
```
Get-Process | Sort-Object -Property WorkingSet64 -Descending
```
You can sort input objects by multiple properties by providing a comma-separated list of property names to the -Property parameter. For example, to sort processes first by their CompanyName and then by ProcessName, you can use:
```
Get-Process | Sort-Object -Property CompanyName, ProcessName
```
### Group-Object

`Group-Object` is a PowerShell cmdlet that groups input objects based on the value of a specified property or properties. It can be used to count or organize objects that share a common attribute, making it easier to analyze and understand the data. `Group-Object` is often used in combination with other cmdlets as part of a pipeline to process and analyze data more effectively

To group objects by a specific property, you can pass the property name to the `-Property` parameter. For example, to group files in a directory by their extension, you can use the following command:
```
Get-ChildItem "C:\Windows"| Group-Object -Property Extension
```
Output sample:
```
Count Name                      Group                                                                                                                                                                                                          
----- ----                      -----                                                                                                                                                                                                          
   98                           {addins, ADFS, appcompat, apppatch...}                                                                                                                                                                         
    2 .bak                      {ccm.bak, ccmsetup.bak}                                                                                                                                                                                        
    1 .NET                      {Microsoft.NET}                                                                                                                                                                                                
    1 .vbs                      {accache.vbs}                                                                                                                                                                                                  
    2 .txt                      {authtest.txt, xcopy_log.txt}                                                                                                                                                                                  
   19 .exe                      {bfsvc.exe, dchcfg32.exe, dchcfg64.exe, dcmdev64.exe...}                                                                                                                                                       
    2 .dat                      {bootstat.dat, msocreg32.dat}                                                                                                                                                                                  
   13 .INI                      {BRWMARK.INI, gpprefbr.INI, HPMProp.INI, ODBC.INI...}                                                                                                                                                          
   12 .log                      {cctk_install_log.log, comsetup.log, DDACLSys.log, DPINST.LOG...}                                                                                                                                              
    1 .config                   {DfsrAdmin.exe.config} 
```
This command will return a list of groups with each group representing a unique file extension, and a Count property indicating the number of files with that extension.

You can group input objects by multiple properties by providing a comma-separated list of property names to the `-Property` parameter. For example, to group processes first by their CompanyName and then by ProcessName, you can use:
```
Get-Process | Group-Object -Property CompanyName, ProcessName
```
If you need more control over the grouping criteria, you can use a script block to define a custom expression. For example, to group files by their size in kilobytes (rounded to the nearest 100), you can use:
```
Get-ChildItem "C:\Windows" | Group-Object -Property { [math]::Round($_.Length / 1KB, 2) }
```
Another example of using a script block with `Group-Object`
```
Get-Process | Group-Object -Property { $_.ProcessName.Substring(0, 1) }
```
The above code will group process objects by the first letter of the processname.

Output:
```
Count Name
----- ----
   12 A   
    3 b   
   44 c   
    9 d   
    2 E   
   14 F   
    4 G   
    7 I   
    3 j   
    2 L   
   37 M   
    3 N   
    8 O   
    7 P   
   18 R   
  113 S   
   11 t   
    3 U   
   10 v   
   16 W 
```
The command I actually ran to produce the above output was 
`Get-Process | Group-Object -Property { $_.ProcessName.Substring(0, 1) } | Select-Object Count,Name`
The reason being is the default output also included Group which was a long string and made it not fit here.  So I pipelined the output of the `Group-Object` to `Select-Object` where I then specified the properties I wanted in the output.

### Compare Object

`Compare-Object` is a PowerShell cmdlet that compares two sets of objects based on their property values. It can be used to identify similarities and differences between the objects in the two sets. It's useful for tasks such as comparing file contents, checking differences between configurations, or analyzing data.

The basic syntax of the `Compare-Object` cmdlet is:
```
Compare-Object -ReferenceObject <Object[]> -DifferenceObject <Object[]> [-Property <Object[]>] [-IncludeEqual] [-ExcludeDifferent] [-PassThru] [-CaseSensitive] [-Culture <String>]
```
- ReferenceObject <Object[]>: The first set of objects you want to compare.
- DifferenceObject <Object[]>: The second set of objects you want to compare.
- Property <Object[]>: (Optional) The properties to compare. If not specified, PowerShell compares the objects as a whole.
- IncludeEqual: (Optional) Includes objects in the output that are equal.
- ExcludeDifferent: (Optional) Excludes objects in the output that are different.
- PassThru: (Optional) Passes the objects that differ directly through the pipeline.
- CaseSensitive: (Optional) Indicates that the comparison should be case-sensitive.
- Culture <String>: (Optional) Specifies the culture to use for string comparisons.
 
The output of the `Compare-Object` cmdlet shows the differences between the objects, indicating which object the difference belongs to (either the reference object or the difference object). The output also includes a `SideIndicator` property, which shows whether the difference is in the reference object (`<=`) or the difference object (`=>`).

Here's a simple example comparing two arrays of strings:
```
$array1 = @("apple", "banana", "cherry")
$array2 = @("banana", "cherry", "date")

Compare-Object -ReferenceObject $array1 -DifferenceObject $array2
```
The output will show that "apple" is in the reference object, and "date" is in the difference object.
```
 InputObject SideIndicator
----------- -------------
date        =>           
apple       <=    
```
Here is an example of how to compare two files:
```
$Reference = Get-Content -Path ReferenceFile.txt
$Difference = Get-Content -Path DifferenceFile.txt
Compare-Object -ReferenceObject $Reference -DifferenceObject $Difference
```
### ForEach-Object
                 
`ForEach-Object` is a PowerShell cmdlet that allows you to iterate through a collection of objects and perform an action on each object. It is particularly useful when working with the PowerShell pipeline, as it can process objects as they are passed through the pipeline
                 
The most common way to use `ForEach-Object` is within a pipeline, using the $_ variable to represent the current object being processed. Here's an example:
```
 Get-ChildItem "C:\Windows" | ForEach-Object { $_.FullName }
```
This code retrieves the child items (files and folders) in the current directory using `Get-ChildItem` and then uses `ForEach-Object` to output the full path of each item. 
