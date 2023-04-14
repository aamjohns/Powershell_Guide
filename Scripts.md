# Scripts

Automating tasks with scripts in PowerShell is a powerful way to increase efficiency, reduce the risk of human error, and ensure consistency across various tasks. Scripts allow you to combine multiple cmdlets and control structures to create complex, reusable workflows.

A note on Execution-Policy

By default, PowerShell has a restricted execution policy, which prevents scripts from running. To run a script, you may need to change the execution policy. You can check the current execution policy with `Get-ExecutionPolicy` and set a new policy with `Set-ExecutionPolicy`. For example:
`Set-ExecutionPolicy RemoteSigned`
This sets the execution policy to "RemoteSigned", allowing scripts to run if they are created locally or signed by a trusted publisher when downloaded from the internet.

To run all scripts use:
`Set-ExecutionPolicy Bypass`

In HTS our system are configure for RemoteSigned.  If you download a script from the internet and try to run it, it should fail.  If you open the script, copy all, and paste it into a local file, it should then run.  

### Creating a script

PowerShell scripts are text files with a ".ps1" file extension that contain PowerShell commands and control structures. The first thing you need is an environment to write scripts in.  There are benefits to using scripting IDEs over something like Notepad.  I recommend using Powershell ISE, VS Code, or Powershell Studio.  Using the Powershell ISE is covered earlier in this guide.

Let's start off by creating a basic script:
```
$services = Get-Service
foreach ($service in $services) {
    if ($service.Status -eq 'Stopped') {
        Write-Host "Stopped service: $($service.Name)"
    }
}
```
While we are here I want to discuss something I used in the script above.  It is called a subexpression.  It is when you surround an expression with `$( )`.  So in the above code `$($service.Name)`.  The reason we do this is to include the result of an expression, such as accessing an object's property, within a double-quoted string.  You don't need to use a subexpression here:
```
$result = myString.ToUpper()
```
But in a quoted Write-Host statement, property values of object are not evaluated.  To ensure the property value of the object is evaluated we create the subexpression.

Just know, you should use a subexpression when you need to include the result of an expression, like a calculation or property access, within a double-quoted string.

Back to our script.  You copy pasted the code above into your script editor, gave the script a name, and saved it.

### Execute a script

To run a PowerShell script, open a PowerShell session and enter the path to the script file:

PS prompt>"C:\Support\My Scripts\PowershellOMatic.ps1"

Or for the same script above

PS prompt>cd "C:\Support\My Scripts"

PS prompt>.\PowershellOMatic.ps1

Scripts can also be executed directly from your editor, provided it is configured properly.  

### Use parameters in scripts

To make your scripts more flexible and reusable, you can add parameters to them. Parameters allow you to pass values to the script when you run it. To define parameters, use the param keyword at the beginning of the script:
```
param (
    [string]$ServiceStatus = 'Stopped'
)

$services = Get-Service
foreach ($service in $services) {
    if ($service.Status -eq $ServiceStatus) {
        Write-Host "$ServiceStatus service: $($service.Name)"
    }
}
```
In this example, we added a parameter called `$ServiceStatus` with a default value of 'Stopped'. You can run the script with a custom value for the parameter:
`.\MyScript.ps1 -ServiceStatus Running`

Notice how, just like calling a function with a named parameter, we can pass values to scripts using parameters on the command line.

### Functions

Scripts can include multiple functions to break down the script into smaller, reusable pieces. Functions help improve the readability and maintainability of your scripts.

### Commenting

Use comments in your scripts to explain the purpose of the script or to provide instructions on how to use the script. You can use single-line comments starting with a `#` or multi-line comments enclosed between `<#` and `#>`.

### Error handling

Incorporate error handling in your scripts using try and catch blocks to handle errors gracefully and provide useful information to users when something goes wrong.

### Script output

Often is is good to create a log file and log data from your script.  You can then quickly verify that your script is working (this is especially useful for scripts that run as automated or scheduled tasks).

To output information to the console, you can use `Write-Host`, `Write-Output`, or `Write-Verbose`. `Write-Verbose` is particularly useful for providing additional details when the -Verbose switch is used while running the script.

### Sharing and reusing

Scripts you have already written can be a great source of new code, or code reuse.  Others may benefit from using your scripts.

### Here's an example of a real world script

This is the script used by HTS to automatically generate a spreadsheet containing information about HTS shared printers.  Don't try to run this script.  You can but it won't work.  This script requires the GPAE module be installed and it costs money :)
```
#This script requires PSEXCEL module be installed
Import-Module PSEXCEL
#It also requires the GPAE by SDM Software be installed
function Write-Log 
{ 
    [CmdletBinding()] 
    Param 
    ( 
        [Parameter(Mandatory=$true, 
                   ValueFromPipelineByPropertyName=$true)] 
        [ValidateNotNullOrEmpty()] 
        [Alias("LogContent")] 
        [string]$Message, 
 
        [Parameter(Mandatory=$false)] 
        [Alias('LogPath')] 
        [string]$Path='C:\Logs\PowerShellLog.log', 
         
        [Parameter(Mandatory=$false)] 
        [ValidateSet("Error","Warn","Info")] 
        [string]$Level="Info", 
         
        [Parameter(Mandatory=$false)] 
        [switch]$NoClobber 
    ) 
 
    Begin 
    { 
        # Set VerbosePreference to Continue so that verbose messages are displayed. 
        $VerbosePreference = 'Continue' 
    } 
    Process 
    { 
         
        # If the file already exists and NoClobber was specified, do not write to the log. 
        if ((Test-Path $Path) -AND $NoClobber) { 
            Write-Error "Log file $Path already exists, and you specified NoClobber. Either delete the file or specify a different name." 
            Return 
            } 
 
        # If attempting to write to a log file in a folder/path that doesn't exist create the file including the path. 
        elseif (!(Test-Path $Path)) { 
            Write-Verbose "Creating $Path." 
            $NewLogFile = New-Item $Path -Force -ItemType File 
            } 
 
        else { 
            # Nothing to see here yet. 
            } 
 
        # Format Date for our Log File 
        $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss" 
 
        # Write message to error, warning, or verbose pipeline and specify $LevelText 
        switch ($Level) { 
            'Error' { 
                Write-Error $Message 
                $LevelText = 'ERROR:' 
                } 
            'Warn' { 
                Write-Warning $Message 
                $LevelText = 'WARNING:' 
                } 
            'Info' { 
                Write-Verbose $Message 
                $LevelText = 'INFO:' 
                } 
            } 
         
        # Write log entry to $Path 
        "$FormattedDate $LevelText $Message" | Out-File -FilePath $Path -Append 
    } 
    End 
    { 
    }
}
function Get-PrinterIPAddress($printerName) # Connect to server and get the portname of the printer
{
	$(get-printer -ComputerName MyPrintServer -Name $printerName).PortName
}
#region startlog
#=========================================================
#Build log file path so it logs to the same directory the script is running from
$path = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$scriptName = $MyInvocation.MyCommand.Name
$scriptLog = "$path\$scriptName.log"
#=========================================================
# To keep the log from getting too large delete it before every run
if(Test-Path -Path $scriptLog)
{
    Remove-Item -Path $scriptLog 
}
#=========================================================
Write-Log -Message "Starting script $(get-date)" -Path $scriptLog -Level Info
#endregion startlog
$gpo = Get-SDMgpobject -gpoName "gpo://ads.iu.edu/IN-OTA-Global-User-Printer-GPP" -OpenByName
$container = $gpo.GetObject("User Configuration/Preferences/Control Panel Settings/Printers/Shared Printer");
$settings = $container.Settings
$printers = @()
foreach($setting in $settings)
{
    $arrGroups = @()
    if($setting.Get("Disabled") -eq $false)
    {
        $status  =  "Enabled"
    }
    else
    {
        $status = "Disabled"
    }
    $name = $setting.Name
    $portName = Get-PrinterIPAddress -printerName $name
    $sharePath = $setting.Get("Share path")
    $description = $setting.Get("Description")
    $descriptionSplit = $description -split ' - '
    $makeAndModel = $descriptionSplit[0]
    $buildingAndRoom = $descriptionSplit[1]
    $buildingAndRoomSplit = $buildingAndRoom -split ' '
    $building = $buildingAndRoomSplit[0]
    $room = $buildingAndRoomSplit[1]
    $department = $descriptionSplit[2]
    foreach ($ilt in $setting.Get("Item-level targeting"))
    {
        if ($ilt.GetInterfaceType() -eq [GPOSDK.Providers.ILTargetingType]"FilterGroup")
        { 
            $arrGroups += $($ilt.Get("Group")) + ","
            if($arrGroups -match '^ADS')
            {
                $arrGroups = $arrGroups.Replace("ADS\","")
            }
        }
    }
    $strGroups= [String]$arrGroups #convert the array object to string so we can trim the comma off the end
    $strGroups = $strGroups.TrimEnd(",")
    $printer = New-Object -TypeName PSObject -Property ([ordered]@{

            'Name' = $name
	    'Share' = $sharePath
	    'Port' = $portName
            'MakeAndModel' = $makeAndModel
            'Building' = $building
            'Room' = $room
            'Department' = $department
            'Group' = $strGroups
            'Status' = $status

    })
    $printers += $printer
    Write-Log -Message "Status=$($printer.Status) Name=$($printer.Name) Share=$($printer.Share) Make and Model=$($printer.MakeAndModel) `
    Building=$($printer.Building) Room=$($printer.Room) Department=$($printer.Department) Group=$($printer.Group)" -Path $scriptLog -Level Info
}
$printers | Export-Xlsx -Path '\\ADifferentServer\Printers$\Printers.xlsx' -ClearSheet

```
This script may not be the best choice due to its lack of internal comments.  But we can discuss it here.

First you see a fancy looking function called `Write-Log`.  I use that function in almost all my script.  It allows me to write to a log file using a consistent format

Next is a function I created.  
```
function Get-PrinterIPAddress($printerName) # Connect to iu-ota-prnt01 and get the portname of the printer
{
	$(get-printer -ComputerName iu-ota-prnt01 -Name $printerName).PortName
}
```
You will notice it does not follow the typical Powershell function design.  I attribute this to my time programming in C# and my desire to use that quick and efficient design formula for functions.

I should have created the function like this:
```
function Get-PrinterIPAddress {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$printerName
    )

    (Get-Printer -ComputerName iu-ota-prnt01 -Name $printerName).PortName
}
```
By adding the `[CmdletBinding()]` attribute and using the param block, you gain access to features such as advanced parameter validation and support for common parameters (e.g., `-Verbose`). In this example, I've also marked the `$printerName` parameter as mandatory, so the function will require the user to provide a printer name when calling the function.

Next we create the log file we are going to use, and set it to live in the same directory as our script.  We then delete the log file if it already exists.  I do this to keep the log file from getting too large.
```
$gpo = Get-SDMgpobject -gpoName "gpo://ads.iu.edu/IN-OTA-Global-User-Printer-GPP" -OpenByName
$container = $gpo.GetObject("User Configuration/Preferences/Control Panel Settings/Printers/Shared Printer");
$settings = $container.Settings
$printers = @()
foreach($setting in $settings)
```
In the above section, we use our imported module to connect to Group Policy Prefernces to get information about the printers in the policy.
When then iterate through the settings value we can obtain for each printer from the GPP.

Once we gather up all of the data we want to collect about each printer, we create a new custom PSObject with the values we want.  We add that custom object to a collection storing the objects.

Finally, we write all the data we collected out to an Excel spreadsheet:
`$printers | Export-Xlsx -Path '\\iu-ota-mdt.ads.iu.edu\Printers$\Printers.xlsx' -ClearSheet`

The column headings in the spreadsheet will be the property names from our object we created
```
    $printer = New-Object -TypeName PSObject -Property ([ordered]@{
            'Name' = $name
	    'Share' = $sharePath
	    'Port' = $portName
            'MakeAndModel' = $makeAndModel
            'Building' = $building
            'Room' = $room
            'Department' = $department
            'Group' = $strGroups
            'Status' = $status

    })
```    
