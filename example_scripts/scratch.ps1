# Changing the Network Interface of a known, protected Asset:
$PPDMSytem="ppdm-demo.home.labbuildr.com" 
$AssetType="VMWARE_VIRTUAL_MACHINE"
$AssetName="surfer01"
$NetworkAddress="100.240.1.114"
connect-PPDMSystem -PPDM_API_BaseURI $PPDMSytem -trustCert 



$Asset=Get-PPDMassets -filter "name eq `"$AssetName`" and type eq `"$AssetType`" and status eq `"AVAILABLE`" and protectionStatus eq `"PROTECTED`"" 
$StorageUnit=(Get-PPDMcopy_map -AssetID $Asset.id).storageLocations[0].storageUnits
$DataTarget = Get-PPDMdata_targets -ID $STorageUnit.id


## Get Network Assignement

Get-PPDMAssetNetworkAssignments -assetID $Asset.id -dataTargetId $DataTarget.id

# Change a networ Assignment

# List the Network Interfaces of DD System(s)
Get-PPDMStorageInterfacesDD

# select an Appropriate Nic from Above
$Interface=Get-PPDMStorageInterfacesDD | where networkAddress -match $NetworkAddress

# Set the new Label:
Set-PPDMassetNetwork -id $Asset.id -networkLabel $Interface.networkLabel


