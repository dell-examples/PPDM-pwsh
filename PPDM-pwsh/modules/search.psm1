function Get-PPDMsearch_nodes {
    [CmdletBinding()]
    param(

        [Parameter(Mandatory = $true, ParameterSetName = 'ALL', ValueFromPipelineByPropertyName = $true)]
        $id,
        [Parameter(Mandatory = $false, ParameterSetName = 'ALL', ValueFromPipelineByPropertyName = $true)]
        $filter,
        #       [ValidateSet()]
        #       [Alias('AssetType')][string]$type,
        [Parameter(Mandatory = $false, ParameterSetName = 'ALL', ValueFromPipelineByPropertyName = $true)]
        $pageSize, 
        [Parameter(Mandatory = $false, ParameterSetName = 'ALL', ValueFromPipelineByPropertyName = $true)]
        $page, 
        [Parameter(Mandatory = $false, ParameterSetName = 'ALL', ValueFromPipelineByPropertyName = $true)]
        [hashtable]$body = @{orderby = 'createdAt DESC' },
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]                
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v2"
    )

    begin {
        $Response = @()
        $METHOD = "GET"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "-").ToLower()
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            'ALL' {
                $URI = "search-clusters/$id/nodes"
                $body = @{}  

            }
            default {
                $URI = "search-clusters/$id/nodes"
            }
        }  
        if ($pagesize) {
            $body.add('pageSize', $pagesize)
        }
        if ($page) {
            $body.add('page', $page)
        }   
        $Parameters = @{
            RequestMethod    = 'REST'
            body             = $body
            Uri              = $URI
            Method           = $Method
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
        }
        if ($type) {
            if ($filter) {
                $filter = 'type eq "' + $type + '" and ' + $filter 
            }
            else {
                $filter = 'type eq "' + $type + '"'
            }
        }        
        if ($filter) {
            $parameters.Add('filter', $filter)
        }       
        try {
            $Response += Invoke-PPDMapirequest @Parameters
        }
        catch {
            Get-PPDMWebException  -ExceptionMessage $_
            break
        }
        write-verbose ($response | Out-String)
    } 
    end {    
        switch ($PsCmdlet.ParameterSetName) {
            'byID' {
                write-output $response 
            }
            default {
                write-output $response.content
                if ($response.page) {
                    write-host ($response.page | out-string)
                }
            } 
        }   
    }
}

function Get-PPDMsearch_clusters {
    [CmdletBinding()]
    param(

        [Parameter(Mandatory = $true, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $id,
        [Parameter(Mandatory = $false, ParameterSetName = 'ALL', ValueFromPipelineByPropertyName = $true)]
        $filter,
        #       [ValidateSet()]
        #       [Alias('AssetType')][string]$type,
        [Parameter(Mandatory = $false, ParameterSetName = 'ALL', ValueFromPipelineByPropertyName = $true)]
        $pageSize, 
        [Parameter(Mandatory = $false, ParameterSetName = 'ALL', ValueFromPipelineByPropertyName = $true)]
        $page, 
        [Parameter(Mandatory = $false, ParameterSetName = 'ALL', ValueFromPipelineByPropertyName = $true)]
        [hashtable]$body = @{orderby = 'createdAt DESC' },
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]                
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v2"
    )

    begin {
        $Response = @()
        $METHOD = "GET"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "-").ToLower()
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            'byID' {
                $URI = "/$myself/$id"
                $body = @{}  

            }
            default {
                $URI = "/$myself"
            }
        }  
        if ($pagesize) {
            $body.add('pageSize', $pagesize)
        }
        if ($page) {
            $body.add('page', $page)
        }   
        $Parameters = @{
            RequestMethod    = 'REST'
            body             = $body
            Uri              = $URI
            Method           = $Method
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
        }
        if ($type) {
            if ($filter) {
                $filter = 'type eq "' + $type + '" and ' + $filter 
            }
            else {
                $filter = 'type eq "' + $type + '"'
            }
        }        
        if ($filter) {
            $parameters.Add('filter', $filter)
        }       
        try {
            $Response += Invoke-PPDMapirequest @Parameters
        }
        catch {
            Get-PPDMWebException  -ExceptionMessage $_
            break
        }
        write-verbose ($response | Out-String)
    } 
    end {    
        switch ($PsCmdlet.ParameterSetName) {
            'byID' {
                write-output $response 
            }
            default {
                write-output $response.content
                if ($response.page) {
                    write-host ($response.page | out-string)
                }
            } 
        }   
    }
}


<#
.SYNOPSIS
Deploy a search Node
# Get the vCenter Inventory Source
$InventorySource=Get-PPDMinventory_sources -Type VCENTER -filter 'name lk "vcsa1%"'

## By CLuster

# Get Search Cluszter ID:
$ID=(Get-PPDMsearch_clusters).ID

# Get ESX Cluster Moref

(Get-PPDMhosts -filter "inventorySourceId eq `"$($InventorySource.id)`"  and name eq `"home_cluster`"").details.esxcluster

$NetworkMoref=((Get-PPDMhosts -hosttype ESX_CLUSTER -filter 'name eq "home_cluster" and status eq "DETECTED"').details.esxcluster.networks | where name -eq VLAN250).moref
$ClusterMoref=((Get-PPDMhosts -hosttype ESX_CLUSTER -filter 'name eq "home_cluster" and status eq "DETECTED"').details.esxcluster.clusterMoref)


$VCenterID=(Get-PPDMinventory_sources -Type VCENTER -filter 'name lk "vcsa1%"').id
$DatastoreMoref=(Get-PPDMvcenterDatastores -id $VCenterID -clusterMOREF $clusterMoref | where name -match vsanDatastore).moref

New-PPDMsearch_nodes -ID $ID -InventorySourceId $InventorySource.id -fqdn ppdmidx1.home.labbuildr.com -IPAddress 100.250.1.167 -gateway 100.250.1.1 -netmask 255.255.255.0 -dnsServers 192.168.1.44 -ClusterMoref $ClusterMoref -DatastoreMoref $DatastoreMoref -NetworkMoref $NetworkMoref
#>
function New-PPDMsearch_nodes {
    [CmdletBinding()]
    param(
     
        [Parameter(Mandatory = $true, ParameterSetName = 'byCluster', ValueFromPipelineByPropertyName = $true)]  
        $fqdn,
        [Parameter(Mandatory = $true, ParameterSetName = 'byCluster', ValueFromPipelineByPropertyName = $true)]  
        [ipaddress]$IPAddress,        
        [Parameter(Mandatory = $true, ParameterSetName = 'byHost', ValueFromPipelineByPropertyName = $true)]        
        [Parameter(Mandatory = $true, ParameterSetName = 'byCluster', ValueFromPipelineByPropertyName = $true)]  
        [ipaddress]$gateway,
        [Parameter(Mandatory = $true, ParameterSetName = 'byHost', ValueFromPipelineByPropertyName = $true)]        
        [Parameter(Mandatory = $true, ParameterSetName = 'byCluster', ValueFromPipelineByPropertyName = $true)]  
        [ipaddress]$netmask,
        [Parameter(Mandatory = $true, ParameterSetName = 'byHost', ValueFromPipelineByPropertyName = $true)]        
        [Parameter(Mandatory = $true, ParameterSetName = 'byCluster', ValueFromPipelineByPropertyName = $true)]  
        [ipaddress[]]$dnsServers,
        [Parameter(Mandatory = $true, ParameterSetName = 'byHost', ValueFromPipelineByPropertyName = $true)]        
        [string]$HostMoref, 
        [Parameter(Mandatory = $true, ParameterSetName = 'byCluster', ValueFromPipelineByPropertyName = $true)]        
        [string]$ClusterMoref, 
        [Parameter(Mandatory = $true, ParameterSetName = 'byHost', ValueFromPipelineByPropertyName = $true)]  
        [Parameter(Mandatory = $true, ParameterSetName = 'byCluster', ValueFromPipelineByPropertyName = $true)]  
        [string]$DatastoreMoref,                           
        [Parameter(Mandatory = $true, ParameterSetName = 'byHost', ValueFromPipelineByPropertyName = $true)]        
        [Parameter(Mandatory = $true, ParameterSetName = 'byCluster', ValueFromPipelineByPropertyName = $true)]  
        [string]$NetworkMoref, 
        [Parameter(Mandatory = $true, ParameterSetName = 'byHost', ValueFromPipelineByPropertyName = $true)]        
        [Parameter(Mandatory = $true, ParameterSetName = 'byCluster', ValueFromPipelineByPropertyName = $true)]  
        [string]$ID,
        [Parameter(Mandatory = $true, ParameterSetName = 'byHost', ValueFromPipelineByPropertyName = $true)]        
        [Parameter(Mandatory = $true, ParameterSetName = 'byCluster', ValueFromPipelineByPropertyName = $true)]  
        [string]$InventorySourceId,        
        [switch]$noop,
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        $apiver = "/api/v2"
    )

    begin {
        $Response = @()
        $METHOD = "POST"

    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            default {
                $URI = "/search-clusters/$ID/nodes"
            }
        }
        $body = [ordered]@{
            inventorySourceId = $inventorySourceId
            hostName = $fqdn
            deploymentConfig  = [ordered]@{
                additionalVMNetworks = @() 
                networkMoref    = $NetworkMoref
                dns      = $dnsServers.IPAddressToString
                fqdn            = $fqdn
                gateway         = $gateway.IPAddressToString
                ipAddress       = $IPAddress.IPAddressToString
                ipProtocol = "IPv4"
                netMask         = $NetMask.IPAddressToString
                location = [ordered] @{
                    clusterMoref   = $ClusterMoref -replace 'ClusterComputeResource:'
                    datastoreMoref = $DatastoreMoref -replace 'Datastore:'
                }
            }
                   
        } | convertto-json -depth 4
        
        Write-Verbose ($body | Out-String)  
        $Parameters = @{
            body             = $body 
            Uri              = $Uri
            Method           = $Method
            RequestMethod    = 'Rest'
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
        }
        if (!$noop) {     
            try {
                $Response += Invoke-PPDMapirequest @Parameters
            }
            catch {
                Get-PPDMWebException  -ExceptionMessage $_
                break
            }
            write-verbose ($response | Out-String)
        }
    } 
    end {    
        switch ($PsCmdlet.ParameterSetName) {

            default {
                write-output $response
            } 
        }   
    }

}

