# Measure-Object

`Measure-Object` is a PowerShell cmdlet that is used to calculate various statistical properties of objects passed through the pipeline. It can calculate properties like the count of objects, sum, average, minimum, and maximum. This cmdlet is particularly helpful when you want to analyze and summarize data.

The synatx of Measure-Object:
```
Measure-Object [[-Property] <String[]>] [-InputObject <PSObject>] [-Average] [-Sum] [-Maximum] [-Minimum] [-Line] [-Word] [-Character] [-IgnoreCase] [<CommonParameters>]
```
- Property <String[]>: (Optional) Specifies the property to be measured.
- InputObject <PSObject>: (Optional) The input objects to process. This is typically not used when working with the pipeline.
- Average: Calculate the average of the specified property.
- Sum: Calculate the sum of the specified property.
- Maximum: Calculate the maximum value of the specified property.
- Minimum: Calculate the minimum value of the specified property.
- Line: Count the number of lines in the input objects.
- Word: Count the number of words in the input objects.
- Character: Count the number of characters in the input objects.
- IgnoreCase: Ignore case when counting characters, words, or lines.
  
Here's an example of using `Measure-Object` to calculate the count, sum, and average of a list of numbers:
```
$numbers = 10, 20, 30, 40, 50
$numbers | Measure-Object -Sum -Average -Maximum -Minimum  
```  
Output
```
Count    : 5
Average  : 30
Sum      : 150
Maximum  : 50
Minimum  : 10
Property :   
```
Another example would be to count the lines, words, and characters in a text file:
```
# Write the computer names to the text file
$computerNames = @("in-ota-192251", "in-ota-192234", "in-ota-230204")
$file = "C:\support\computers.txt"
$computerNames | Set-Content -Path $file  
Get-Content "C:\Support\Computers.txt" | Measure-Object -Line -Word -Character | Select-Object Lines, Words, Characters 
```
Output
```
Lines Words Characters
----- ----- ----------
    3     3         39        
```
### Measure-Command (not related to measure-object)
  
Measure-Command is a PowerShell cmdlet that allows you to measure the time it takes to run a script block or a command. This can be helpful when you want to determine the performance of your script or compare the execution time of different commands
  
In this example, we measure the time it takes to execute the `Get-Process` command. The `-Expression` parameter accepts a script block containing the command you want to measure. The output of `Measure-Command` is a `TimeSpan` object, which contains various properties such as `TotalMilliseconds`, `TotalSeconds`, and `TotalMinutes`, depending on the desired level of granularity.  
```  
$measure = Measure-Command -Expression {
    $sum = 0
    for ($i = 0; $i -lt 100000; $i++) {
        $sum += $i
    }
}
$measure.TotalMilliseconds
```
In this case, we measure the time it takes to calculate the sum of the numbers from 0 to 99,999 using a for loop.  
  
