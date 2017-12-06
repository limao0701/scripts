$vmHost = Get-SCVMHost -ID "4b8faec6-02ea-4b0c-b915-5588dd98dd3b"
$iSCSIHba = $vmHost.InternetSCSIHbas | where { $_.ID -eq "a9f77824-bfc7-4e49-b160-084a61f52a46" }
$array = Get-SCStorageArray -Name "FNM00153400476" | where { $_.ID -eq "e273b080-b356-471c-bd0c-0f6de1f404fe" }
$targetPortal = $array.StorageiSCSIPortals | where { $_.ID -eq "d9d5edb8-534b-4fd3-b6a2-188a825c95d3" -and $_.IPv4Address -eq "10.111.20.169" }
$selectedEndPoint = $targetPortal.StorageEndpoints | where { $_.ID -eq "f2adc916-a9ca-4bb8-bad4-25dd20944cef" -and $_.Name -eq "iqn.1992-04.com.emc:cx.fnm00153400476.a0" }
Set-SCInternetSCSIHba -InternetSCSIHba $iSCSIHba -TargetPortal $targetPortal -CreateSession -TargetName $selectedEndPoint -InitiatorIP "10.109.194.19"
