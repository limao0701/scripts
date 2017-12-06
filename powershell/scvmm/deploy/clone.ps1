# ------------------------------------------------------------------------------
# Create Virtual Machine Wizard Script
# ------------------------------------------------------------------------------
# Script generated on Sunday, November 5, 2017 9:04:46 PM by Virtual Machine Manager
# 
# For additional help on cmdlet usage, type get-help <cmdlet name>
# ------------------------------------------------------------------------------


New-SCVirtualScsiAdapter -VMMServer localhost -JobGroup dee5f31d-b5bc-4e89-9946-86ba4e2e296d -AdapterID 255 -ShareVirtualScsiAdapter $false -ScsiControllerType DefaultTypeNoType 


New-SCVirtualDVDDrive -VMMServer localhost -JobGroup dee5f31d-b5bc-4e89-9946-86ba4e2e296d -Bus 0 -LUN 1 


New-SCVirtualNetworkAdapter -VMMServer localhost -JobGroup dee5f31d-b5bc-4e89-9946-86ba4e2e296d -MACAddressType Dynamic -Synthetic -IPv4AddressType Dynamic -IPv6AddressType Dynamic 

$CPUType = Get-SCCPUType -VMMServer localhost | where {$_.Name -eq "3.60 GHz Xeon (2 MB L2 cache)"}

#New-SCHardwareProfile -VMMServer localhost -CPUType $CPUType -Name "Profileab6a3ca6-79e0-4a3b-9760-f51767e7b25c" -Description "Profile used to create a VM/Template" -CPUCount 1 -MemoryMB 4096 -DynamicMemoryEnabled $false -MemoryWeight 5000 -CPUExpectedUtilizationPercent 20 -DiskIops 0 -CPUMaximumPercent 100 -CPUReserve 0 -NumaIsolationRequired $false -NetworkUtilizationMbps 0 -CPURelativeWeight 100 -HighlyAvailable $false -DRProtectionRequired $false -SecureBootEnabled $true -SecureBootTemplate "MicrosoftWindows" -CPULimitFunctionality $false -CPULimitForMigration $false -CheckpointType Production -Generation 2 -JobGroup dee5f31d-b5bc-4e89-9946-86ba4e2e296d 



$VirtualNetworkAdapter = Get-SCVirtualNetworkAdapter -VMMServer localhost -Name "WIN16_VDBENCH" -ID "b03462ea-1f1b-438a-99c4-48ca1fbec37b"

Set-SCVirtualNetworkAdapter -VirtualNetworkAdapter $VirtualNetworkAdapter -NoLogicalNetwork -NoConnection -MACAddressType Dynamic -IPv4AddressType Dynamic -IPv6AddressType Dynamic -NoPortClassification -JobGroup 8e4b7dc9-52bc-411f-8d6c-3d4aaec1bd94 

$VM = Get-SCVirtualMachine -VMMServer localhost -Name "WIN16_VDBENCH" -ID "bc738db7-68e4-4b5e-aa19-0b65491d0614" | where {$_.VMHost.Name -eq "nchyp195169.cluster.hyperv.drm.lab.emc.com"}
$VMHost = Get-SCVMHost -VMMServer localhost | where {$_.Name -eq "nchyp195169.cluster.hyperv.drm.lab.emc.com"}
$HardwareProfile = Get-SCHardwareProfile -VMMServer localhost | where {$_.Name -eq "VM_2CPU_4G_G2"}
$OperatingSystem = Get-SCOperatingSystem -VMMServer localhost -ID "0a393d1e-9050-4142-8e55-a86e4a555013" | where {$_.Name -eq "Windows Server 2016 Datacenter"}

New-SCVirtualMachine -VM $VM -Name "WIN16_VDBENCH_CLONE1" -Description "WIN16 CLONE MANUAL" -JobGroup 8e4b7dc9-52bc-411f-8d6c-3d4aaec1bd94 -UseDiffDiskOptimization -RunAsynchronously -Path "\\D1071NEMO07\CIFS_T_ILC_ON" -VMHost $VMHost -HardwareProfile $HardwareProfile -OperatingSystem $OperatingSystem -StartAction NeverAutoTurnOnVM -StopAction SaveVM 

$vmID=(get-scvirtualmachine  | where-object {$_.Name -match "WIN16_VDBENCH_CLONE1" -and $_.HostName -match "nchyp194102"}).id.guid
$VMObj = Get-SCVirtualMachine -ID $vmID  
Remove-SCVirtualMachine -VM $VMObj

