# Reading and Writing Files

### Reading Files

`Get-Content` This cmdlet reads the content of a file and returns it as an array of strings, with each line in the file represented as a separate string.

For example. say you have a .txt file with a list of computers as the content.  One computer name per line.  We can read in that file, iterate over each computer name in the file, and write it out to the console

Bonus points... Let's use powershell to create the text file with computer names we need for the example on reading a file:
```
New-Item -Path "C:\Support\Computers.txt" -ItemType File -Force # Create a new txt file
Set-Content -Path "C:\Support\Computers.txt" -Value "IN-OTA-192251" # Write the first computer name to file
Add-Content -Path "C:\Support\Computers.txt" -Value "IN-OTA-192234" # Append the next computer name to the file
Add-Content -Path "C:\Support\Computers.txt" -Value "IN-OTA-230240" # Append the next computer name to the file

$fileContent = Get-Content -Path "C:\Support\Computers.txt" # This reads the content of the to an array of string
# Now output each line from the file to the console
foreach($line in $fileContent)
{
  Write-Host $line # This output the line from the file to the console
}
```
`ReadAllText` This method reads the entire content of a file into a single string.

`Get-Content` reads a file line by line.  It returns an array of lines.  `ReadAllText` reads the entire file into one line.

This example reads the file, and writes the file out to the console
```
$fileContent = [System.IO.File]::ReadAllText("C:\Support\Computers.txt")
Write-Host $fileContent
```
Notice something different about the above `[System.IO.File]::ReadAllText`?  What is this?  We are calling on a method from a .Net namespace.  Powershell can use .Net framework.  The .Net namespace `System.IO` has a `File` class, which has a static method called `ReadAllText`.  Keep in mind you can and probably will be leveraging the .Net framework in your scripts.

### Writing Files

`Set-Content` This cmdlet writes or overwrites the content of a file with the specified data.
```
New-Item -Path "C:\Support\SampleFile.txt" -ItemType File -Force # Create a new txt file
$textContent = "This is a sample text."
Set-Content -Path "C:\Support\SampleFile.txt" -Value $textContent
```
The above writes the specified line of text to the existing file SampleFile.txt

Adding text to an existing file is called appending.  We can use `Add-Content` to append text to the file.
```
$additionalText = "This is additional text."
Add-Content -Path "C:\Support\SampleFile.txt" -Value $additionalText
```
Let's check our work so far.  If we output the contents of SampleFile.txt, we should see the two lines of text we wrote and appended.
```
$fileContent = Get-Content -Path "C:\Support\SampleFile.txt"
Write-Host $fileContent
```
Output
```
This is a sample text. This is additional text.
```
That looks like one string of text.  But Get-Content should return an array of string.  Let's make sure that's what we have.  I'm going to use something new here `ForEach-Object`.  This is another way to do a foreach loop but this way you do it on the pipeline.  For example:
```
$fileContent | ForEach-Object { Write-Host $_ }
```
This time we see that each line of text is indeed a separate line

The basic syntax for ForEach-Object is `<Collection> | ForEach-Object { <ScriptBlock> }`

`<Collection>` is the input data, usually coming from another cmdlet or a variable.
`<ScriptBlock>` is a block of code enclosed in curly braces `{}` that will be executed for each item in the collection. Inside the script block, you can use the automatic variable `$_` to represent the current item being processed.

Let's look at another ForEach-Object example:
```
$numbers = 1..5
$numbers | ForEach-Object { $_ * 2 }
```

Keep in mind, Write-Host is not necessary to see the output.  What do you think the output of the above will be?
```
2
4
6
8
10
```
`WriteAllText` This method writes the specified text to a file, overwriting any existing content.
```
$textContent = "This is a sample text. It might be long, like a book"
[System.IO.File]::WriteAllText("C:\Support\SampleFile.txt", $textContent)
```
One again we have called upon the .Net framework to supply us with the method to write all text out to a file. Sitting here thinking about this, I'm not sure why you couldn't just use the native powershell method Set-Content for the same purpose as WriteAllText :)
