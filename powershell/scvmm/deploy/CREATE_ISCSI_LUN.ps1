$pool = Get-SCStoragePool -ID "4ec1d339-4f9c-4cfd-9b40-5abc0fa7e763" -Name "AFP_D"
$newLun = New-SCStorageLogicalUnit -StoragePool $pool -DiskSizeMB 512000 -Name "SCVMM_ISCSI_EXPAND0" -Description "" -ProvisioningType "Thin"
$hostGroup = Get-SCVMHostGroup -ID "de4859f6-f158-47aa-aaaf-5c0523f1a495"
Set-SCStorageLogicalUnit -StorageLogicalUnit $newLun -VMHostGroup $hostGroup
