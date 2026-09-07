Import-Csv -Path "C:\users.csv" | ForEach-Object {
    $OUPath = "OU=$($_.OU),DC=lab,DC=local"
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$($_.OU)'")) {
        New-ADOrganizationalUnit -Name $_.OU -Path "DC=lab,DC=local"
    }
    New-ADUser -Name "$($_.GivenName) $($_.Surname)" `
               -SamAccountName $_.SamAccountName `
               -GivenName $_.GivenName `
               -SurName $_.Surname `
               -Title $_.Title `
               -Department $_.Department `
               -Path $OUPath `
               -Enabled $true `
               -ChangePasswordAtLogon $true `
               -AccountPassword (ConvertTo-SecureString "TempP@ssword2026!" -AsPlainText -Force)
}

Get-ADUser -Filter * -Properties Title, Department, Created | 
Select-Object Name, SamAccountName, Title, Department, Enabled, Created | 
Export-Csv -Path "C:\AD_User_Audit.csv" -NoTypeInformation; Notepad.exe "C:\AD_User_Audit.csv"
