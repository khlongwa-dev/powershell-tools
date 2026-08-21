## PowerShell As a Language

This is a recipe for writing scripts that actually works, that can behave as commands, control and automate tasks. We start it off with a simple block _param_. <br />

```
param(
    [DataType]$VariableName
)
```
this I call a container for parameters of the scripts, tiny bits of information that a script needs to do what it written for. <br />

**DataType** can be an integer, a string, or a float, **VariableName** is whatever you want to call the container of that data of a particular datatype you are passing as a parameter. <br />

```
param(
    [Parameter(Mandatory)]
    [DataType]$VariableName
)
```

The new field ```[Parameter(Mandatory)]``` makes the parameter a forced requirement. Without a parameter the script will not run. It will prompt for the parameter if not passed.<br />

```
param(
    [Parameter(Mandatory)]
    [ValidateSet("value1", "value2", "value3")]
    [DataType]$VariableName
)
```

The new field ```[ValidateSet("value1", "value2", "value3")]``` validates the value of the passed parameter against standard values specified in the scripts. <br />

```
function Function-Name {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet("value1", "value2", "value3")]
        [string]$VariableName
   )
   Write-Verbose "Doing something"
   Write-Host "Script has completed doing something."
}
```

Here I will focus on ```CmdletBinding()``` this gives the function a functionality similar to that of commands. Just dot source the scripts and then boom, you can run the function like all commands. <br />
Now let us look into ```-WhatIf``` a very important support piece, this lets you know what a script does or what is expected to happen if a script runs before running." <br />

```
function Function-Name {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [ValidateSet("value1", "value2", "value3")]
        [string]$VariableName
   )
   if ($PSComdelt.ShouldProcess(arg, "This function does something that causes that other thing to happen.")) {
       Write-Verbose "Doing something"
       Write-Host "Script has completed doing something."
   }
}
```

When running ```Function-Name -VariableName ParameterValue -WhatIf``` this will not run the script but will tell you what the script does. It is some sort of a safety net. <br />

Now we create a module file ending with **.psm1** instead of **.ps1**. Here you just create a new file _NewFile.psm1_ and paste the contents of your initial script. Let us assume we had a script that greets a user. Here is the flow: <br />

**Step 1 — create the module file.** Rename or copy your function into a file ending in .psm1 instead of .ps1:<br />
```
New-Item -Path .\GreetingTools.psm1 -ItemType File
```
**Step 2 — create the manifest.** This is metadata about the module — version, author, which functions it exposes:<br />
```
New-ModuleManifest -Path .\GreetingTools.psd1 -RootModule .\GreetingTools.psm1 -FunctionsToExport "Get-Greeting" -Author "Sipho Nkosi" -Description "Practice module for greeting/user tools"
```

**Step 3 — load and use it properly:**<br />
```
Import-Module .\GreetingTools.psd1
Get-Greeting -Name "Test" -Age 30 -Role "User"
```
