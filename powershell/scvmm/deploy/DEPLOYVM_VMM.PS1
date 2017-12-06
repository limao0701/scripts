# ------------------------------------------------------------------------------
# Create Virtual Machine Wizard Script
# ------------------------------------------------------------------------------
# Script generated on Friday, October 27, 2017 6:12:49 AM by Virtual Machine Manager
# 
# For additional help on cmdlet usage, type get-help <cmdlet name>
# ------------------------------------------------------------------------------


New-SCVirtualScsiAdapter -VMMServer localhost -JobGroup b73d27ee-eece-4d70-addf-90e8ce6d799a -AdapterID 7 -ShareVirtualScsiAdapter $false -ScsiControllerType DefaultTypeNoType 


New-SCVirtualDVDDrive -VMMServer localhost -JobGroup b73d27ee-eece-4d70-addf-90e8ce6d799a -Bus 0 -LUN 1 


New-SCVirtualNetworkAdapter -VMMServer localhost -JobGroup b73d27ee-eece-4d70-addf-90e8ce6d799a -MACAddressType Dynamic -Synthetic -IPv4AddressType Dynamic -IPv6AddressType Dynamic 

$CPUType = Get-SCCPUType -VMMServer localhost | where {$_.Name -eq "3.60 GHz Xeon (2 MB L2 cache)"}
$CapabilityProfile = Get-SCCapabilityProfile -VMMServer localhost | where {$_.Name -eq "Hyper-V"}

New-SCHardwareProfile -VMMServer localhost -CPUType $CPUType -Name "Profilee1bece80-28ee-44af-a6b7-b96ec5136a44" -Description "Profile used to create a VM/Template" -CPUCount 1 -MemoryMB 4096 -DynamicMemoryEnabled $false -MemoryWeight 5000 -CPUExpectedUtilizationPercent 20 -DiskIops 0 -CPUMaximumPercent 100 -CPUReserve 0 -NumaIsolationRequired $false -NetworkUtilizationMbps 0 -CPURelativeWeight 100 -HighlyAvailable $false -DRProtectionRequired $false -SecureBootEnabled $true -SecureBootTemplate "MicrosoftWindows" -CPULimitFunctionality $false -CPULimitForMigration $false -CheckpointType Production -CapabilityProfile $CapabilityProfile -Generation 2 -JobGroup b73d27ee-eece-4d70-addf-90e8ce6d799a 



$VirtualHardDisk = Get-SCVirtualHardDisk -VMMServer localhost | where {$_.Location -eq "\\D1071NEMO07\cifs_all_template_vmm\vhdx\win2016Basic.vhdx"} | where {$_.HostName -eq "WIN-VMM2016.cluster.hyperv.drm.lab.emc.com"}

New-SCVirtualDiskDrive -VMMServer localhost -SCSI -Bus 0 -LUN 0 -JobGroup 546e8fa0-769a-455a-8f61-c935cb60bdbe -CreateDiffDisk $false -VirtualHardDisk $VirtualHardDisk -FileName "WIN16_VDBENCH_win2016Basic.vhdx" -VolumeType BootAndSystem 

$HardwareProfile = Get-SCHardwareProfile -VMMServer localhost | where {$_.Name -eq "Profilee1bece80-28ee-44af-a6b7-b96ec5136a44"}

New-SCVMTemplate -Name "Temporary Templated79e839d-0f32-4131-8206-ad8992e16dd8" -Generation 2 -HardwareProfile $HardwareProfile -JobGroup 546e8fa0-769a-455a-8f61-c935cb60bdbe -NoCustomization 



$template = Get-SCVMTemplate -All | where { $_.Name -eq "Temporary Templated79e839d-0f32-4131-8206-ad8992e16dd8" }
$virtualMachineConfiguration = New-SCVMConfiguration -VMTemplate $template -Name "WIN16_VDBENCH"
Write-Output $virtualMachineConfiguration
$vmHost = Get-SCVMHost -ID "ef9dc8d4-984d-43ce-83b1-913248dc394d"
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMHost $vmHost
Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration

$AllNICConfigurations = Get-SCVirtualNetworkAdapterConfiguration -VMConfiguration $virtualMachineConfiguration



Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration
$operatingSystem = Get-SCOperatingSystem | where { $_.Name -eq "Windows Server 2016 Datacenter" }
New-SCVirtualMachine -Name "WIN16_VDBENCH" -VMConfiguration $virtualMachineConfiguration -Description "" -BlockDynamicOptimization $false -StartVM -JobGroup "546e8fa0-769a-455a-8f61-c935cb60bdbe" -ReturnImmediately -StartAction "NeverAutoTurnOnVM" -StopAction "SaveVM" -OperatingSystem $operatingSystem
