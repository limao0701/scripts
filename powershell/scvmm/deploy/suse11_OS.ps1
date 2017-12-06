$GuestOSProfile = Get-SCGuestOSProfile -VMMServer localhost | where {$_.Name -eq "SUSE11"}
$LocalAdministratorCredential = get-credential

$UserRole = Get-SCUserRole -VMMServer localhost  -Name "Administrator" -ID "75700cd5-893e-4f68-ada7-50ef4668acc6"
$OperatingSystem = Get-SCOperatingSystem -VMMServer localhost -ID "2cf4d2e5-7809-4679-88e3-66d42bbf2e67" | where {$_.Name -eq "Suse Linux Enterprise Server 11 (64 bit)"}

Set-SCGuestOSProfile -GuestOSProfile $GuestOSProfile -Name "SUSE11" -Description "" -ComputerName "*" -TimeZone 35 -LocalAdministratorCredential $LocalAdministratorCredential  -LinuxAdministratorSSHKey $null -Owner 'CLUSTER\ADMINISTRATOR' -UserRole $UserRole -OperatingSystem $OperatingSystem 


