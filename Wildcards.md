# Wildcards

Wildcards are special characters used to represent one or more characters in a string or file name

Wildcards are helpful when searching for files, filtering results, or matching patterns in strings.

There are two types of wilcards `*`, and `?`.

`*` (Asterisk): Represents zero or more characters. It is commonly used for searching files, directories, or filtering results.

`?` (Question mark): Represents a single character. It is useful when searching for files or directories with similar names but differing by only one character.

We will focus on `*` as it is the most commonly used

We know if we run `Get-Process` we will get back all running processes

What if we want to get a particular process?  Normally you type the name and, although Name is a positional parameter, we haven't gotten into that yet so for now let's uses this syntax to get a particular process

`Get-Process -Name "ccmexec"`

Here's the output from the command

Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName                                                                                                                                                                          
-------  ------    -----      -----     ------     --  -- -----------                                                                                                                                                                          
    1948      53    62800      74880     561.14   9024   0 CcmExec  
    
It gave us the output we expect, information about the ccmexec process.

What if you couldn't remember the process name but knew it had "ccm" in it?

Does this work?

`Get-Process -Name "*ccm*"`

Yes, it works.  And even though you most likely got one result back, had any other processes on your computer had a process name containing 'ccm' it would have been found.

The wildcards *ccm* say 'give me anything that matches anything - ccm - anything

So ccmexec process matched.

Here's another example of using wildcards

Your system should have a folder on it called C:\Support\SysInternals

We will use that directory for some examples.  If you do not have that directory, choose a directory with some different file types in it.

Use `Get-ChildItem` to see what's in the folder

`Get-ChildItem -Path "C:\Support\SysInternals"`

We get back list of files.  Mostly .exes

Here's a sample:
```
-a----         4/30/2020   9:24 AM         351904 PsInfo64.exe                                                                                                                                                                                 
-a----         4/30/2020   9:24 AM         284320 pskill.exe                                                                                                                                                                                   
-a----         4/30/2020   9:24 AM         318624 pskill64.exe                                                                                                                                                                                 
-a----         4/30/2020   9:24 AM         178848 pslist.exe                                                                                                                                                                                   
-a----         4/30/2020   9:24 AM         202400 pslist64.exe                                                                                                                                                                                 
-a----         4/30/2020   9:24 AM         151728 PsLoggedon.exe                                                                                                                                                                               
-a----         4/30/2020   9:24 AM         170160 PsLoggedon64.exe                                                                                                                                                                             
-a----         4/30/2020   9:24 AM         444984 psloglist.exe   
```
Notice how some of the .exes have 64 in the name?

Let's use wildcards to only show us files with the characters 64 in their name

`Get-ChildItem -Path "C:\Support\SysInternals\*64*.exe"`

```                                                               
-a----         4/30/2020   9:24 AM         618056 livekd64.exe                                                                                                                                                                                 
-a----         4/30/2020   9:24 AM         156840 LoadOrd64.exe                                                                                                                                                                                
-a----         4/30/2020   9:24 AM         188584 LoadOrdC64.exe                                                                                                                                                                               
-a----         4/30/2020   9:24 AM         249536 logonsessions64.exe                                                                                                                                                                          
-a----         4/30/2020   9:24 AM         154792 movefile64.exe                                                                                                                                                                               
-a----         4/30/2020   9:24 AM         652048 notmyfault64.exe                                                                                                                                                                             
-a----         4/30/2020   9:24 AM         649272 notmyfaultc64.exe                                                                                                                                                                            
-a----         4/30/2020   9:24 AM         158896 ntfsinfo64.exe                                                                                                                                                                               
-a----         4/30/2020   9:24 AM         156336 pendmoves64.exe                                                                                                                                                                              
-a----         4/30/2020   9:24 AM         234160 pipelist64.exe                                                                                                                                                                               
-a----         4/30/2020   9:24 AM         341672 procdump64.exe                                                                                                                                                                               
-a----         4/30/2020   9:24 AM        1490296 procexp64.exe                                                                                                                                                                                
-a----         4/30/2020   9:24 AM        1177168 Procmon64.exe                                                                                                                                                                                
-a----         4/30/2020   9:24 AM         374944 PsExec64.exe                                                                                                                                                                                 
-a----         4/30/2020   9:24 AM         168608 psfile64.exe                                                                                                                                                                                 
-a----         4/30/2020   9:24 AM         329880 PsGetsid64.exe                                                                                                                                                                               
-a----         4/30/2020   9:24 AM         351904 PsInfo64.exe                                                                                                          
```                                                                      
* I truncated the list but you get the idea

We get back what we expected, a list of all the executables with the letters 64 in the name.

Here's one more example.  Say you know there is a command to get if a machine is online.  You know it begins Test-C but that is all you remember (and you don't have access to Google).  Let's see how to find what we are after using PowerShell

We will use `Get-Command` and a wildcard.  "Test-C*".  So I will be saying 'give me everything that begins
with Test-C and then it can be anything after that.

`Get-Command -Name "Test-C*"`

That worked.  We got back all installed cmdlets that begin with Test-C

Looking through the list we recognize the command we were after: `Test-Connection`
