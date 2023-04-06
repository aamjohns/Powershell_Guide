# Working Remotely with Powershell

Working remotely with PowerShell involves using PowerShell Remoting, a feature that allows you to run commands and scripts on remote computers. PowerShell Remoting is based on the Windows Remote Management (WinRM) service, which is a Microsoft implementation of the Web Services-Management (WS-Management) protocol.

Before you can use PowerShell Remoting, you need to ensure that it's enabled on the remote computer. You can enable PowerShell Remoting by running the following command on the remote computer with administrative privileges:
```
Enable-PSRemoting -Force
```
This command starts the WinRM service, configures it to start automatically, and sets up the necessary firewall rules.

In HTS our systems support PSRemoting.  One must be on a campus network to make a remote powershell session.

#### Establish a remote session

To work with a remote computer, you need to establish a remote session using the `Enter-PSSession` cmdlet. Provide the computer name (or IP address) as a parameter:
```
Enter-PSSession -ComputerName RemoteComputerName
```
After running this command, you'll be connected to the remote computer, and any commands you enter will be executed on the remote machine. To exit the remote session, use the Exit-PSSession cmdlet.

Keep in mind that commands that require any kind of interaction (gui pops up) will not work in a remote pssession.  One command that comes to mind is the command to rejoin a computer to the domain.  To use this command you have to get the ads credentials which triggers a popup.  Commands that have these requirements do not work remotely.  With that being said, almost all commands do work remotely.

#### Run remote commands without entering a session

If you want to run a single command or script on a remote computer without entering a remote session, use the `Invoke-Command` cmdlet:
```
Invoke-Command -ComputerName RemoteComputerName -ScriptBlock { Get-Process }
```
In this example, the `Get-Process` cmdlet is executed on the remote computer, and the results are returned to the local computer.

#### Work with multiple remote computers

You can use PowerShell Remoting to work with multiple remote computers at the same time. Use the -ComputerName parameter with an array of computer names or IP addresses:
```
$computerNames = @("RemoteComputer1", "RemoteComputer2", "RemoteComputer3")
Invoke-Command -ComputerName $computerNames -ScriptBlock { Get-Service }
```
This command runs the `Get-Service` cmdlet on all specified remote computers and returns the results to the local computer.

Secure PowerShell Remoting

PowerShell Remoting is designed to be secure by default. It uses the Kerberos authentication protocol for domain-joined computers and encrypts all data transmitted between the local and remote computers.




