### PowerShell Foundation

This document outlines the foundations of PowerShell and how to build a solid understanding on how commands are built instead of memorizing them. PowerShell commands follow a Verb-Noun structure,
that is where it all begins.

```Get-Command``` and ```Get-Verb``` returns approved or allowed commands and verbs respectively.

### Getting What You Want
There is a ton of commands using ```Get-Command | Measure-Object``` gives a count over a thousand commands. Say you are working on __process__ related issue, and you want the commands related to process;
instead of going through the internet or a bunch of command here is how you can go about it:

```Get-Command -Verb Get -Noun *process*```

This literally says in _thousands of commands from Get-Command you just want those with a Get verb and a noun with a keyword process_. 

After picking up the exact command you want, then you might need a help manual for it.

```Get-Help Get-Process -Full``` or even better ```Get-Help Get-Process -Examples```

But it worth knowing that _Get-Process_ is a __cmdlet__ that returns a bunch of objects. _Get-Member_ allows us to see all the available objects before we can use them.

```Get-Process | Get-Member``` shows all the available objects that we can work with as through selection or specification using the clause such as _Select-Object_ or _Where-Object_:

So now we can have ```Get-Process | Select-Object ProcessName, Id, CPU -First 5``` _ProcessName, Id, CPU_ are all the objects that are unpacked by *Get-Member*

We can have it all chained using pipes, this pipe '|':

```Get-Process | Where-Object { $_.CPU -gt 5 } | Sort-Object CPU -Descending | Select-Object ProcessName, Id, CPU```

So here we are saying "from a list of process select those with CPU greater than 5, sort them in descending order by CPU and select ProcessName, Id and CPU columns".

### Treasure

There is a cmdlet ```Get-PSDrive``` I have not much of a clue, but what lives in there pretends to be folders but actually it is a different environment. 

```cd Env:``` takes you to where environment variable lives ```cd HKCU:``` takes you to user related settings and ```cd HKCM:``` here lives the machine settings that applies regardless of who is logged in.
