# How to create one user with default password and a forced password change on first logon

$Username = "khlongwa"
$DefaultPassword = ConvertTo-SecureString "Voltcore@2026!" -AsPlainText -Force

# Create the user instantly
New-LocalUser -Name $Username -Password $DefaultPassword -FullName "Kusasalakhe Hlongwa" -Description "This is just a general user."

# Force password change on next logon
$User = [ADSI]"WinNT://localhost/$Username"
$User.passwordExpired = 1
$User.SetInfo()