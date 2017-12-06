# ------------------------------------------------------------------------------
# Create Virtual Machine Wizard Script
# ------------------------------------------------------------------------------
# Script generated on Tuesday, December 5, 2017 2:45:40 AM by Virtual Machine Manager
# 
# For additional help on cmdlet usage, type get-help <cmdlet name>
# ------------------------------------------------------------------------------


New-SCVirtualScsiAdapter -VMMServer localhost -JobGroup 8b357a31-ca4a-469d-9eef-d3fa8ede9388 -AdapterID 7 -ShareVirtualScsiAdapter $false -ScsiControllerType DefaultTypeNoType 


New-SCVirtualDVDDrive -VMMServer localhost -JobGroup 8b357a31-ca4a-469d-9eef-d3fa8ede9388 -Bus 0 -LUN 1 

$VMNetwork = Get-SCVMNetwork -VMMServer localhost -Name "109" -ID "20159cb4-2bc5-4fbd-8707-16144bb580f0"

New-SCVirtualNetworkAdapter -VMMServer localhost -JobGroup 8b357a31-ca4a-469d-9eef-d3fa8ede9388 -MACAddressType Dynamic -VLanEnabled $false -Synthetic -EnableVMNetworkOptimization $false -EnableMACAddressSpoofing $false -EnableGuestIPNetworkVirtualizationUpdates $false -IPv4AddressType Dynamic -IPv6AddressType Dynamic -VMNetwork $VMNetwork -DevicePropertiesAdapterNameMode Disabled 

$CPUType = Get-SCCPUType -VMMServer localhost | where {$_.Name -eq "3.60 GHz Xeon (2 MB L2 cache)"}
$CapabilityProfile = Get-SCCapabilityProfile -VMMServer localhost | where {$_.Name -eq "Hyper-V"}

New-SCHardwareProfile -VMMServer localhost -CPUType $CPUType -Name "Profilee8c7bbfd-5947-4084-b9ba-b9cdca0cb04e" -Description "Profile used to create a VM/Template" -CPUCount 1 -MemoryMB 4096 -DynamicMemoryEnabled $false -MemoryWeight 5000 -CPUExpectedUtilizationPercent 20 -DiskIops 0 -CPUMaximumPercent 100 -CPUReserve 0 -NumaIsolationRequired $false -NetworkUtilizationMbps 0 -CPURelativeWeight 100 -HighlyAvailable $true -HAVMPriority 2000 -DRProtectionRequired $false -SecureBootEnabled $true -SecureBootTemplate "MicrosoftWindows" -CPULimitFunctionality $false -CPULimitForMigration $true -CheckpointType Production -CapabilityProfile $CapabilityProfile -Generation 2 -JobGroup 8b357a31-ca4a-469d-9eef-d3fa8ede9388 



$Template = Get-SCVMTemplate -VMMServer localhost -ID "a4664031-256d-40c4-b6fc-35653d79f6f0" | where {$_.Name -eq "WIN2016_G2"}
$HardwareProfile = Get-SCHardwareProfile -VMMServer localhost | where {$_.Name -eq "Profilee8c7bbfd-5947-4084-b9ba-b9cdca0cb04e"}
$GuestOSProfile = Get-SCGuestOSProfile -VMMServer localhost | where {$_.Name -eq "OS_2016"}

$OperatingSystem = Get-SCOperatingSystem -VMMServer localhost -ID "0a393d1e-9050-4142-8e55-a86e4a555013" | where {$_.Name -eq "Windows Server 2016 Datacenter"}

New-SCVMTemplate -Name "Temporary Templateb37a266d-bf89-413d-96b1-750fbb8911c8" -Template $Template -HardwareProfile $HardwareProfile -GuestOSProfile $GuestOSProfile -JobGroup ff8ab880-61a9-4c0c-911a-b4d709da703e -ComputerName "*" -TimeZone 35  -FullName "" -OrganizationName "" -Workgroup "WORKGROUP" -AnswerFile $null -OperatingSystem $OperatingSystem 



$template = Get-SCVMTemplate -All | where { $_.Name -eq "Temporary Templateb37a266d-bf89-413d-96b1-750fbb8911c8" }
$virtualMachineConfiguration = New-SCVMConfiguration -VMTemplate $template -Name "vm2016_from_vhdx"
Write-Output $virtualMachineConfiguration
$vmHost = Get-SCVMHost -ID "5847aa35-61e9-44b5-a17c-5699d64e702d"
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMHost $vmHost
Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMLocation "C:\ClusterStorage\Volume1" -PinVMLocation $true

$AllNICConfigurations = Get-SCVirtualNetworkAdapterConfiguration -VMConfiguration $virtualMachineConfiguration



Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration
New-SCVirtualMachine -Name "vm2016_from_vhdx" -VMConfiguration $virtualMachineConfiguration -Description "" -BlockDynamicOptimization $false -StartVM -JobGroup "ff8ab880-61a9-4c0c-911a-b4d709da703e" -ReturnImmediately -StartAction "NeverAutoTurnOnVM" -StopAction "SaveVM"
