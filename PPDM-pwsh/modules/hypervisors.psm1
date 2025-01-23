

<#
.SYNOPSIS
Add a Hypervisor root object, eg, Hyper-V Server ( standalone )
.EXAMPLE

$ENABLED_ASSETS=Get-PPDMcommon_settings -id ASSET_SETTING
Add the  Hyper V Asset Source 'HYPERV_VIRTUAL_MACHINE' to the list of enabled Values
$ENABLED_ASSETS.properties[0].value='VMWARE_VIRTUAL_MACHINE,GENERIC_APPLICATION_ASSET,KUBERNETES,HYPERV_VIRTUAL_MACHINE'
Set-PPDMcommon_settings -id ASSET_SETTING -Properties $ENABLED_ASSETS

id            properties
--            ----------
ASSET_SETTING {@{name=enabledAssetTypes; value=VMWARE_VIRTUAL_MACHINE,GENERIC_APPLICATION_ASSET,KUBERNETES,HYPERV_VIRTUAL_MACHINE; type=LIST}}

Wait for ghvdm component to be enabled

Get-PPDMcomponents -id 83e44374-33d7-4bd2-8790-39d6073b30b6

id                   : 83e44374-33d7-4bd2-8790-39d6073b30b6
componentDisplayName : Generic Hypervisor Data Manager
componentServiceName : ghvdm
componentType        : Business Service
status               : INITIALIZING
monitored            : True
logging              : @{configurable=True; logLocation=/var/log/brs/ghvdm}


#>


function Get-PPDMhypervisor_root_object {
    [CmdletBinding()]
    param(

        [Parameter(Mandatory = $true, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $address,
        [Parameter(Mandatory = $true, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        $credentialId,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $false)]
        [int32]$port = 5986,
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $false)]
        [ValidateSet('HTTPS' )][string]$protocol = "HTTPS",
        [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('hyperv')][string]$type = "hyperv",                                      
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

        $URI = "/$myself"
        $body = @{}  
        $body.Add('address', $address)
        $body.Add('credentialId', $credentialId)
        $body.add('port', $port)
        $body.add('protocol', $protocol)
        $body.Add('type', $type)
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
$HyperV=Get-PPDMhypervisor_root_object -address labbuildr-asdk.azurestack.local -credentialId 92f9148c-f262-4957-a433-86ad8f856cd0
$HyperV.hypervisorServer.extendedData
Add-PPDMinfrastructure_objects -InfrastructureObject $HyperV.hypervisorServer -Verbose
#>


Function Add-PPDMinfrastructure_objects {
    [CmdletBinding()]
    [Alias('Add-PPDMHyperVisor')]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
        [psobject]$InfrastructureObject, 
        $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
        $apiver = "/api/v3"

    )
    begin {
        $Response = @()
        $METHOD = "POST"
        $Myself = ($MyInvocation.MyCommand.Name.Substring(8) -replace "_", "-").ToLower()
    }   

    Process {
        $URI = "/$myself"
        $body = $InfrastructureObject | ConvertTo-Json -Depth 7
        $Parameters = @{
            body             = $body 
            Uri              = $Uri
            Method           = $Method
            RequestMethod    = 'Rest'
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