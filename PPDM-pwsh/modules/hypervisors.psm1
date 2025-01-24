

<#
.SYNOPSIS
Add a Hypervisor root object, eg, Hyper-V Server ( standalone )
.EXAMPLE
Read the enabled Settings to see if HYPERV_VIRTUAL_MACHINE asset is enabled

$ENABLED_ASSETS=Get-PPDMcommon_settings -id ASSET_SETTING

$EnableD_ASSETS.properties[0].value
VMWARE_VIRTUAL_MACHINE,GENERIC_APPLICATION_ASSET,KUBERNETES

Add the  Hyper V Asset Source 'HYPERV_VIRTUAL_MACHINE' to the list of enabled Values

$ENABLED_ASSETS.properties[0].value='VMWARE_VIRTUAL_MACHINE,GENERIC_APPLICATION_ASSET,KUBERNETES,HYPERV_VIRTUAL_MACHINE'

Update the enabled Asset Sources 

Set-PPDMcommon_settings -id ASSET_SETTING -Properties $ENABLED_ASSETS

id            properties
--            ----------
ASSET_SETTING {@{name=enabledAssetTypes; value=VMWARE_VIRTUAL_MACHINE,GENERIC_APPLICATION_ASSET,KUBERNETES,HYPERV_VIRTUAL_MACHINE; type=LIST}}

Wait for ghvdm component to be enabled

Get-PPDMcomponents | where componentServiceName -eq "ghvdm"
id                   : 83e44374-33d7-4bd2-8790-39d6073b30b6
componentDisplayName : Generic Hypervisor Data Manager
componentServiceName : ghvdm
componentType        : Business Service
status               : INITIALIZING
monitored            : True
logging              : @{configurable=True; logLocation=/var/log/brs/ghvdm}
$CREDENTIAL=New-PPDMcredentials -type HYPERV -authmethod BASIC -name HyperV
Please Enter New username: azurestackadmin@azurestack.local
Enter Password for user azurestackadmin@azurestack.local: *********

Get-PPDMcertificates -newhost labbuildr-asdk.azurestack.local -Port 5986 | Approve-PPDMcertificates

id             : bGFiYnVpbGRyLWFzZGsuYXp1cmVzdGFjay5sb2NhbDo1OTg2Omhvc3Q=
host           : labbuildr-asdk.azurestack.local
port           : 5986
notValidBefore : 07.10.2024 20:30:21
notValidAfter  : 07.10.2026 20:35:21
fingerprint    : BC172F0FE5929DC06746A25C13F4DE8E025C386F
subjectName    : CN=LABBUILDR-ASDK.azurestack.local
issuerName     : CN=AzureStackCertificationAuthority
state          : ACCEPTED
type           : HOST
verify         : False

$HYPERVISOR=Get-PPDMhypervisor_root_object -address labbuildr-asdk.azurestack.local -credentialId $CREDENTIAL.id

Add-PPDMHyperVisor -InfrastructureObject $HYPERVISOR.hypervisorServer

id                               : cc07316b-c987-50cc-9cd1-9481773dffc3
occVersion                       : 48.71323
createdAt                        : 2025-01-24T08:30:34.356218840Z
updatedAt                        : 2025-01-24T08:30:34.356218840Z
availabilityStatus               : @{value=AVAILABLE_NEW; changedAt=2025-01-24T08:30:22.012000583Z}
discoveredAt                     : 2025-01-24T08:30:22.012014057Z
discoveryExecutionRefs           : {}
extendedData                     : @{autoAgentManagementEnabled=True; lastDiscoveryTokens=System.Object[];
                                   virtualizationEnabled=True}
externalIds                      : {HYPERVISOR_SERVER_ID||4C4C4544-0044-5810-8039-CAC04F563532}
description                      :
name                             : labbuildr-asdk
type                             : HYPERV_SERVER
categories                       : {HYPERVISOR_SERVER, INVENTORY_SOURCE}
vendor                           : MICROSOFT
version                          : 9.0
tenantId                         : 00000000-0000-4000-a000-000000000000
lastDiscoveryExecutionDetail     : @{status=UNKNOWN}
connectionDetails                : {@{type=HYPERVISOR; credentialId=1edf8aab-07ed-482d-a343-a91ddbbcb459;
                                   addresses=System.Object[]; port=5986; protocol=HTTP; secure=True}}
multiFactorAuthenticationEnabled : False
operatingSystem                  : @{name=Microsoft Windows Server 2019 Datacenter; version=10.0.17763}
memoryCapacity                   : @{totalSize=824533442560; usedSize=384859365376}
processorDetail                  : @{logicalCount=48}
volumeStorageCapacities          : {@{name=E; usedSize=73289433088; totalSize=128070844416;
                                   availableSize=54781411328},
                                   @{name=\\?\Volume{eef31d8f-feec-4254-b7e3-416ae30cd5d3}\; usedSize=1502666752;
                                   totalSize=21407727616; availableSize=19905060864}, @{name=D;
                                   usedSize=331372240896; totalSize=959550844928; availableSize=628178604032},
                                   @{name=C; usedSize=105073709056; totalSize=160692170752;
                                   availableSize=55618461696}…}
addresses                        : {@{value=labbuildr-asdk.azurestack.local; type=FQDN}}

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