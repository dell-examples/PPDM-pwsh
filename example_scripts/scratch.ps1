# Changing the Network Interface of a known, protected Asset:


$Asset=Get-PPDMassets -filter 'name eq "surfer01" and type eq "VMWARE_VIRTUAL_MACHINE" and status eq "AVAILABLE" and protectionStatus eq "PROTECTED"'

$StorageUnit=(Get-PPDMcopy_map -AssetID $Asset.id).storageLocations.storageUnits

$DataTarget = Get-PPDMdata_targets -ID $STorageUnit.id


## Get Aetwork Assignement

Get-PPDMAssetNetworkAssignments -assetID $Asset.id -dataTargetId $DataTarget.id

# Change a networ Assignment

# List the Network Interfaces of DD System(s)
Get-PPDMStorageInterfacesDD

# select an Appropriate Nic from Above
$Interface=Get-PPDMStorageInterfacesDD | where networkAddress -match "100.240.1.114"

# Set the new Label:
Set-PPDMassetNetwork -id $Asset.id -networkLabel $Interface.networkLabel


