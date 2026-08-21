## Real Sysadmin Automation

First stop: **Get-CimInstance**, done properly this time rather than just a taste. This is Windows' queryable-everything layer — hardware, OS config, installed software, all reachable through one consistent interface.

<br /> Getting all class names: <br />
```Get-CimClass -ClassName "Win32_*" | Select-Object CimClassName```

Filtering: <br />
```
Get-CimClass -ClassName "Win32_*disk*"
Get-CimClass -ClassName "Win32_*network*"
Get-CimClass -ClassName "Win32_*service*"
```

The following two examples shows two ways in which we can look for a disk with less than 20% of free space available. <br />

```
Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object DeviceID, Size, FreeSpace, @{Name="PercentFree";Expression={($_.FreeSpace / $_.Size) * 100}}
```

```
Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object { ($_.FreeSpace / $_.Size) * 100 -lt 20 }
```
