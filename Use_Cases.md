# Real World use cases for Powershell Scripts

PowerShell scripts have a wide range of real-world use cases, as they can be used to automate and manage various aspects of Windows systems and applications. Some common real-world use cases include:

- System administration tasks: PowerShell scripts can automate repetitive tasks like creating user accounts, managing permissions, resetting passwords, and managing group memberships.

- Monitoring and reporting: You can use PowerShell scripts to collect system performance data, generate reports, and monitor the health of your environment.

- Software deployment and updates: PowerShell scripts can automate the process of deploying software, applying patches, and updating applications on remote machines.

- File and data manipulation: PowerShell scripts can be used to automate file operations like copying, moving, renaming, and deleting files, as well as processing data in text files, CSV files, or XML files.

- Log analysis and event management: PowerShell scripts can be used to parse logs, filter events, and perform actions based on specific events or conditions.

- Network administration: You can use PowerShell scripts to manage network settings, monitor network devices, and perform diagnostics on network connections.

- Backup and recovery: PowerShell scripts can be used to automate backup processes, verify backups, and manage disaster recovery tasks.

- Virtualization and cloud management: PowerShell scripts can be used to manage virtual machines, automate tasks in cloud environments like Azure or AWS, and interact with REST APIs.

- Active Directory management: PowerShell scripts can automate tasks like creating and deleting Organizational Units (OUs), managing Group Policy Objects (GPOs), and querying Active Directory information.

- Exchange and Office 365 management: PowerShell scripts can be used to manage Exchange Server and Office 365 environments, including mailbox creation, mailbox permissions, and email routing.

- SQL Server administration: PowerShell scripts can be used to manage SQL Server instances, automate database backups, and perform database maintenance tasks.

- API access: Powershell script can be use to get and put information from 3rd party APIs.

Here's some scripts I have written/used to show examples of real world use of scripts.

This script creates a scheduled task on a system that runs once every 4 weeks at 9 am, if the start time is missed, then the task is started as soon as available.
```
#---------------------------------------------------------------------------------------------------------------------------------------
# Create new scheduled task to run CIS-Benchmarks
#---------------------------------------------------------------------------------------------------------------------------------------
$path_to_script = 'C:\Support\CIS-Benchmark-4_15_2\CIS-Benchmark-4_15_2.ps1'
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $path_to_script
$trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 4 -DaysOfWeek Monday -At 9am
$principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable #StartWhenAvailable tells the task to run if missed

Register-ScheduledTask -TaskName "CIS-Benchmark_4_15_2" -Action $action -Trigger $trigger -Principal $principal -Settings $settings

exit 0
```
This next script is discussed below
```
$SourceOU = "OU=Workstations,OU=Computers,OU=IU-CAIT,OU=IU,DC=ads,DC=iu,DC=edu"
$computers = Get-ADComputer -Filter * -SearchBase $SourceOU
###############################################################################
# Make MySql connection
###############################################################################
[System.Reflection.Assembly]::LoadWithPartialName('MySql.Data')
[string]$sMySQLUserName = 'hts_admin'
[string]$sMySQLPW = ''
[string]$sMySQLDB = 'hts'
[string]$sMySQLHost = 'iu-ota-msqlt1s.hts.iu.edu'
[string]$sConnectionString = 'server='+$sMySQLHost+';port=3306;uid=' + $sMySQLUserName + ';pwd=' + $sMySQLPW + ';database='+$sMySQLDB 
$oConnection = New-Object MySql.Data.MySqlClient.MySqlConnection($sConnectionString)
$Error.Clear()
try
{
    $oConnection.Open()
    write-host 'Connection opened'
}
catch
{
    write-warning ("Could not open a connection to Database $sMySQLDB on Host $sMySQLHost. Error: "+$Error[0].ToString())
}
foreach($computer in $computers)
{
    $computerName = $computer.Name
    $computerName_Split = $computerName -split "-"
    $orgCode = $computerName_Split[1].ToUpper() #index one is the org code
    $oMySqlCommand = New-Object MySql.Data.MySqlClient.MySqlCommand
    $oMySqlCommand.Connection=$oConnection
    $oMySqlCommand.CommandType = [System.Data.CommandType]::Text 
    $oMySqlCommand.CommandText = "INSERT INTO CaitsOrgCodeFromDomain (ComputerName, OrgCode) VALUES ('$computerName','$orgCode')"
    $oMySqlCommand.ExecuteNonQuery()
}
$oConnection.Close()
```
This PowerShell script performs the following tasks:

- It defines a variable $SourceOU with a Distinguished Name (DN) of an Organizational Unit (OU) in an Active Directory (AD) domain. This OU contains computer objects.

- It retrieves all computer objects within the specified OU using the Get-ADComputer cmdlet and stores them in the variable $computers.

- The script then loads the MySQL .NET Connector library by calling [System.Reflection.Assembly]::LoadWithPartialName('MySql.Data').

- It defines various MySQL connection parameters like the username, password, database name, and host, and constructs a connection string using these parameters.

- It creates a new MySQL connection object $oConnection using the connection string.

- The script attempts to open the connection to the MySQL database using a try-catch block to handle any errors that might occur during the connection process. If the connection is successful, it prints "Connection opened"; if not, it displays a warning message with the error details.

- For each computer object in the $computers variable, the script extracts the computer name and splits it into parts using the hyphen - as a delimiter. It assumes that the second part of the computer name (index 1) is the organization code and converts it to uppercase.

- The script then creates a new MySQL command object $oMySqlCommand and associates it with the open connection. It sets the command type to "Text" and defines the command text as an SQL INSERT statement to add a new row to the CaitsOrgCodeFromDomain table in the database. The statement includes the computer name and organization code as values.

- It executes the SQL command using the $oMySqlCommand.ExecuteNonQuery() method.

- After iterating through all the computer objects, the script closes the MySQL connection.

In summary, this script connects to an Active Directory domain, retrieves computer objects from a specific OU, extracts organization codes from the computer names, and inserts this data into a MySQL database.  I believe I made this script to just test gathering the different org codes into a db using the middle part of the CAITS computer names.  
