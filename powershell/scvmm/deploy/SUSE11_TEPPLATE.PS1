# ------------------------------------------------------------------------------
# Create VM Template Wizard Script
# ------------------------------------------------------------------------------
# Script generated on Tuesday, December 5, 2017 5:41:31 AM by Virtual Machine Manager
# 
# For additional help on cmdlet usage, type get-help <cmdlet name>
# ------------------------------------------------------------------------------


New-SCVirtualScsiAdapter -VMMServer localhost -JobGroup 029fced5-1845-4689-9544-11eff573dc0c -AdapterID 7 -ShareVirtualScsiAdapter $false -ScsiControllerType DefaultTypeNoType 


New-SCVirtualDVDDrive -VMMServer localhost -JobGroup 029fced5-1845-4689-9544-11eff573dc0c -Bus 1 -LUN 0 

$VMNetwork = Get-SCVMNetwork -VMMServer localhost -Name "109" -ID "20159cb4-2bc5-4fbd-8707-16144bb580f0"

New-SCVirtualNetworkAdapter -VMMServer localhost -JobGroup 029fced5-1845-4689-9544-11eff573dc0c -MACAddress "00:00:00:00:00:00" -MACAddressType Static -Synthetic -EnableVMNetworkOptimization $false -EnableMACAddressSpoofing $false -EnableGuestIPNetworkVirtualizationUpdates $false -IPv4AddressType Static -IPv6AddressType Dynamic -VMNetwork $VMNetwork 


Set-SCVirtualCOMPort -NoAttach -VMMServer localhost -GuestPort 1 -JobGroup 029fced5-1845-4689-9544-11eff573dc0c 


Set-SCVirtualCOMPort -NoAttach -VMMServer localhost -GuestPort 2 -JobGroup 029fced5-1845-4689-9544-11eff573dc0c 


Set-SCVirtualFloppyDrive -RunAsynchronously -VMMServer localhost -NoMedia -JobGroup 029fced5-1845-4689-9544-11eff573dc0c 

$CPUType = Get-SCCPUType -VMMServer localhost | where {$_.Name -eq "3.60 GHz Xeon (2 MB L2 cache)"}
$CapabilityProfile = Get-SCCapabilityProfile -VMMServer localhost | where {$_.Name -eq "Hyper-V"}

New-SCHardwareProfile -VMMServer localhost -CPUType $CPUType -Name "Profile880144c5-653a-4fda-bcbe-5f1ac3e046fb" -Description "Profile used to create a VM/Template" -CPUCount 1 -MemoryMB 4096 -DynamicMemoryEnabled $false -MemoryWeight 5000 -VirtualVideoAdapterEnabled $false -CPUExpectedUtilizationPercent 20 -DiskIops 0 -CPUMaximumPercent 100 -CPUReserve 0 -NumaIsolationRequired $false -NetworkUtilizationMbps 0 -CPURelativeWeight 100 -HighlyAvailable $true -HAVMPriority 2000 -DRProtectionRequired $false -CPULimitFunctionality $false -CPULimitForMigration $true -CheckpointType Production -CapabilityProfile $CapabilityProfile -Generation 1 -JobGroup 029fced5-1845-4689-9544-11eff573dc0c 



$VirtualHardDisk = Get-SCVirtualHardDisk -VMMServer localhost | where {$_.Location -eq "\\d1144_smbvm0.cluster.hyperv.drm.lab.emc.com\CLUSTER_TEMPLATE\VHDs\NFSVM_SUSE11.vhdx"} | where {$_.HostName -eq "WIN-VMM2016.cluster.hyperv.drm.lab.emc.com"}

New-SCVirtualDiskDrive -VMMServer localhost -IDE -Bus 0 -LUN 0 -JobGroup bcd0549c-ec3d-4fc1-859d-2d7d5d4231c4 -CreateDiffDisk $false -VirtualHardDisk $VirtualHardDisk -VolumeType BootAndSystem 

$HardwareProfile = Get-SCHardwareProfile -VMMServer localhost | where {$_.Name -eq "Profile880144c5-653a-4fda-bcbe-5f1ac3e046fb"}
$GuestOSProfile = Get-SCGuestOSProfile -VMMServer localhost | where {$_.Name -eq "SUSE11"}

$OperatingSystem = Get-SCOperatingSystem -VMMServer localhost -ID "2cf4d2e5-7809-4679-88e3-66d42bbf2e67" | where {$_.Name -eq "Suse Linux Enterprise Server 11 (64 bit)"}

$template = New-SCVMTemplate -Name "SUSE11_G1" -RunAsynchronously -Generation 1 -HardwareProfile $HardwareProfile -GuestOSProfile $GuestOSProfile -JobGroup bcd0549c-ec3d-4fc1-859d-2d7d5d4231c4 -ComputerName "*" -TimeZone 35  -OperatingSystem $OperatingSystem 


