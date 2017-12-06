$vmName="ORACLE2012"
$SUBNET="10.109.194.0/24"
$IPAddress="10.109.194.167"
$vmLocation="C:\ClusterStorage\Volume2"
$vmTemplate="Oracle_WIN2K12R2_G1"

Get-SCIPAddress –IPAddress $IPAddress | Revoke-SCIPAddress
$Template = Get-SCVMTemplate -VMMServer localhost | where {$_.Name -eq $vmTemplate}
$vmConfig=Get-SCVMConfiguration -all|where{$_.name -eq $vmName}
if($vmConfig -ne $null) { Remove-SCVMConfiguration  -VMConfiguration  $vmConfig
 }
$virtualMachineConfiguration = New-SCVMConfiguration -VMTemplate $Template -Name $vmName
Write-Output $virtualMachineConfiguration
$vmHost = Get-SCVMHost |where{$_.NAME -eq "nchyp19414.cluster.hyperv.drm.lab.emc.com"}
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMHost $vmHost
Update-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration
Set-SCVMConfiguration -VMConfiguration $virtualMachineConfiguration -VMLocation $vmLocation -PinVMLocation $true
$AllNICConfigurations = Get-SCVirtualNetworkAdapterConfiguration -VMConfiguration $virtualMachineConfiguration
$NICConfiguration = Get-SCVirtualNetworkAdapterConfiguration -VMConfiguration $virtualMachineConfiguration | where { $_.IPv4Subnet -eq  $subnet}
if($NICConfiguration -eq $null) { $NICConfiguration = $AllNICConfigurations[0]
 }
Set-SCVirtualNetworkAdapterConfiguration -VirtualNetworkAdapterConfiguration $NICConfiguration -IPv4Address $IPAddress -PinIPv6AddressPool $false -PinMACAddressPool $false
New-SCVirtualMachine -Name $vmName -VMConfiguration $virtualMachineConfiguration -Description "" -BlockDynamicOptimization $false -StartVM  -ReturnImmediately -StartAction "NeverAutoTurnOnVM" -StopAction "SaveVM"