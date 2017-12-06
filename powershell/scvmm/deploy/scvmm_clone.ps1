# ------------------------------------------------------------------------------
# Create Virtual Machine Wizard Script
# ------------------------------------------------------------------------------
# Script generated on Tuesday, December 5, 2017 2:18:30 AM by Virtual Machine Manager
# 
# For additional help on cmdlet usage, type get-help <cmdlet name>
# ------------------------------------------------------------------------------


New-SCVirtualScsiAdapter -VMMServer localhost -JobGroup c6ef759f-58c8-4950-898b-7a030f178428 -AdapterID 255 -ShareVirtualScsiAdapter $false -ScsiControllerType DefaultTypeNoType 


New-SCVirtualDVDDrive -VMMServer localhost -JobGroup c6ef759f-58c8-4950-898b-7a030f178428 -Bus 1 -LUN 0 


New-SCVirtualNetworkAdapter -VMMServer localhost -JobGroup c6ef759f-58c8-4950-898b-7a030f178428 -MACAddressType Dynamic -Synthetic -IPv4AddressType Dynamic -IPv6AddressType Dynamic 


Set-SCVirtualCOMPort -NoAttach -VMMServer localhost -GuestPort 1 -JobGroup c6ef759f-58c8-4950-898b-7a030f178428 


Set-SCVirtualCOMPort -NoAttach -VMMServer localhost -GuestPort 2 -JobGroup c6ef759f-58c8-4950-898b-7a030f178428 


Set-SCVirtualFloppyDrive -RunAsynchronously -VMMServer localhost -NoMedia -JobGroup c6ef759f-58c8-4950-898b-7a030f178428 

$CPUType = Get-SCCPUType -VMMServer localhost | where {$_.Name -eq "3.60 GHz Xeon (2 MB L2 cache)"}

$CapabilityProfile = Get-SCCapabilityProfile -VMMServer localhost | where {$_.Name -eq "Hyper-V"}

New-SCHardwareProfile -VMMServer localhost -CPUType $CPUType -Name "Profile80e64b78-34f5-4098-9eff-93a57f82b6c3" -Description "Profile used to create a VM/Template" -CPUCount 2 -MemoryMB 4096 -DynamicMemoryEnabled $false -MemoryWeight 5000 -VirtualVideoAdapterEnabled $false -CPUExpectedUtilizationPercent 20 -DiskIops 0 -CPUMaximumPercent 100 -CPUReserve 0 -NumaIsolationRequired $false -NetworkUtilizationMbps 0 -CPURelativeWeight 100 -HighlyAvailable $false -DRProtectionRequired $false -NumLock $false -BootOrder "CD", "IdeHardDrive", "PxeBoot", "Floppy" -CPULimitFunctionality $false -CPULimitForMigration $true -CheckpointType Production -CapabilityProfile $CapabilityProfile -Generation 1 -JobGroup c6ef759f-58c8-4950-898b-7a030f178428 



$VirtualNetworkAdapter = Get-SCVirtualNetworkAdapter -VMMServer localhost -Name "SQL_EXPAND1" -ID "f4fbd8cb-a63a-4aae-b27c-a7d29d1a10a6"

Set-SCVirtualNetworkAdapter -VirtualNetworkAdapter $VirtualNetworkAdapter -NoLogicalNetwork -NoConnection -MACAddressType Dynamic -IPv4AddressType Dynamic -IPv6AddressType Dynamic -NoPortClassification -JobGroup 0325fde1-8357-40cf-98f5-bd9b27e12a67 

$VM = Get-SCVirtualMachine -VMMServer localhost -Name "SQL_EXPAND1" -ID "8ec5c6b3-67b6-4ff9-9de4-04868205b2cd" | where {$_.VMHost.Name -eq "nchyp19419.cluster.hyperv.drm.lab.emc.com"}
$VMHost = Get-SCVMHost -VMMServer localhost | where {$_.Name -eq "nchyp19419.cluster.hyperv.drm.lab.emc.com"}
$HardwareProfile = Get-SCHardwareProfile -VMMServer localhost | where {$_.Name -eq "Profile80e64b78-34f5-4098-9eff-93a57f82b6c3"}
$OperatingSystem = Get-SCOperatingSystem -VMMServer localhost -ID "6f8f058d-918e-4eca-bf8d-3c2ac1d7c747" | where {$_.Name -eq "Windows Server 2012 R2 Datacenter"}

New-SCVirtualMachine -VM $VM -Name "SQL_EXPAND1_CLONE2" -Description "" -JobGroup 0325fde1-8357-40cf-98f5-bd9b27e12a67 -UseDiffDiskOptimization -RunAsynchronously -Path "D:\" -VMHost $VMHost -HardwareProfile $HardwareProfile -OperatingSystem $OperatingSystem -StartAction NeverAutoTurnOnVM -StopAction SaveVM 



