# Powershell and Powershell ISE

### Opening and running PowerShell

To run Powershell (elevated) do the following (there are multiple ways, this is just one way):

- Right click the Start Menu icon

- From the menu choose either (Windows Powershell (admin), or Command Prompt (admin), or Terminal (admin).  

- When prompted enter your admin credentials.

- If you ran CMD, to get to powershell, at the prompt enter: powershell [Enter]

- Your prompt should change to a powershell prompt

From the powershell prompt you can execute commands.

For example, at the prompt run: `Get-Process`

You should see the output from the cmdlet

### Powershell ISE

To work with scripts, I recommend using Powershell ISE (or any kind of advanced editor like VS Code)

To run powershell ISE from the prompt type: powershell_ise [Enter]

This should open Powershell ISE

If all you see is the blue console window you need to show the script pane.

On the View menu make sure there is a checkmark next to Show Script Pane

Now you should have a white text window above you blue console window at the bottom

In the white pane, you can write powershell script code and then execute it by clicking

the green 'play' button, or going to Debug/Run-Continue, or hit F5

To execute only a selected portion of the code:

highlight the lines you want to run, right-click on the selected text, and choose "Run Selection" or press F8 key. 

This will execute the selected lines and display the output in the console pane.

### Powershell_ISE

Script Pane: A text editor at the top of the ISE window where you can write, edit, and save PowerShell scripts. It supports syntax highlighting, which makes it easier to read and understand the code.

Console Pane: Located at the bottom of the ISE window, this pane allows you to interact with the PowerShell console directly. You can run individual commands, see the output of your scripts, and interact with the results.

Intellisense: PowerShell ISE offers autocomplete suggestions for cmdlets, parameters, and variable names as you type, making it easier to write and edit scripts.

Debugging: ISE provides built-in debugging capabilities, allowing you to set breakpoints, step through your code, and inspect variables and objects in real-time.

Context-sensitive Help: You can access help for cmdlets and functions directly within the ISE by pressing F1, which brings up help documentation related to the item currently under the cursor.

Customization: You can customize the appearance of the ISE, such as font size, color themes, and pane layout, to suit your preferences.

Add-ons: PowerShell ISE supports add-ons, which are modules that extend its functionality with new features and tools.

### Creating a script in the ISE

In the script pane type the powershell code you want to run

Save the script

Run the script

Output will be displayed at the bottom in the console window

### How to run a PowerShell script file

#### Running from the Console

First you need to know where you script file is located and the name.

Let's say I have a PowerShell script saved here: C:\IT Support\MyTestScript.ps1

To run this script from the Console:

There are two ways to do this.  Run the script from whatever directory we are currently in or, change to the directory the script is in and run it from there.

To run the script from any directory using the console type the full path to the script. If there are any spaces in the path, surround it with double quotes, so:

PS prompt>"C:\IT Support\MyTestScript.ps1" [Enter]

Hit enter an the script should execute.

Alternatively, you can change directory to where the script is and then call it using dot notation:

PS prompt>cd "C:\IT Support" [Enter]

PS prompt>.\MyTestScript.ps1 [Enter]

We first changed to the directory where the script is: cd "C:\IT Support"

And then we called the script from that directory using .\scriptname.ps1

the . says 'from this directory', and then we need to add a \ followed by the scriptname

### Running from PowerShell ISE

From the ISE make sure the script pane is visible. 

Go to File>Open and browse to your script

Open the file

You should now see the script code in the ISE editor pane

To run the script, click the green Play icon, or hit F5

Any output from the script will be displayed in the bottom console window

### Installing and using ISE Steroids

ISE Steroids is an excellent tool to use with PowerShell ISE.  First you need to install ISE Steroids

If you are in ISE, go to the prompt at the bottom

Enter: `Install-Module -Name "ISESteroids"`

When you run Install-Module for the first time, you will be asked to download the “nuget” binaries first which drive the download process. 

Next, ISESteroids is automatically downloaded, unblocked, unpacked and copied to the appropriate destination

Once ISE Steroids is installed, to activate it, at the console type: `Start-Steroids` [Enter]

ISE Steroids should load after a brief pause

Each time you start a new Powershell ISE session, remember to run Start-Steroids to load the enhanced environment
