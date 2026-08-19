function Create-Users {
    $Password = ConvertTo-SecureString "Voltcore@2026!" -AsPlainText -Force
    
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$FilePath
    )
    
    Write-Verbose "Creating Voltcore Employees..."
    
    if ($PSCmdlet.ShouldProcess($FilePath, "Create a batch of local users from $FilePath") {
        $results = foreach ($row in Import-Csv $FilePath) {
    
            try {
                New-LocalUser -Name $row.Username -Password $Password -FullName $row.FullName -Description "Voltcore employee." -ErrorAction Stop
    
                $User = [ADSI]"WinNT://localhost/$($row.Username)"
                $User.passwordExpired = 1
                $User.SetInfo()
    
                [PSCustomObject]@{
                    Name = $row.FullName
                    Status = "Success"
                    Message = "Created successfully"
                }
            }
            catch {
                [PSCustomObject]@{
                    Name = $row.Username
                    Status = "Failed"
                    Message = $_.Exception.Message
                }
            }
        }
    }

    Write-Verbose "Creating users complete."
    $results | Export-Csv .\user-creation-log.csv -NoTypeInformation
}

# Example invocation:
# Create-Users -FilePath ".\users.csv" -Verbose
# Create-Users -FilePath ".\users.csv" -WhatIf
