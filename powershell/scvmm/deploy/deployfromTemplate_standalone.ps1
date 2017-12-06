# ------------------------------------------------------------------------------
# Create Virtual Machine Wizard Script
# ------------------------------------------------------------------------------
# Script generated on Tuesday, December 5, 2017 12:34:48 AM by Virtual Machine Manager
# 
# For additional help on cmdlet usage, type get-help <cmdlet name>
# ------------------------------------------------------------------------------


New-SCVirtualScsiAdapter -VMMServer localhost -JobGroup 35077061-e393-4b25-bae0-5a898fbcdd90 -AdapterID 7 -ShareVirtualScsiAdapter $false -ScsiControllerType DefaultTypeNoType 


New-SCVirtualDVDDrive -VMMServer localhost -JobGroup 35077061-e393-4b25-bae0-5a898fbcdd90 -Bus 1 -LUN 0 


New-SCVirtualNetworkAdapter -VMMServer localhost -JobGroup 35077061-e393-4b25-bae0-5a898fbcdd90 -MACAddressType Dynamic -Synthetic -IPv4AddressType Dynamic -IPv6AddressType Dynamic 


Set-SCVirtualCOMPort -NoAttach -VMMServer localhost -GuestPort 1 -JobGroup 35077061-e393-4b25-bae0-5a898fbcdd90 


Set-SCVirtualCOMPort -NoAttach -VMMServer localhost -GuestPort 2 -JobGroup 35077061-e393-4b25-bae0-5a898fbcdd90 


Set-SCVirtualFloppyDrive -RunAsynchronously -VMMServer localhost -NoMedia -JobGroup 35077061-e393-4b25-bae0-5a898fbcdd90 

$CPUType = Get-SCCPUType -VMMServer localhost | where {$_.Name -eq "3.60 GHz Xeon (2 MB L2 cache)"}
$CapabilityProfile = Get-SCCapabilityProfile -VMMServer localhost | where {$_.Name -eq "Hyper-V"}

New-SCHardwareProfile -VMMServer localhost -CPUType $CPUType -Name "Profile75853002-f930-4852-9351-5e0e2f6091fb" -Description "Profile used to create a VM/Template" -CPUCount 2 -MemoryMB 4096 -DynamicMemoryEnabled $false -MemoryWeight 5000 -VirtualVideoAdapterEnabled $false -CPUExpectedUtilizationPercent 20 -DiskIops 0 -CPUMaximumPercent 100 -CPUReserve 0 -NumaIsolationRequired $false -NetworkUtilizationMbps 0 -CPURelativeWeight 100 -HighlyAvailable $false -DRProtectionRequired $false -CPULimitFunctionality $false -CPULimitForMigration $true -CheckpointType Production -CapabilityProfile $CapabilityProfile -Generation 1 -JobGroup 35077061-e393-4b25-bae0-5a898fbcdd90 



$Template = Get-SCVMTemplate -VMMServer localhost -ID "92d6d59e-5699-40ed-80b1-dca9586539bb" | where {$_.Name -eq "SQL_WIN2K12R2_G1"}
$HardwareProfile = Get-SCHardwareProfile -VMMServer localhost | where {$_.Name -eq "Profile75853002-f930-4852-9351-5e0e2f6091fb"}

$OperatingSystem = Get-SCOperatingSystem -VMMServer localhost -ID "0a393d1e-9050-4142-8e55-a86e4a555013" | where {$_.Name -eq "Windows Server 2016 Datacenter"}

New-SCVMTemplate -Name "Temporary Template4a643a76-9ebe-402f-b2b2-a27213698390" -Template $Template -HardwareProfile $HardwareProfile -JobGroup b68b73c6-646b-4db0-ad02-a0ea2d0056c1 -ComputerName "*" -TimeZone 35  -FullName "" -OrganizationName "" -Workgroup "WORKGROUP" -AnswerFile $null -OperatingSystem $OperatingSystem 



$template = Get-SCVMTemplate -All | where { $_.Name -eq "Temporary Template4a643a76-9ebe-402f-b2b2-a27213698390" }
$virtualMachineConfiguration = New-SCVMConfiguration -VMTemplate $template -Name "SQL_EXPAND2"
Write-Output $virtualMachineConfiguration
$vmHost = Get-SCVMHost -ID "2a64f651-e4f9-4f09-bdab-e55cce6fa41a"
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMHost $vmHost
Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMLocation "D:\" -PinVMLocation $true

$AllNICConfigurations = Get-SCVirtualNetworkAdapterConfiguration -VMConfiguration $virtualMachineConfiguration



Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration
New-SCVirtualMachine -Name "SQL_EXPAND2" -VMConfiguration $virtualMachineConfiguration -Description "" -BlockDynamicOptimization $false -StartVM -JobGroup "b68b73c6-646b-4db0-ad02-a0ea2d0056c1" -ReturnImmediately -StartAction "NeverAutoTurnOnVM" -StopAction "SaveVM"
