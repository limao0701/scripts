# ------------------------------------------------------------------------------
# Create Virtual Machine Wizard Script
# ------------------------------------------------------------------------------
# Script generated on Tuesday, December 5, 2017 3:20:49 AM by Virtual Machine Manager
# 
# For additional help on cmdlet usage, type get-help <cmdlet name>
# ------------------------------------------------------------------------------


New-SCVirtualScsiAdapter -VMMServer localhost -JobGroup 1e9381c9-4579-46c2-a515-de738e516613 -AdapterID 255 -ShareVirtualScsiAdapter $false -ScsiControllerType DefaultTypeNoType 


New-SCVirtualDVDDrive -VMMServer localhost -JobGroup 1e9381c9-4579-46c2-a515-de738e516613 -Bus 0 -LUN 1 


New-SCVirtualNetworkAdapter -VMMServer localhost -JobGroup 1e9381c9-4579-46c2-a515-de738e516613 -MACAddress "00:1D:D8:B7:1C:14" -MACAddressType Static -Synthetic -IPv4AddressType Dynamic -IPv6AddressType Dynamic 

$CPUType = Get-SCCPUType -VMMServer localhost | where {$_.Name -eq "3.60 GHz Xeon (2 MB L2 cache)"}
$CapabilityProfile = Get-SCCapabilityProfile -VMMServer localhost | where {$_.Name -eq "Hyper-V"}

New-SCHardwareProfile -VMMServer localhost -CPUType $CPUType -Name "Profilebe1ce6bf-d3b9-4fc8-9dc5-b26b90a00494" -Description "Profile used to create a VM/Template" -CPUCount 1 -MemoryMB 2048 -DynamicMemoryEnabled $false -MemoryWeight 5000 -CPUExpectedUtilizationPercent 20 -DiskIops 0 -CPUMaximumPercent 100 -CPUReserve 0 -NumaIsolationRequired $false -NetworkUtilizationMbps 0 -CPURelativeWeight 100 -HighlyAvailable $false -DRProtectionRequired $false -SecureBootEnabled $true -SecureBootTemplate "MicrosoftWindows" -CPULimitFunctionality $false -CPULimitForMigration $true -CheckpointType Production -CapabilityProfile $CapabilityProfile -Generation 2 -JobGroup 1e9381c9-4579-46c2-a515-de738e516613 



$VirtualNetworkAdapter = Get-SCVirtualNetworkAdapter -VMMServer localhost -Name "vmclone_FILE" -ID "7300cf17-d57b-4db5-85af-92948cde4d67"

Set-SCVirtualNetworkAdapter -VirtualNetworkAdapter $VirtualNetworkAdapter -NoLogicalNetwork -VirtualNetwork "external" -MACAddressType Static -IPv4AddressType Dynamic -IPv6AddressType Dynamic -NoPortClassification -EnableVMNetworkOptimization $false -EnableMACAddressSpoofing $false -JobGroup f28d90e6-176c-4aa0-a547-cd9ca9b937e4 

$VM = Get-SCVirtualMachine -VMMServer localhost -Name "vmclone_FILE" -ID "660b94f4-0b50-43e1-8579-9f80ac9d41e6" | where {$_.VMHost.Name -eq "nchyp19419.cluster.hyperv.drm.lab.emc.com"}
$VMHost = Get-SCVMHost -VMMServer localhost | where {$_.Name -eq "nchyp19419.cluster.hyperv.drm.lab.emc.com"}
$HardwareProfile = Get-SCHardwareProfile -VMMServer localhost | where {$_.Name -eq "Profilebe1ce6bf-d3b9-4fc8-9dc5-b26b90a00494"}
$OperatingSystem = Get-SCOperatingSystem -VMMServer localhost -ID "0a393d1e-9050-4142-8e55-a86e4a555013" | where {$_.Name -eq "Windows Server 2016 Datacenter"}

New-SCVirtualMachine -VM $VM -Name "vmclone_FILE_clone1" -Description "" -JobGroup f28d90e6-176c-4aa0-a547-cd9ca9b937e4 -UseDiffDiskOptimization -RunAsynchronously -Path "\\D1144_SMBVM0\SCVMM_CLONE" -VMHost $VMHost -HardwareProfile $HardwareProfile -OperatingSystem $OperatingSystem -StartAction NeverAutoTurnOnVM -StopAction SaveVM 



