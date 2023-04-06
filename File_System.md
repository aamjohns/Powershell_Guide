# File System

### Navigating the file system

You can use `cd` or `Set-Location` to change the current location.

To change the current working directory to "C:\Support" you can use:

`Set-Location -Path "C:\Support"`

To get the current working directory, use

`Get-Location`

### Working with Directories

- `New-Item` (with -ItemType Directory): Create a new directory.
- `Remove-Item` (with -Recurse -Force): Remove a directory and its contents.
- `Get-ChildItem` (alias: dir, ls): List contents of a directory.
- `Copy-Item` Copy a directory and its contents to a new location.

Start by creating a new folder

`New-Item -Path "C:\Support" -Name "Powershell_Demo" -ItemType "Directory"`

This creates a new folder at C:\Support called Powershell_Demo

Let's create a text file in the new directory

`New-Item -Path "C:\Support\Powershell_Demo" -Name "testfile1.txt" -ItemType "file" -Value "This is a text string."`

This will create a text file called testfile1 in the Powershell_Demo directory.  It will also write 'This is a text string' to the contents of the file.

Let's see that the file is there:

`Get-ChildItem -Path "C:\Support\Powershell_Demo" -Recurse`

Now let's say we want to delete the Powershell_Demo folder, and we want it to also delete any contents of the folder (Recurse).  Also, to recursively delete the contents we need to use the `-Force` paramater

`Remove-Item -Path "C:\Support\Powershell_Demo" -Recurse -Force`

Wait, the above didn't work.  According to the MS documentation, it should work.  Apparently, it does not work because there is a bug in Powershell.  To accomplish the deletion we need to first delete all files, and then we should be able to deleted the folder.
```
Get-ChildItem -Path "C:\Support\Powershell_Demo" -Recurse | Remove-Item -Force -Recurse
Remove-Item "C:\Support\Powershell_Demo" -Force
```
So again, it didn't work as expected.  The first line did indeed delete the file in the directory, but the second command did not work.  It still says the directory is in use.  I'll have to revisit this.  It is good to know not to assume recursive deletes to work as expected.

### Working with Files

Working with files:

- `New-Item` (with `-ItemType File`) Create a new file.
- `Remove-Item` Remove a file.
- `Copy-Item` Copy a file to a new location.
- `Move-Item` Move a file to a new location.
- `Rename-Item` Rename a file.

Here are examples of working with files (this assumes you have a C:\Support directory)
```
# Create a new text file
New-Item -Path "C:\Support\OriginalFile.txt" -ItemType File -Force

# Add some content to the text file
Set-Content -Path "C:\Support\OriginalFile.txt" -Value "This is a sample text file."

# Copy the text file to a new location
Copy-Item -Path "C:\Support\OriginalFile.txt" -Destination "C:\Support\CopiedFile.txt"

# Move the copied file to another location
Move-Item -Path "C:\Support\CopiedFile.txt" -Destination "C:\Support\MovedFile.txt"

# Rename the moved file
Rename-Item -Path "C:\Support\MovedFile.txt" -NewName "RenamedFile.txt"

# Delete the original and renamed files
Remove-Item -Path "C:\Support\OriginalFile.txt"
Remove-Item -Path "C:\Support\RenamedFile.txt"
```
