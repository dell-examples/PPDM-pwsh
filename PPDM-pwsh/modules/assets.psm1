
<#
.Synopsis
Retrieves all assets that PowerProtect Data Manager manages
.Description
Retrieve information about protected assets. 
Supports Pagination and PPDM Filetr Queries

.Example
Get assets using a PPDM Filter Expression
Get-PPDMassets -body @{pageSize=20} -filter 'name lk "%PRESS%"' | ft
.Example
Get all Assets using Pagination
Get-PPDMassets -body @{pageSize=10;page=2}
.Example
Filter PVC´s based on storageClassName
Get-PPDMassets -filter 'subtype eq "K8S_PERSISTENT_VOLUME_CLAIM" and details.k8s.persistentVolumeClaim.storageClassName eq "thin-csi-immediate" and details.k8s.persistentVolumeClaim.excluded eq "FALSE"'
.EXAMPLE
# Get the Host Detail of a SQL Database Asset
Get-PPDMassets -AssetType MICROSOFT_SQL_DATABASE -filter {name lk "Adventure%2019"} | Get-PPDMassets -Hosts
#>
function Get-PPDMassets {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        [alias('assetIds')]$id,
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [alias('assetHosts')]
        [switch]$Hosts,
        [Parameter(Mandatory = $false, ParameterSetName = 'byID')]
        [switch]$activeHosts,                    
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $false)]
        $filter,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $false)]
        [ValidateSet(
            'VMAX_STORAGE_GROUP',
            'VMWARE_VIRTUAL_MACHINE',
            'ORACLE_DATABASE',
            'MICROSOFT_SQL_DATABASE',
            'FILE_SYSTEM',
            'KUBERNETES',
            'MICROSOFT_EXCHANGE_DATABASE',
            'SAP_HANA_DATABASE',
            'NAS_SHARE',
            'CLOUD_NATIVE_ENTITY',
            'POWERSTORE_BLOCK',
            'CLOUD_DIRECTOR_VAPP',
            'DR',
            'POWER_MAX_BLOCK',
            'HYPERV_VIRTUAL_MACHINE',
            'GENERIC_APPLICATION_ASSET'
        )]
        [Alias('AssetType')][string]$type,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $pageSize, 
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $page,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]              
        [hashtable]$body = @{orderby = 'createdAt DESC' },
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v2"
    )
    begin {
        #        $Response = @{}
        $METHOD = "GET"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "/").ToLower()
        $Response = @()   
    }
      
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            'byID' {
                if (!$Hosts -and $activeHosts) {
                    $URI = "/$myself/$id/active-hosts"
                }                
                if ($Hosts -and $activeHosts) {
                    $URI = "/$myself/$id/active-hosts"
                }
                if ($Hosts -and !$activeHosts) {
                    $URI = "/$myself/$id/hosts"
                }
                if (!$hosts -and !$activehosts) {
                    $URI = "/$myself/$id"                    
                }
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
                if ($hosts.isPresent) {
                    write-output $response.content 
                }
                else {
                    write-output $response  
                }
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
# /api/v2/assets/{id}/copy-map
# /api/v2/assets

function Get-PPDMasset_protection_metrics {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $filter,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v2",
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        [hashtable]$body = @{pageSize = 200 }  
    )
    begin {
        $Response = @()
        $METHOD = "GET"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "-").ToLower()
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            default {
                $URI = "/$myself"
            }
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
                write-output $response.contents
            } 
        }   
    }

}

<#
.SYNOPSIS
'Retrieves copy map of the specified asset
.EXAMPLE
Get-PPDMassets -filter 'name eq "scale002" and protectionStatus eq "PROTECTED" and details.k8s.inventorySourceName eq "api.ocs1.home.labbuildr.com"' | Get-PPDMcopy_map

#>
function Get-PPDMcopy_map {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        [Alias('AssetID')]$id,
        [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        [ValidateSet(
            'DELETED', 'DELETING', 'DELETE_FAILED', 'SOFT_DELETED'
        )]
        [string[]]$excludeCopyState,

        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        $apiver = "/api/v2"

    )
    begin {
        $Response = @()
        $METHOD = "GET"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "-").ToLower()
        $body = @{}
        if ($excludeCopyState) {
            $body.Add('excludeCopyState', ($excludeCopyState -join ","))
        }        
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            'byID' {
                $URI = "/assets/$id/$myself"
            }
            default {
                $URI = "/assets/$id/$myself"
            }
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
                write-output $response 
            } 
        }   
    }
}

<#
.Synopsis
'Retrieves all copies of the asset by the specified asset ID.
> This endpoint supports execution by the following roles: Administrator, User, Backup Administrator, Restore Administrator, Security Administrator
> This endpoint supports pagination with types: random
'
.Description
Retrieve Asset Copie. Supports PPDM Filters and Pagination
.Example
Get-PPDMassetcopies -id $Asset.id -pageSize 2
.Example
Filter using PPDM Filters, not older than 2 Hours
$myDate=(get-date).AddHours(-2)
$usedate=get-date $myDate -Format yyyy-MM-ddThh:mm:ssZ
$filter= 'endTime ge "'+$usedate+'"'
Get-PPDMassetcopies -AssetID $AssetID -filter $filter

#>
function Get-PPDMassetcopies {
    [CmdletBinding()]
    param(

        [Parameter(Mandatory = $true, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        [Alias('AssetID')]$id,
        [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $filter,
        [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $pageSize, 
        [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $page, 
        [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        [hashtable]$body = @{orderby = 'createdAt DESC' },
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]                
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v2"  
    )
    begin {
        $Response = @()
        $METHOD = "GET"
        
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {

            default {
                $URI = "/assets/$id/copies"
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
        if ($filter) {
            $parameters.Add('filter', $filter)
        }         
        try {
            $Response += Invoke-PPDMapirequest @parameters
        }
        catch {
            Get-PPDMWebException  -ExceptionMessage $_
            break
        }
        write-verbose ($response | Out-String)
    } 
    end {    
        switch ($PsCmdlet.ParameterSetName) {
            default {
                write-output $response.content
                if ($response.page) {
                    write-host ($response.page | out-string)
                }
            } 
        }   
    }
}

# /api/v2/assets
function Get-PPDMprotection_rules {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $id,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $filter,

        [ValidateSet(
            'VMAX_STORAGE_GROUP',
            'VMWARE_VIRTUAL_MACHINE',
            'ORACLE_DATABASE',
            'MICROSOFT_SQL_DATABASE',
            'FILE_SYSTEM',
            'KUBERNETES',
            'MICROSOFT_EXCHANGE_DATABASE',
            'SAP_HANA_DATABASE',
            'NAS_SHARE',
            'CLOUD_NATIVE_ENTITY',
            'POWERSTORE_BLOCK',
            'CLOUD_DIRECTOR_VAPP',
            'DR',
            'POWER_MAX_BLOCK',
            'HYPERV_VIRTUAL_MACHINE'
        )]
        [Alias('AssetType')][string]$type,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $pageSize, 
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $page, 
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
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
                $filter = 'inventorySourceType eq "' + $type + '" and ' + $filter 
            }
            else {
                $filter = 'inventorySourceType eq "' + $type + '"'
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



# PUT /api/v2/protection-rules/{id}


function Set-PPDMprotection_rules {
    [CmdletBinding()]
    param(
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        $apiver = "/api/v2",
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [array]$Protection_rule
    )
    begin {
        $Response = @()
        $METHOD = "PUT"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "-").ToLower()
   
    }     
    Process {
        $body = $Protection_rule | convertto-json -Depth 10
        switch ($PsCmdlet.ParameterSetName) {
            default {
                $URI = "/$myself/$($Protection_rule.id)"            
            }
        }
        write-verbose ($body | Out-String)  
        $Parameters = @{
            body             = $body 
            Uri              = $Uri
            Method           = $Method
            RequestMethod    = 'Rest'
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            ContentType      = "application/json"
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
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
            default {
                write-output $response
            } 
        }   
    }
}

# 
# DELETE /api/v2/protection-rules/{id}
function Remove-PPDMprotection_rules {
    [CmdletBinding()]
    param(

        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $id,
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        $apiver = "/api/v2"
    )
    begin {
        $Response = @()
        $METHOD = "DELETE"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(11) -replace "_", "-").ToLower()
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            default {
                $URI = "/$myself/$id"
            }
        }   
        $Parameters = @{
            body             = $body 
            Uri              = $Uri
            Method           = $Method
            RequestMethod    = 'WEB'
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            ContentType      = "application/json"
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
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

            default {
                write-output $response.headers.date 
            } 
        }   
    }
}

# GET /api/v2/common-settings/VM_BACKUP_SETTING

function Get-PPDMvm_backup_setting {
    [CmdletBinding()]
    param(
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        $apiver = "/api/v2"
    )
    begin {
        $Response = @()
        $METHOD = "GET"
        $Myself = "common-settings/VM_BACKUP_SETTING"
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            default {
                $URI = "/$myself"
            }
        }        
        $Parameters = @{
            body             = $body 
            Uri              = $Uri
            Method           = $Method
            RequestMethod    = 'Rest'
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            ContentType      = "application/json"
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
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
                write-output $response
            } 
        }   
    }
}

function Set-PPDMvm_backup_setting {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [array]$vm_backup_setting,       
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        $apiver = "/api/v2"
    )
    begin {
        $Response = @()
        $METHOD = "PUT"
        $Myself = "common-settings/VM_BACKUP_SETTING"
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            default {
                $URI = "/$myself"
            }
        }
        $body = $vm_backup_setting | ConvertTo-Json -Depth 10        
        $Parameters = @{
            body             = $body 
            Uri              = $Uri
            Method           = $Method
            RequestMethod    = 'Rest'
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            ContentType      = "application/json"
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
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
                write-output $response
            } 
        }   
    }
}





<#
.Synopsis
Retrieves all host hosts that PowerProtect Data Manager manages
.Description
Retrieves all Hosts including PRIMARY, GROUP, APP_HOST, ESX_HOST, ESX_CLUSTER, MSSQL, ORACLE, and Filesystem.
Supports Pagination and PPDM Filetr Queries
Predefined Hosttype Filters can be combined with and filters
.Example
Get hosts using a hosttype and PPDM Filter Expression 
Get-PPDMhosts -filter 'status eq "AVAILABLE"' -hosttype ESX_HOST
.Example
Get all Hosts using Pagination
Get-PPDMhosts -body @{pageSize=10;page=2}
#>
function Get-PPDMhosts {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $id,
        [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        [switch]$validaddresses,        
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('PRIMARY', 'GROUP', 'APP_HOST', 'ESX_HOST', 'ESX_CLUSTER', 'MSSQL', 'ORACLE', 'Filesystem')]
        [alias('hosttype')]$type,        
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $filter,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $pageSize, 
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $page, 
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [hashtable]$body = @{orderby = 'createdAt DESC' },
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]                
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v2"
    )
    begin {
        $Response = @()
        $METHOD = "GET"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "/").ToLower()
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            'byID' {
                If ($validaddresses.IsPresent) {
                    $URI = "/app-hosts/$id/valid-addresses"
                }
                else { $URI = "/$myself/$id" }

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
            write-verbose ($filter | Out-String)
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
.Synopsis
Patch Asset Properties by Patching Configuration Object
.Description
Modify Asset related Settings, e.g. Disk Exclusions etc base on Config Object retrived via Get-Assets
.Example
# Modify all Assets of type VMWARE_VIRTUAL_MACHINE with PROTECTED status that have 4+ Hard Disks 
$Assets = Get-PPDMassets -filter 'type eq "VMWARE_VIRTUAL_MACHINE" and details.vm.disks.label lk "Hard disk 4" and protectionStatus eq "PROTECTED"'
foreach ($asset in $Assets) {
    $disks = $asset.details.vm.disks | Sort-Object label
    write-host "We have $($disks.count)"
    for ($i = 3; $i -lt $disks.count ; $i++) { 
        write-host " Excluding  $($disks[$i].label)"
        $disks[$i].excluded = "True" 
    }
    $asset.details.vm.disks = $disks
    write-host "sending Patch request"
    Set-PPDMasset -id $($asset.id) -configobject $asset
}

#>
function Set-PPDMassets {
    [CmdletBinding()]
    [Alias('Set-PPDMAsset')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        $id,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        $configobject,        
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        $apiver = "/api/v2"

    )
    begin {
        $Response = @()
        $METHOD = "PATCH"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "-").ToLower()
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            default {
                $URI = "/$myself/$id"
            }
        }
        $body = $configobject | ConvertTo-json -Depth 7 
        write-verbose ($body | out-string)
        $Parameters = @{
            RequestMethod    = 'REST'
            body             = $body
            Uri              = $URI
            Method           = $Method
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
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
            default {
                write-output ($response)
            } 
        }   
    }
}

function Set-PPDMapp_hosts {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'address', ValueFromPipelineByPropertyName = $true)]
        $id,
        [Parameter(Mandatory = $false, ParameterSetName = 'address', ValueFromPipelineByPropertyName = $true)]
        [switch]$preferredaddress,        
        [Parameter(Mandatory = $true, ParameterSetName = 'address', ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('IPV6', 'IPV4', 'FQDN')][string]$type,
        [Parameter(Mandatory = $true, ParameterSetName = 'address', ValueFromPipelineByPropertyName = $true)]
        [string]$value,                
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        $apiver = "/api/v2"

    )
    begin {
        $Response = @()
        $METHOD = "PATCH"
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            default {
                $URI = "app-hosts/$ID/preferred-address"
            }
        }
        $body = @{}
        $body.add('type', $type)
        $body.add('value', $value)
        $body = $body | ConvertTo-Json
        write-verbose ($body | out-string)
        $Parameters = @{
            RequestMethod    = 'WEB'
            body             = $body
            Uri              = $URI
            Method           = $Method
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
            # ResponseHeadersVariable = 'HeaderResponse'

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
            default {
                write-host $response.Headers.Date
            } 
        }   
    }
}


function Get-PPDMprotection_groups {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $id,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $filter,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v2",
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        [hashtable]$body = @{pageSize = 200 }  
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
            }
            default {
                $URI = "/$myself"
            }
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
            } 
        }   
    }
}



function New-PPDMprotection_groups {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $Name,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v2"

    )
    begin {
        $Response = @()
        $METHOD = "POST"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "-").ToLower()
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            'byID' {
                $URI = "/$myself/$id"
            }
            default {
                $URI = "/$myself"
            }
        }  
        $Body = @{'name' = $Name } 
        $Body.Add('type', "ORACLE_DATA_GUARD")
        $Body = $Body | ConvertTo-Json
        $Parameters = @{
            RequestMethod    = 'REST'
            body             = $body
            Uri              = $URI
            Method           = $Method
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
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
            } 
        }   
    }
}

<#
.SYNOPSIS
Batch Sets Database Stream Counts. Accepts Database Asset ID´s from Pipeline
There is no Output Object, but a Status Date from response Headers
.EXAMPLE
Get-PPDMassets -type MICROSOFT_SQL_DATABASE -filter 'details.database.clusterName eq "sqlsinglenode.dpslab.home.labbuildr.com"' | Set-PPDMMSSQLassetStreamcount -FullStreamCount 10 -LogStreamCount 10 -DifferentialStreamCount 10

size                : 4
number              : 1
totalPages          : 1
totalElements       : 4
maxPageableElements : 4



Tue, 25 Jul 2023 15:14:19 GMT
#>
function Set-PPDMMSSQLassetStreamcount {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('AssetID')]$ID,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $FullStreamCount = 4,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $LogStreamCount = 1,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $DifferentialStreamCount = 4,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]                        
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v2"
    )
    begin {
        $Response = @()
        $METHOD = "PATCH"
        $URI = "assets-batch"
        $requestID = 1
        $body = @{}
        $body.Add('requests', @()) 
   
    }     
    Process {
        $request = @{
            'id'   = $requestID
            'body' = @{
                'id'            = $ID
                'backupDetails' = @(@{
                        'backupType'  = 'FULL'
                        'parallelism' = $FullStreamCount
                    }
                    @{
                        'backupType'  = 'LOG'
                        'parallelism' = $LogStreamCount
                    }
                    @{
                        'backupType'  = 'DIFFERENTIAL'
                        'parallelism' = $DifferentialStreamCount
                    }
                )
            }    
        }
        $body.requests += $request
        $requestID++ 

    } 
    end {  

        $body = $body | Convertto-Json -Depth 7
        Write-Verbose ( $body | out-string ) 
        $Parameters = @{
            body             = $body 
            Uri              = $URI
            Method           = $METHOD
            RequestMethod    = 'WEB'
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            ContentType      = "application/json"
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
        }  
        Write-Verbose ($Parameters | Out-String )  
        try {
            $Response += Invoke-PPDMapirequest @Parameters
        }
        catch {
            Get-PPDMWebException  -ExceptionMessage $_
            break
        }
        Write-Verbose ($Response | Out-String)
        Write-Host $Response.Headers.Date

    }
}




function Set-PPDMOracleOIMProtectionProtocol {
    [CmdletBinding()]
    [Alias('Set-PPDMOIMProtocol')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('AssetID')]$ID,
        [Parameter(Mandatory = $TRUE, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('NFS', 'BOOST')]$ProtectionProtocol,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]                        
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v2"
    )
    begin {
        $Response = @()
        $METHOD = "PATCH"
        $URI = "assets-batch"
        $requestID = 1
        $body = @{}
        $body.Add('requests', @()) 
   
    }     
    Process {
        $request = @{
            'id'   = $requestID
            'body' = @{
                'id'                 = $ID
                'protectionProtocol' = $ProtectionProtocol
            }    
        }
        $body.requests += $request
        $requestID++ 

    } 
    end {  

        $body = $body | Convertto-Json -Depth 7
        Write-Verbose ( $body | out-string ) 
        $Parameters = @{
            body             = $body 
            Uri              = $URI
            Method           = $METHOD
            RequestMethod    = 'WEB'
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            ContentType      = "application/json"
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
        }  
        Write-Verbose ($Parameters | Out-String )  
        try {
            $Response += Invoke-PPDMapirequest @Parameters
        }
        catch {
            Get-PPDMWebException  -ExceptionMessage $_
            break
        }
        Write-Verbose ($Response | Out-String)
        Write-Host $Response.Headers.Date

    }
}


function Set-PPDMasset_networks_batch {
    [CmdletBinding()]
    [Alias('Set-PPDMAssetNetwork')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        $id,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        $networkLabel,        
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        $apiver = "/api/v2"

    )
    begin {
        $Response = @()
        $result =@()
        $METHOD = "PATCH"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "-").ToLower()
   
    }     
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            default {
                $URI = "/$myself"
            }
        }
        $body = @{ requests = @(
                @{

                    id   = (New-Guid).Guid
                    body = @{
                        id           = $id
                        networkLabel = $networkLabel
                    }
                }
            )
        }  | ConvertTo-json -Depth 7 
        write-verbose ($body | out-string)
        $Parameters = @{
            RequestMethod    = 'REST'
            body             = $body
            Uri              = $URI
            Method           = $Method
            PPDM_API_BaseUri = $PPDM_API_BaseUri
            apiver           = $apiver
            Verbose          = $PSBoundParameters['Verbose'] -eq $true
        }   
            
        try {
            $Response += Invoke-PPDMapirequest @Parameters
        }
        catch {
            Get-PPDMWebException  -ExceptionMessage $_
            break
        }
        write-verbose ($response | Out-String)
        $result += Get-PPDMassets -id $id| select-object name,id,networkLabel

    } 
    end {    
        switch ($PsCmdlet.ParameterSetName) {
            default {
                write-output ($result)
            } 
        }   
    }
}