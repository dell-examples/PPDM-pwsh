
$ddvevmname = "mcl-ddve-azlocal"
$ddvehostname = "mcl-ddve-azlocal.edub.csc"
$Destination = "C:\ClusterStorage\CSV01\$ddvevmname\"
$data_disk_size = 1024GB
$data_disk_count = 7

$IPAddress = "10.204.119.9"


$Parameters = @{
    VMName                 = $ddvevmname
    Configuration          = "64TB"
    VirtualMachineHostname = $ddvehostname
    VirtualMachinePath     = $Destination
    VirtualHardDiskPath    = $Destination
    IPAddress              = $IPAddress
    Gateway                = "10.204.118.1"
    Netmask                = "255.255.254.0"
    DnsServer1             = "10.204.108.51"
    DnsServer2             = "10.204.108.52"
}


.\ddve-installer.ps1 @Parameters

$DDVEVM = get-vm $ddvevmname
for ($i = 1; $i -le $data_disk_count ; $i++) { 
    write-host "Creating Data Disk $ddvevmname-data$i.vhdx"
    new-vhd -Path "$Destination\$ddvevmname-data$($i).vhdx" -SizeBytes $data_disk_size
    $DDVEVM | Add-VMHardDiskDrive -ControllerType SCSI -ControllerNumber 0 -Path "$Destination\$ddvevmname-data$($i).vhdx"
}
$DDVEVM | start-vm
