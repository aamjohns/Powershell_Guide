### Introduction

Two groups of IT pros were given a written test without access to a computer to determine their skill level with PowerShell. PowerShell beginners were placed in one group and experts in another. Based on the results of the test, there didn't seem to be much difference in the skill level between the two groups. Both groups were given a second test similar to the first one. This time they were given access to a computer with PowerShell that didn't have access to the internet. The results of the second test showed a huge difference in the skill level between the two groups. Experts don't always know the answers, but they know how to figure out the answers.

What was the difference in the results of the first and second test between these two groups?

The differences observed in these two tests were because experts don't memorize how to use thousands of commands in PowerShell. They learn how to use the help system within PowerShell extremely well. This allows them to find the necessary commands when needed and how to use those commands once they've found them.

Mastering the help system is the key to being successful with PowerShell.

### Help cmdlets

There are three cmdlets to use for help

`Get-Help` - Displays help about Windows PowerShell cmdlets and concepts. 

`Get-Command` - used to get information about commands

`Get-Member` - cmdlet gets the members, the properties and methods, of objects.

### Get-Help - use to access the built-in help system

 First, you may need to install the help files on your system.  To do this make sure you are running powershell as an administrator
 
 Run the following powershell command: 
 
 `Update-Help`
 
 Help should now be installed
 
 `Get-Help` is the gateway to the internal help system
 `Get-Help` works like `Get-Help <searchterm>`
 You can search for cmdlets.  For example:
 `Get-Help Get-Date`
Notice the type of information given back.  A description and how to use the command.

The following is the output of the above command

        NAME
        
            Get-Date
    
        SYNOPSIS
        
            Gets the current date and time.
    
        SYNTAX
        
            Get-Date [[-Date] <System.DateTime>] [-Day <System.Int32>] [-DisplayHint {Date | Time | DateTime}] [-Format <System.String>] 
            [-Hour <System.Int32>] [-Millisecond <System.Int32>] [-Minute <System.Int32>] [-Month <System.Int32>] 
            [-Second <System.Int32>] [-Year <System.Int32>] [<CommonParameters>]
    
            Get-Date [[-Date] <System.DateTime>] [-Day <System.Int32>] [-DisplayHint {Date | Time | DateTime}] [-Hour <System.Int32>] 
            [-Millisecond <System.Int32>] [-Minute <System.Int32>] [-Month <System.Int32>] [-Second <System.Int32>] 
            [-UFormat <System.String>] [-Year <System.Int32>] [<CommonParameters>]
    
    
        DESCRIPTION
        
            The `Get-Date` cmdlet gets a DateTime object that represents the current date or a date that you specify. `Get-Date` can format 
            the date and time in several .NET and UNIX formats. You can use `Get-Date` to generate a date or time 
            character string, and then send the string to other cmdlets or programs.
    
            `Get-Date` uses the computer's culture settings to determine how the output is formatted. To view your computer's settings, 
            use `(Get-Culture).DateTimeFormat`.
            
Get-Help tells you what a cmdlet does, what parameters are available, what syntax to use.

### Get-Command - use to find cmdlets and other information

`Get-Command` is a built-in PowerShell cmdlet that retrieves information about the available cmdlets, functions, aliases, and scripts installed on your system. 

It's a useful tool to discover and explore the available commands you can use in PowerShell.

Using `Get-Command` without any parameters will return a list of all commands available in your current PowerShell session:

`Get-Command`

You can narrow down the list of commands by specifying a cmdlet or function name, or by using wildcards:

`Get-Command -Name Get-Process`

`Get-Command -Name Get-*`

To get information about commands from a specific module, use the -Module parameter:

`Get-Command -Module ActiveDirectory`

You can also filter commands by their type, such as cmdlets, functions, or aliases, using the -CommandType parameter:

Get-Command -CommandType Cmdlet

Additionally, you can use `Get-Command` to find commands related to a specific noun or verb:

`Get-Command -Noun Process`

`Get-Command -Verb Get`

Get-Command is a helpful cmdlet for discovering and learning about the available commands in PowerShell, especially when you're not sure about the exact command name or want to explore related commands.

### Get-Member - use to explore the properties and methods available for a particular object

To use Get-Member you pipe an object to it.  For example:

`Get-Service | Get-Member`

This will get all of the members of the Get-Service object.  This inludes events, methods, and properties.

    This is the output of running Get-Service | Get-Member
    
    TypeName: System.ServiceProcess.ServiceController
    
        Name                      MemberType    Definition                                                                                                                                                                        
        ----                      ----------    ----------                                                                                                                                                                        
        Name                      AliasProperty Name = ServiceName                                                                                                                                                                
        RequiredServices          AliasProperty RequiredServices = ServicesDependedOn                                                                                                                                             
        Disposed                  Event         System.EventHandler Disposed(System.Object, System.EventArgs)                                                                                                                     
        Close                     Method        void Close()                                                                                                                                                                      
        Continue                  Method        void Continue()                                                                                                                                                                   
        CreateObjRef              Method        System.Runtime.Remoting.ObjRef CreateObjRef(type requestedType)                                                                                                                   
        Dispose                   Method        void Dispose(), void IDisposable.Dispose()                                                                                                                                        
        Equals                    Method        bool Equals(System.Object obj)                                                                                                                                                    
        ExecuteCommand            Method        void ExecuteCommand(int command)                                                                                                                                                  
        GetHashCode               Method        int GetHashCode()                                                                                                                                                                 
        GetLifetimeService        Method        System.Object GetLifetimeService()                                                                                                                                                
        GetType                   Method        type GetType()                                                                                                                                                                    
        InitializeLifetimeService Method        System.Object InitializeLifetimeService()                                                                                                                                         
        Pause                     Method        void Pause()                                                                                                                                                                      
        Refresh                   Method        void Refresh()                                                                                                                                                                    
        Start                     Method        void Start(), void Start(string[] args)                                                                                                                                           
        Stop                      Method        void Stop()                                                                                                                                                                       
        WaitForStatus             Method        void WaitForStatus(System.ServiceProcess.ServiceControllerStatus desiredStatus)
        
        CanPauseAndContinue       Property      bool CanPauseAndContinue {get;}                                                                                                                                                   
        CanShutdown               Property      bool CanShutdown {get;}                                                                                                                                                           
        CanStop                   Property      bool CanStop {get;}                                                                                                                                                               
        Container                 Property      System.ComponentModel.IContainer Container {get;}                                                                                                                                 
        DependentServices         Property      System.ServiceProcess.ServiceController[] DependentServices {get;}                                                                                                                
        DisplayName               Property      string DisplayName {get;set;}                                                                                                                                                     
        MachineName               Property      string MachineName {get;set;}                                                                                                                                                     
        ServiceHandle             Property      System.Runtime.InteropServices.SafeHandle ServiceHandle {get;}                                                                                                                    
        ServiceName               Property      string ServiceName {get;set;}                                                                                                                                                     
        ServicesDependedOn        Property      System.ServiceProcess.ServiceController[] ServicesDependedOn {get;}                                                                                                               
        ServiceType               Property      System.ServiceProcess.ServiceType ServiceType {get;}                                                                                                                              
        Site                      Property      System.ComponentModel.ISite Site {get;set;}                                                                                                                                       
        StartType                 Property      System.ServiceProcess.ServiceStartMode StartType {get;}                                                                                                                           
        Status                    Property      System.ServiceProcess.ServiceControllerStatus Status {get;}                                                                                                                       
        ToString                  ScriptMethod  System.Object ToString();  


