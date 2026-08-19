$Password = ConvertTo-SecureString "Voltcore@2026!" -AsPlainText -Force

function Create-Users {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]$FilePath
    )

    $results = foreach ($row in Import-Csv $FilePath) {

        try {
            New-LocalUser -Name $row.Username -Password $Password -FullName $row.FullName -Description "Voltcore employee."

            $User = [ADSI]"WinNT://localhost/$Username"
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

    $results | Export-Csv .\user-creation-log.csv -NoTypeInformation

    # This script is still under works, it has not been tested.
}