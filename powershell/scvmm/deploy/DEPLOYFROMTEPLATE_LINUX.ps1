# ------------------------------------------------------------------------------
# Create Virtual Machine Wizard Script
# ------------------------------------------------------------------------------
# Script generated on Tuesday, December 5, 2017 6:22:06 AM by Virtual Machine Manager
# 
# For additional help on cmdlet usage, type get-help <cmdlet name>
# ------------------------------------------------------------------------------


New-SCVirtualScsiAdapter -VMMServer localhost -JobGroup daa575d9-25ed-469a-96bd-e334cf774186 -AdapterID 7 -ShareVirtualScsiAdapter $false -ScsiControllerType DefaultTypeNoType 


New-SCVirtualDVDDrive -VMMServer localhost -JobGroup daa575d9-25ed-469a-96bd-e334cf774186 -Bus 1 -LUN 0 

$VMNetwork = Get-SCVMNetwork -VMMServer localhost -Name "109" -ID "20159cb4-2bc5-4fbd-8707-16144bb580f0"

New-SCVirtualNetworkAdapter -VMMServer localhost -JobGroup daa575d9-25ed-469a-96bd-e334cf774186 -MACAddress "00:00:00:00:00:00" -MACAddressType Static -VLanEnabled $false -Synthetic -EnableVMNetworkOptimization $false -EnableMACAddressSpoofing $false -EnableGuestIPNetworkVirtualizationUpdates $false -IPv4AddressType Static -IPv6AddressType Dynamic -VMNetwork $VMNetwork 


Set-SCVirtualCOMPort -NoAttach -VMMServer localhost -GuestPort 1 -JobGroup daa575d9-25ed-469a-96bd-e334cf774186 


Set-SCVirtualCOMPort -NoAttach -VMMServer localhost -GuestPort 2 -JobGroup daa575d9-25ed-469a-96bd-e334cf774186 


Set-SCVirtualFloppyDrive -RunAsynchronously -VMMServer localhost -NoMedia -JobGroup daa575d9-25ed-469a-96bd-e334cf774186 

$CPUType = Get-SCCPUType -VMMServer localhost | where {$_.Name -eq "3.60 GHz Xeon (2 MB L2 cache)"}
$CapabilityProfile = Get-SCCapabilityProfile -VMMServer localhost | where {$_.Name -eq "Hyper-V"}

New-SCHardwareProfile -VMMServer localhost -CPUType $CPUType -Name "Profiled4326ff3-45f4-44d2-9ba3-9eac4f5069b6" -Description "Profile used to create a VM/Template" -CPUCount 1 -MemoryMB 4096 -DynamicMemoryEnabled $false -MemoryWeight 5000 -VirtualVideoAdapterEnabled $false -CPUExpectedUtilizationPercent 20 -DiskIops 0 -CPUMaximumPercent 100 -CPUReserve 0 -NumaIsolationRequired $false -NetworkUtilizationMbps 0 -CPURelativeWeight 100 -HighlyAvailable $true -HAVMPriority 2000 -DRProtectionRequired $false -CPULimitFunctionality $false -CPULimitForMigration $true -CheckpointType Production -CapabilityProfile $CapabilityProfile -Generation 1 -JobGroup daa575d9-25ed-469a-96bd-e334cf774186 



$Template = Get-SCVMTemplate -VMMServer localhost -ID "11c03265-43e9-424e-94b1-e5ed024023f7" | where {$_.Name -eq "SUSE11_G1"}
$HardwareProfile = Get-SCHardwareProfile -VMMServer localhost | where {$_.Name -eq "Profiled4326ff3-45f4-44d2-9ba3-9eac4f5069b6"}

$OperatingSystem = Get-SCOperatingSystem -VMMServer localhost -ID "2cf4d2e5-7809-4679-88e3-66d42bbf2e67" | where {$_.Name -eq "Suse Linux Enterprise Server 11 (64 bit)"}

New-SCVMTemplate -Name "Temporary Templateecded656-b985-4622-8af5-15bc30cd7283" -Template $Template -HardwareProfile $HardwareProfile -JobGroup ac86ce5b-ea4f-4b64-b301-ba1c0c422f2d -ComputerName "*" -TimeZone 35  -OperatingSystem $OperatingSystem 



$template = Get-SCVMTemplate -All | where { $_.Name -eq "Temporary Templateecded656-b985-4622-8af5-15bc30cd7283" }
$virtualMachineConfiguration = New-SCVMConfiguration -VMTemplate $template -Name "nfsv3_suse11"
Write-Output $virtualMachineConfiguration
$vmHost = Get-SCVMHost -ID "f71f4f7b-1517-44fb-b503-1f65edf631e1"
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMHost $vmHost
Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMLocation "\\d1144_smbvm0.cluster.hyperv.drm.lab.emc.com\VM_BASE_IO_AFP\" -PinVMLocation $true

$AllNICConfigurations = Get-SCVirtualNetworkAdapterConfiguration -VMConfiguration $virtualMachineConfiguration

$NICConfiguration = Get-SCVirtualNetworkAdapterConfiguration -VMConfiguration $virtualMachineConfiguration | where { $_.ID -eq "a892e0e9-f9c5-4986-8467-7816dffcde62" }
if($NICConfiguration -eq $null) { $NICConfiguration = $AllNICConfigurations[0]
 }
Set-SCVirtualNetworkAdapterConfiguration -VirtualNetworkAdapterConfiguration $NICConfiguration -IPv4Address "10.109.194.163" -PinIPv6AddressPool $false -PinMACAddressPool $false



Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration
New-SCVirtualMachine -Name "nfsv3_suse11" -VMConfiguration $virtualMachineConfiguration -Description "" -BlockDynamicOptimization $false -StartVM -JobGroup "ac86ce5b-ea4f-4b64-b301-ba1c0c422f2d" -ReturnImmediately -StartAction "NeverAutoTurnOnVM" -StopAction "SaveVM"
