Import-module ActiveDirectory

$firstName = read-host "Enter First Name: "
$lastName = read-host "Enter The Last Name: "
$pw = read-host "Enter The Password: "

$securePW = ConvertTo-SecureString -a -f $pw

$fullName = $firstName + " " + $lastName
$alias = read-host "Enter The Mailbox Alias: "

New-Mailbox -Name "$fullName" -Alias "$alias" -OrganizationalUnit "domain.local/OU" -
UserPrincipalName "$alias@domain.com" -SamAccountName "$alias" -FirstName "$firstName" -LastName "$lastName" 
-Password $securePW -ResetPasswordOnNextLogon $false

Add-ADGroupMember -Identity RDS_Users -Member $alias

Write-Output "" "Success! - Now add it to the spam filter"

Start-Process "https://portal.fusemail.com/#/users2"