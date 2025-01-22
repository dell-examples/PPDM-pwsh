

<#
https://ppdm-demo.home.labbuildr.com/passthrough/api/v3/hypervisor-root-object?address=labbuildr-asdk.azurestack.local&credentialId=92f9148c-f262-4957-a433-86ad8f856cd0&port=5986&protocol=HTTPS&type=hyperv

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





Function Add-PPDMinfrastructure_objects {
    [CmdletBinding()]
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