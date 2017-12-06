# ------------------------------------------------------------------------------
# Create Virtual Machine Wizard Script
# ------------------------------------------------------------------------------
# Script generated on Monday, December 4, 2017 12:02:02 AM by Virtual Machine Manager
# 
# For additional help on cmdlet usage, type get-help <cmdlet name>
# ------------------------------------------------------------------------------


New-SCVirtualScsiAdapter -VMMServer localhost -JobGroup 3c375d75-0904-4021-b870-14854758038e -AdapterID 7 -ShareVirtualScsiAdapter $false -ScsiControllerType DefaultTypeNoType 


New-SCVirtualDVDDrive -VMMServer localhost -JobGroup 3c375d75-0904-4021-b870-14854758038e -Bus 0 -LUN 1 

$VMNetwork = Get-SCVMNetwork -VMMServer localhost -Name "109" -ID "20159cb4-2bc5-4fbd-8707-16144bb580f0"
$PortClassification = Get-SCPortClassification -VMMServer localhost | where {$_.Name -eq "High bandwidth"}

New-SCVirtualNetworkAdapter -VMMServer localhost -JobGroup 3c375d75-0904-4021-b870-14854758038e -MACAddress "00:00:00:00:00:00" -MACAddressType Static -VLanEnabled $false -Synthetic -IPv4AddressType Dynamic -IPv6AddressType Dynamic -VMNetwork $VMNetwork -PortClassification $PortClassification -DevicePropertiesAdapterNameMode Disabled 

$CPUType = Get-SCCPUType -VMMServer localhost | where {$_.Name -eq "3.60 GHz Xeon (2 MB L2 cache)"}
$CapabilityProfile = Get-SCCapabilityProfile -VMMServer localhost | where {$_.Name -eq "Hyper-V"}

New-SCHardwareProfile -VMMServer localhost -CPUType $CPUType -Name "Profile45614cb3-c9ab-4b3d-bac3-7890495f8bb1" -Description "Profile used to create a VM/Template" -CPUCount 1 -MemoryMB 4096 -DynamicMemoryEnabled $false -MemoryWeight 5000 -CPUExpectedUtilizationPercent 20 -DiskIops 0 -CPUMaximumPercent 100 -CPUReserve 0 -NumaIsolationRequired $false -NetworkUtilizationMbps 0 -CPURelativeWeight 100 -HighlyAvailable $true -HAVMPriority 2000 -DRProtectionRequired $false -SecureBootEnabled $true -SecureBootTemplate "MicrosoftWindows" -CPULimitFunctionality $false -CPULimitForMigration $false -CheckpointType Production -CapabilityProfile $CapabilityProfile -Generation 2 -JobGroup 3c375d75-0904-4021-b870-14854758038e 



$Template = Get-SCVMTemplate -VMMServer localhost -ID "a4664031-256d-40c4-b6fc-35653d79f6f0" | where {$_.Name -eq "WIN2016_G2"}
$HardwareProfile = Get-SCHardwareProfile -VMMServer localhost | where {$_.Name -eq "Profile45614cb3-c9ab-4b3d-bac3-7890495f8bb1"}

$OperatingSystem = Get-SCOperatingSystem -VMMServer localhost -ID "0a393d1e-9050-4142-8e55-a86e4a555013" | where {$_.Name -eq "Windows Server 2016 Datacenter"}

New-SCVMTemplate -Name "Temporary Template5595c371-59f0-4941-8a2a-92a845672044" -Template $Template -HardwareProfile $HardwareProfile -JobGroup 3bd425f3-c3a5-4b9c-9b7b-29e5e95a4453 -ComputerName "*" -TimeZone 35  -FullName "" -OrganizationName "" -Workgroup "WORKGROUP" -AnswerFile $null -OperatingSystem $OperatingSystem 



$template = Get-SCVMTemplate -All | where { $_.Name -eq "Temporary Template5595c371-59f0-4941-8a2a-92a845672044" }
$virtualMachineConfiguration = New-SCVMConfiguration -VMTemplate $template -Name "CIFS_ILPD_2016"
Write-Output $virtualMachineConfiguration
$vmHost = Get-SCVMHost -ID "4eb6a113-4e43-423c-8972-138be2e50d03"
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMHost $vmHost
Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMLocation "C:\ClusterStorage\Volume2" -PinVMLocation $true

$AllNICConfigurations = Get-SCVirtualNetworkAdapterConfiguration -VMConfiguration $virtualMachineConfiguration



Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration
New-SCVirtualMachine -Name "CIFS_ILPD_2016" -VMConfiguration $virtualMachineConfiguration -Description "" -BlockDynamicOptimization $false -StartVM -JobGroup "3bd425f3-c3a5-4b9c-9b7b-29e5e95a4453" -ReturnImmediately -StartAction "NeverAutoTurnOnVM" -StopAction "SaveVM"
