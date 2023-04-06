# Looping Structures

### for

Looping structures (for, foreach, do-while, while) allow you to execute a block of code multiple times based on certain conditions

`for` The for loop is used when you want to execute a block of code a specific number of times. It consists of an initialization, a condition, and an increment/decrement.

I don't typically use this particular type of for loop.  I usually iterate through the entire collection.  This type of for loop is when you want to control how many times you execute the loop.

Here's an example of using for to control the number of times a block of code is executed
```
for ($i = 0; $i -lt 5; $i++) {
    Write-Host "Iteration number: $i"
}
```
Output
```
Iteration number: 0
Iteration number: 1
Iteration number: 2
Iteration number: 3
Iteration number: 4
```
The above for statement says 'start counting from 0'; perform this code block while this statement is true ($i -lt 5), and increment the counter ($i) by 1 each time through.

### foreach

In my opinion, `foreach` is the most commonly used looping structure.  The foreach loop is used to iterate over a collection of items, such as an array or a list, executing a block of code for each item in the collection.

In this example we are going to use a ArrayList.  An ArrayList is a dynamic array in PowerShell, which means you can store items of any data type, and it can grow or shrink in size as needed. It's part of the .NET Framework.

To create a new ArrayList:

`$arrayList = New-Object System.Collections.ArrayList`

Now to add items to the ArrayList

`$arrayList.Add(42)`

Notice when we run the add we get a return value 0.  That's normal.  But if we don't want a 0 return, add the [void] type to the variable.

`[void]$arrayList.Add(42)`

Let's make sure our ArrayList has 42 in it now

`Write-Host $arrayList`

The output is 42

What if we need to store a list of values?  That what this variable type is for.  We use the `Add()` method to add items to the ArrayList.  And there is a `Remove()` method we can use to remove items from the ArrayList.

Let's add another number to `$arrayList`

`[void]$arrayList.Add(54)`

Now if we run

`Write-Host $arrayList`

The output should be: 42 54

That's great.  But that's not how we intended to work with the data.  We want to go through one item at a time.  That is where `foreach` comes in.
```
foreach($number in $arrayList)
{
    Write-Host "The number is $number"
}
```
Output
```
The number is 42
The number is 54
```
In the above we use the `foreach` statement followed `(` and then a $variable which is a temporary variable that holds the current item from the collection during each iteration. You can choose any name for this variable. Next is the word `in` and then the varaible that holds the collection or list we want to go through, followed by `)`


### while

`While` The while loop is used to execute a block of code as long as a specified condition is true. If the condition is false from the beginning, the code block will not execute at all.

For example:
```
$counter = 0
while ($counter -lt 5) {
    Write-Host "Counter value: $counter"
    $counter++
}
```
The $counter variable starts at 0 and the while conditions is true while $counter is less that 5.  Each time the code block executes, the value of the $counter variable gets increased by 1.

Output
```
Counter value: 0
Counter value: 1
Counter value: 2
Counter value: 3
Counter value: 4
```
### do-while

`do-while` and `do-until` The do-while loop executes a block of code at least once and then continues to execute it as long as the specified condition is true. The do-until loop, on the other hand, executes the block of code until the specified condition becomes true.

For example:
```
$counter = 0
do {
    Write-Host "Counter value: $counter"
    $counter++
} while ($counter -lt 5)

$counter = 0
do {
    Write-Host "Counter value: $counter"
    $counter++
} until ($counter -eq 5)
```


