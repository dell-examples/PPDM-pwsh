function Get-PPDMinfrastructure_objects {
    [CmdletBinding()]
    param(

        [Parameter(Mandatory = $true, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        $id,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $filter,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        [ValidateSet(
            'APPLICATION_HOST_INVENTORY_SOURCE',
            'CLOUD_DIRECTOR',
            'CLOUD_DISASTER_RECOVERY',
            'CLOUD_SNAPSHOT_MANAGER',
            'DATA_DOMAIN_INTERFACE',
            'DATA_DOMAIN_MANAGEMENT_CENTER',
            'DATA_MANAGER_APPLIANCE',
            'DATA_MANAGER_APPLIANCE_CLUSTER',
            'EXTERNAL_DATA_DOMAIN_INTERFACE',
            'DEFAULT_APP_GROUP',
            'GENERIC_NAS_MANAGEMENT_SERVER',
            'KUBERNETES_CLUSTER',
            'ORACLE_GROUP',
            'POWER_PROTECT_DATA_MANAGER',
            'POWER_SCALE_MANAGEMENT_SERVER',
            'POWER_STORE_MANAGEMENT_SERVER',
            'SMIS_SERVER',
            'SQL_GROUP',
            'UNISPHERE',
            'UNITY_MANAGEMENT_SERVER',
            'VMWARE_VCENTER',
            'VMWARE_ESX_CLUSTER',
            'HYPERV_SERVER',
            'HYPERV_CLUSTER'
        )]
        $Type,        
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $pageSize, 
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $page, 
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        [hashtable]$body = @{orderby = 'createdAt DESC' },
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]                
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        $apiver = "/api/v3"
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
