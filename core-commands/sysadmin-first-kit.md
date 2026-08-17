### Sysadmin First Aid Kit

This document contains the commands that I would describe as the initial tools that a sysadmin should know how to use.

### Diagnosis Command
These are commands used to read, starting with a Get- verb and taking a respective noun.

```Get-Process``` ```Get-Service``` ```Get-WinEvent```

Users and groups:
```Get-LocalUser``` ```Get-LocalGroup```

Network and connection:
```Get-NetIPAddress``` ```Get-NetTCPConnection```

The fun continues, we are now at a hardware and OS level of prying.

```Get-CimInstance``` this is queryable-everything for hardware/OS layer. In full it looks something like ```Get-CimInstance -ClassName Win32_OperatingSystem```
