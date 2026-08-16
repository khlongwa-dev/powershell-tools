### PowerShell Foundation

This document outlines the foundations of PowerShell and how to build a solid understanding on how commands are built instead of memorizing them. PowerShell commands follow a Verb-Noun structure,
that is where it all begins.

```Get-Command``` and ```Get-Verb``` returns approved or allowed commands and verbs respectively.

### Getting What You Want
There is a ton of Get-Commands using ```Get-Command | Measure-Object``` gives a count over a thousand commands. Say you are working on __process__ related issue and you want the commands related to process;
instead of going through the internet or a bunch of command here is how you can go about it:

```Get-Command -Verb Get -Noun *process*```

This literally says in _thousands of commands from Get-Command you just want those with a Get verb and a noun with a keyword process_. 

After picking up the exact command you want, then you might need a help manual for it.

```Get-Help Get-Process -Full```
