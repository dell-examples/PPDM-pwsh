<#
.Synopsis
Get all Protection Policies from PPDM
.Description
Retrieve al Protection Policies
- supports PPDM Filters
- Supports Policies by Type
- supports asset assignments

.Example
Get all Protection Policies as table format 
Get-PPDMprotection_policies | ft
id                                   name                          description                         assetType                   type   targetStorageProvisionStrategy
--                                   ----                          -----------                         ---------                   ----   ------------------
13ca2528-171f-4628-9063-b35aa9d265c5 Silver_SPBM                   This Policy does DDVE Cloud Tier    VMWARE_VIRTUAL_MACHINE      ACTIVE AUTO_PROVISION
200fb9c7-22a8-406b-b495-b6d6457de034 GOLD_SPBM                                                         VMWARE_VIRTUAL_MACHINE      ACTIVE AUTO_PROVISION
a374a075-4b9f-4ea8-bfc7-3700bea23314 GOLD_SPBM_NOTOOLS                                                 VMWARE_VIRTUAL_MACHINE      ACTIVE AUTO_PROVISION
ef4d7868-0786-4968-88b2-4da913c2f905 GOLD_SPBM_APP_AWARE                                               VMWARE_VIRTUAL_MACHINE      ACTIVE AUTO_PROVISION
23a74ead-6f91-4c49-844a-1f903a39ad70 Centralized_SQL                                                   MICROSOFT_SQL_DATABASE      ACTIVE AUTO_PROVISION
0b1c9b16-0775-4f5a-b613-9a0b75ca6aa6 Gold_Kubernetes                                                   KUBERNETES                  ACTIVE AUTO_PROVISION
a8d0fa51-b334-47ef-9c00-23499bfef896 SQL_APP_DIRECT                This Policy uses Application Direct MICROSOFT_SQL_DATABASE      ACTIVE AUTO_PROVISION
ead5f20a-efd6-42bc-a353-985121f62ed2 Gold_VMware                                                       VMWARE_VIRTUAL_MACHINE      ACTIVE AUTO_PROVISION
38d3acbc-8b41-477b-a5ab-6a85c74bfa9f Exchange Silver                                                   MICROSOFT_EXCHANGE_DATABASE ACTIVE AUTO_PROVISION
4f8ee8f7-68ef-4c09-8789-17301e82be3a Kube Backup Platform Services                                     KUBERNETES                  ACTIVE AUTO_PROVISION
e890a685-9fe9-4f9e-b91f-cfd61e7b131e Exchange Silver SelfService                                       MICROSOFT_EXCHANGE_DATABASE ACTIVE AUTO_PROVISION
aa9665ac-9a25-44db-a3e1-cbf0e698c971 CI_EX_CLI_CENTRAL2                                                MICROSOFT_EXCHANGE_DATABASE ACTIVE AUTO_PROVISION
.Example
Get all vmware assets assigned
Get-PPDMprotection_policies -type VMWARE_VIRTUAL_MACHINE -asset_assignments | ft

id                                   name              description assetType              type     category               targetStorageProvisionStrategy enabled passive forc
                                                                                                                                                                         eFul
                                                                                                                                                                            l
--                                   ----              ----------- ---------              ----     --------               ------------------------------ ------- ------- ----
3e38a236-24f3-4b90-a09d-71867a1b2081 PPDM                          VMWARE_VIRTUAL_MACHINE ACTIVE   CENTRALIZED_PROTECTION AUTO_PROVISION                   False   False …lse
aad3c5b2-bb17-4426-82a0-56addf1c72b2 Exclusions_VM_SPB             VMWARE_VIRTUAL_MACHINE EXCLUDED EXCLUSION              AUTO_PROVISION                    True   False
abf4f09e-9249-4bc6-8daf-cbcbd470ccc1 Exclusions                    VMWARE_VIRTUAL_MACHINE EXCLUDED EXCLUSION              AUTO_PROVISION                    True   False
9bc6b090-0826-4fe6-8f4a-53b57f135b9f win_test                      VMWARE_VIRTUAL_MACHINE ACTIVE   CENTRALIZED_PROTECTION AUTO_PROVISION                    True   False …lse
62095aab-ccf6-4d23-8563-63f61c86bf47 VM_TAG_BASED_AA               VMWARE_VIRTUAL_MACHINE ACTIVE   CENTRALIZED_PROTECTION AUTO_PROVISION                    True   False …lse
56c5ae63-df2c-44e2-96b8-039e348de3de LINUX_IMAGE                   VMWARE_VIRTUAL_MACHINE ACTIVE   CENTRALIZED_PROTECTION AUTO_PROVISION                    True   False …lse
.Example
Get Protection Policy with ID
Get-PPDMprotection_policies -id a374a075-4b9f-4ea8-bfc7-3700bea23314

id                             : a374a075-4b9f-4ea8-bfc7-3700bea23314
name                           : GOLD_SPBM_NOTOOLS
description                    :
assetType                      : VMWARE_VIRTUAL_MACHINE
type                           : ACTIVE
targetStorageProvisionStrategy : AUTO_PROVISION
enabled                        : True
passive                        : False
forceFull                      : False
priority                       : 1
credentials                    :
encrypted                      : False
dataConsistency                : CRASH_CONSISTENT
complianceInterval             :
details                        : @{vm=}
summary                        : @{numberOfAssets=1; totalAssetCapacity=8589934592; totalAssetProtectionCapacity=2341732352; numberOfJobFailures=0;
                                 numberOfSlaFailures=0; numberOfSlaSuccess=0; lastExecutionStatus=SUCCEEDED}
stages                         : {@{id=2e07bd54-7fc1-7dea-0ec7-c827e41faec2; type=CDR; passive=False; retention=; target=;
                                 sourceStageId=4dd98961-1e1b-29a2-8712-c37ce8c1ec69; attributes=; operations=System.Object[]},
                                 @{id=4dd98961-1e1b-29a2-8712-c37ce8c1ec69; type=PROTECTION; passive=False; retention=; target=; attributes=;
                                 operations=System.Object[]}}
filterIds                      : {}
createdAt                      : 08.02.2021 12:03:48
updatedAt                      : 08.02.2021 12:17:50
slaId                          :
_links                         : @{self=}

.Example
Use Filter to match a name
Get-PPDMprotection_policies -filter 'name lk "%NOTOOLS%"' | Select-Object id,name,assetType

id                                   name              assetType
--                                   ----              ---------
a374a075-4b9f-4ea8-bfc7-3700bea23314 GOLD_SPBM_NOTOOLS VMWARE_VIRTUAL_MACHINE

.Example
Use Pagination to retrieve only 5 Results
Get-PPDMprotection_policies  -body @{pageSize=5} -filter 'name lk "%GOLD%"'

.Example
Use Pagination and filter t retrieve 
Get-PPDMprotection_policies  -body @{pageSize=2} -filter 'name lk "%GOLD%"' | Select-Object id,name,assetType

id                                   name              assetType
--                                   ----              ---------
200fb9c7-22a8-406b-b495-b6d6457de034 GOLD_SPBM         VMWARE_VIRTUAL_MACHINE
a374a075-4b9f-4ea8-bfc7-3700bea23314 GOLD_SPBM_NOTOOLS VMWARE_VIRTUAL_MACHINE
.EXAMPLE

Get-PPDMprotection_policies -type FILE_SYSTEM -asset_assignments

id                             : 553a0d10-7075-41fa-a645-08262f6addd8
name                           : fs_demo
description                    :
assetType                      : FILE_SYSTEM
type                           : ACTIVE
category                       : CENTRALIZED_PROTECTION
targetStorageProvisionStrategy : AUTO_PROVISION
enabled                        : True
passive                        : False
forceFull                      : False
priority                       : 1
credentials                    :
encrypted                      : False
dataConsistency                : CRASH_CONSISTENT
complianceInterval             :
details                        :
summary                        : @{numberOfAssets=1; totalAssetCapacity=105086115840; totalAssetProtectionCapacity=47862742004; numberOfJobFailures=0;
                                 numberOfSlaFailures=0; numberOfSlaSuccess=0; lastExecutionStatus=SUCCEEDED}
stages                         : {@{id=03cbb135-bdde-f70a-81e7-4dc3f079826b; type=PROTECTION; passive=False; retention=; extendedRetentions=System.Object[]; target=;
                                 attributes=; operations=System.Object[]; options=}}
filterIds                      : {}
createdAt                      : 27.10.2022 12:09:53
updatedAt                      : 27.10.2022 12:10:12
slaId                          :
_links                         : @{self=}

#>
function Get-PPDMprotection_policies {
  [CmdletBinding()]
  param(    
    [Parameter(Mandatory = $true, ParameterSetName = 'type', ValueFromPipelineByPropertyName = $false)]
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
      'POWERSTORE_BLOCK'
    )]$type,
    
    [Parameter(Mandatory = $true, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
    $id,
    #    [Parameter(Mandatory = $false, ParameterSetName = 'type', ValueFromPipelineByPropertyName = $true)]
    #    [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
    [Parameter(Mandatory = $false, ParameterSetName = 'byID', ValueFromPipelineByPropertyName = $true)]
    [switch]$asset_assignments,
    [Parameter(Mandatory = $false, ParameterSetName = 'type', ValueFromPipelineByPropertyName = $false)]
    [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $false)]
    $filter,
    [Parameter(Mandatory = $false, ParameterSetName = 'type', ValueFromPipelineByPropertyName = $false)]
    [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
    $pageSize, 
    [Parameter(Mandatory = $false, ParameterSetName = 'type', ValueFromPipelineByPropertyName = $false)]
    [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
    $page, 
    [Parameter(Mandatory = $false, ParameterSetName = 'type', ValueFromPipelineByPropertyName = $false)]
    [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
    [hashtable]$body = @{},
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
        if ($asset_assignments.IsPresent) {
          $URI = "$URI/asset-assignments"
        }    
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
      if ($Filter) {
        $filter = "assetType eq `"$type`" and $filter"
      }
      else {
        $Filter = "assetType eq `"$type`""
      }
    }
    if ($filter) {
      $parameters.Add('filter', $filter)
      
    }    
    Write-Verbose ($Parameters | Out-String)       
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
        if ( $asset_assignments.IsPresent ) {
          write-output $response.content
          if ($response.page) {
            write-host ($response.page | out-string)
          }
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

<#
.Synopsis
New API Edpoint to start an Asset Protion by Policy 
.Description
Starting a Policy requires Stage and Policy ID.
CMDlet Supports the Input of a Policy Object including. See Example
.Example
$Policy = Get-PPDMprotection_policies  -body @{pageSize=1} -filter 'name eq "GOLD_SPBM_NOTOOLS"'
Start-PPDMprotection -PolicyObject $Policy
Thu, 06 May 2021 09:11:11 GMT
.EXAMPLE
$Asset=Get-PPDMassets -filter {details.k8s.inventorySourceName eq "api.ocs1.home.labbuildr.com" and name eq "mysql-rh" and protectionStatus eq "PROTECTED"}
$Policy=Get-PPDMprotection_policies -id $Asset.protectionPolicyId
Start-PPDMprotection -PolicyObject $Policy -AssetIDs $Asset.id
#>
function Start-PPDMprotection {
  [CmdletBinding()]
  [Alias('Start-PPDMPLCStage', 'Start-PPDMProtectionStage')]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'byPolicyObject')]
    [psobject]$PolicyObject,
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byPolicyObject')]
    [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byIDS')]
    [string[]][alias('Assets')]$AssetIDs,  
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byIDS')]
    [string][alias('id')]$PolicyID,
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'byIDS')]
    [string][alias('stage')]$StageID,    
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'byIDS')]
    [ValidateSet("FULL",
      "DIFFERENTIAL",
      "LOG",
      "INCREMENTAL",
      "CUMULATIVE",
      "AUTO_FULL",
      "SYNTHETIC_FULL",
      "GEN0")]
    $BackupType = 'FULL',
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'byPolicyObject')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'byIDS')]
    [ValidateSet('DAY', 'WEEK', 'MONTH', 'YEAR' )]
    $RetentionUnit = 'DAY',
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'byPolicyObject')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'byIDS')]
    [Int32]$RetentionInterval = '7',        
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'byPolicyObject')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'byIDS')]
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'byPolicyObject')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'byIDS')]
    $apiver = "/api/v2",
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'byPolicyObject')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'byIDS')]
    <# noop Parameter will simulate the command only #> 
    [switch]$noop
  )
  begin {
    $Response = @()
    $METHOD = "POST"
    # $response = Invoke-WebRequest -Method $Method -Uri $Global:PPDM_API_BaseUri/api/v0/$Myself -Headers $Global:PPDM_API_Headers
 
  }     
  Process {
    switch ($PsCmdlet.ParameterSetName) {
      default {
        $Body = [ordered]@{
          'stages' = @(
            @{
              'id'        = $StageID  
              'operation' = @{
                'backupType' = $BackupType
              }  
              'retention' = @{
                'interval' = $RetentionInterval
                'unit'     = $RetentionUnit
              }
            } )
        } 
        if ($AssetIDs) {
          $Body.Add('assetIds', $AssetIDs)
        }
      }
      'byPolicyObject' {
        $StageID = ($PolicyObject.stages | Where-Object type -eq PROTECTION).id
        $BackupType = ($PolicyObject.stages | Where-Object type -eq PROTECTION).operations.backupType
        $PolicyID = $PolicyObject.id
        $Body = [ordered]@{
          'stages' = @(
            @{
              'id'        = $StageID  
            } )
        } 
        if ($AssetIDs) {
          $Body.Add('assetIds', $AssetIDs)
        }        
      }

    }    


    $Body = $Body | convertto-json -Depth 3
    write-verbose ($body | out-string)
    Write-Verbose $PolicyID
    $Parameters = @{
      RequestMethod    = 'REST'
      body             = $body 
      Uri              = "protection-policies/$PolicyID/protections"
      Method           = $Method
      PPDM_API_BaseUri = $PPDM_API_BaseUri
      apiver           = $apiver
      Verbose          = $PSBoundParameters['Verbose'] -eq $true
      # ResponseHeadersVariable = 'HeaderResponse'
    }
    Write-Verbose ($Parameters | Out-String)
    if (!$noop.ispresent) {        
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
    if (!$noop.IsPresent) {

      switch ($PsCmdlet.ParameterSetName) {
        default {
          Write-Output $Response
        } 
      }   
    }
  }
}


<#
.SYNOPSIS
Starts a Protection Policy by ID
.EXAMPLE
# Start a Policy by ID for Specific Asset(s)
$Asset=Get-PPDMassets -filter {details.k8s.inventorySourceName eq "api.ocs1.home.labbuildr.com" and name eq "mysql-rh" and protectionStatus eq "PROTECTED"}
$Policy=Get-PPDMprotection_policies -id $Asset.protectionPolicyId
$Policy | Start-PPDMprotection_policies -Assets $Assets.id
.EXAMPLE
$Policy=Get-PPDMprotection_policies -filter {name eq "K8S_GOLD" and assetType eq "Kubernetes"}
$Policy | Start-PPDMprotection_policies
#>
function Start-PPDMprotection_policies {
  [CmdletBinding()]
  [Alias('Start-PPDMPLC')]
  param(
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    $apiver = "/api/v2",
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [string][alias('id')]$PolicyID,
    [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
    [string[]][alias('Assets')]$AssetIDs,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false)]
    [ValidateSet('FULL', 'GEN0', 'DIFFERENTIAL', 'LOG', 'INCREMENTAL', 'CUMULATIVE', 'AUTO_FULL')]
    $BackupType = 'FULL',
    [Parameter(Mandatory = $false, ValueFromPipeline = $false)]
    [ValidateSet('DAY', 'WEEK', 'MONTH', 'YEAR' )]
    $RetentionUnit = 'DAY',
    [Parameter(Mandatory = $false, ValueFromPipeline = $false)]
    [Int32]$RetentionInterval = '7'        

  )
  begin {
    $Response = @()
    $METHOD = "POST"
    $Myself = ($MyInvocation.MyCommand.Name.Substring(10) -replace "_", "-").ToLower()
    # $response = Invoke-WebRequest -Method $Method -Uri $Global:PPDM_API_BaseUri/api/v0/$Myself -Headers $Global:PPDM_API_Headers
   
  }     
  Process {
    switch ($PsCmdlet.ParameterSetName) {
      'byID' {
        $URI = "/$Myself/$PolicyID/backups"
      }
      default {
        $URI = "/$Myself/$PolicyID/backups"
      }
    }    
    $Body = [ordered]@{
      'assetIds'                          = $AssetIDs
      'backupType'                        = $BackupType
      'disableProtectionPolicyProcessing' = 'false'
      'retention'                         = @{
        'interval' = $RetentionInterval
        'unit'     = $RetentionUnit
      }
    } | convertto-json -compress
    write-verbose ($body | out-string)
    $Parameters = @{
      body             = $body 
      Uri              = $URI
      Method           = $Method
      PPDM_API_BaseUri = $PPDM_API_BaseUri
      apiver           = $apiver
      RequestMethod    = "WEB"
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
      'byID' {
        write-host $response.Headers.Date
      }
      default {
        write-host $response.Headers.Date
      } 
    }   
  }
}



function Remove-PPDMprotection_policies {
  [CmdletBinding()]
  param(
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    $apiver = "/api/v2",
    [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true)]
    $id
  )
  begin {
    $Response = @()
    $METHOD = "DELETE"
    $Myself = ($MyInvocation.MyCommand.Name.Substring(11) -replace "_", "-").ToLower()
    # $response = Invoke-WebRequest -Method $Method -Uri $Global:PPDM_API_BaseUri/api/v0/$Myself -Headers $Global:PPDM_API_Headers
 
  }     
  Process {

    $URI = "/$myself/$id"
    $Parameters = @{
      #            body             = $body 
      Uri              = $Uri
      Method           = $Method
      RequestMethod    = 'WEB'
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
      'byID' {
        write-output $response 
      }
      default {
        write-host $response.Headers.Date
      } 
    }   
  }
}

<#
.Synopsis
Remove Asset(s) from a Protection Policy
.Description
Unassign assets from a Policy
.Example
Remove all Assets from a Specific vCenter from a specific Protection Policy
$Policy = Get-PPDMprotection_policies -filter { assetType eq "VMWARE_VIRTUAL_MACHINE" and name eq "<your policy name>" }
# List the Asset Assignments:
$Policy | Get-PPDMprotection_policies -asset_assignments -filter {details.vm.inventorySourceName eq "<your vcenter name>"}
$Policy | Get-PPDMprotection_policies -asset_assignments -filter {details.vm.inventorySourceName eq "<your vcenter name>"} | Remove-PPDMProtection_policy_assignment
#>

function Remove-PPDMProtection_policy_assignment {
  [CmdletBinding()]
  [Alias('Unregister-PPDMAssetFromPoliy')]
  param(
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [alias('id')][string[]]$AssetID, 
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [alias('PLC')]$protectionPolicyId, 
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    $apiver = "/api/v2"

  )
  begin {
    $Response = @()
    $METHOD = "POST"
  }     
  Process {

    $URI = "/protection-policies/$protectionPolicyId/asset-unassignments"
    if ($AssetID.Count -eq 1) {
      $body = "[`"$AssetID`"]"
    }
    else {
      $body = @(
        @($AssetID)
      ) | ConvertTo-Json -Depth 3
    }
        
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
      'Host' {
        write-output $response 
      }
      default {
        write-output ($response )
      } 
    }   
  }
}

function Add-PPDMProtection_policy_assignment {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [alias('fqdn')][string[]]$AssetID, 
    [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
    [alias('PLC')]$ID, 
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    $apiver = "/api/v2"

  )
  begin {
    $Response = @()
    $METHOD = "POST"
  }     
  Process {

    $URI = "/protection-policies/$ID/asset-assignments"
    if ($AssetID.Count -eq 1) {
      $body = "[`"$AssetID`"]"
    }
    else {
      $body = @(
        @($AssetID)
      ) | ConvertTo-Json -Depth 3
    }
        
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
      'Host' {
        write-output $response 
      }
      default {
        write-output ($response )
      } 
    }   
  }
}






function New-PPDMBackupSchedule {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [switch]$hourly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_weekly')] 
    [switch]$hourly_w_full_weekly,  
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_monthly')]
    [switch]$hourly_w_full_monthly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [switch]$daily,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_weekly')]
    [switch]$daily_w_full_weekly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_monthly')]
    [switch]$daily_w_full_monthly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]
    [switch]$weekly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_weekly')]
    [switch]$weekly_w_full_weekly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_monthly')]                   
    [switch]$weekly_w_full_monthly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [switch]$monthly_day,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [switch]$monthly_day_of_week,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_w_full_monthly')]
    [switch]$monthly_day_w_full_monthly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_w_full_monthly')]
    [switch]$monthly_day_of_week_w_full_monthly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]        
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_weekly')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_monthly')] 
    [int][ValidateRange(1, 22)]$CreateCopyIntervalHrs, 
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_weekly')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_weekly')]                      
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_weekly')]
    [String][ValidateSet("SUNDAY",
      "MONDAY",
      "TUESDAY",
      "WEDNESDAY",
      "THURSDAY",
      "FRIDAY",
      "SATURDAY")]$CreateFull_Every_DayofWeek,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_monthly')]            
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_monthly')]                   
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_monthly')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_w_full_monthly')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_w_full_monthly')]
    [int][ValidateRange(1, 28)]$CreateFull_Every_DayofMonth,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_w_full_monthly')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [int][ValidateRange(1, 28)]$CreateCopydayofMonth,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_w_full_monthly')]        
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [String][ValidateSet("SUNDAY",
      "MONDAY",
      "TUESDAY",
      "WEDNESDAY",
      "THURSDAY",
      "FRIDAY",
      "SATURDAY")]$CreateCopyDayofWeek,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_w_full_monthly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [int][ValidateRange(1, 4)]$CreateCopyWeekofMonth,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_weekly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_monthly')]        
    [String[]][ValidateSet("SUNDAY",
      "MONDAY",
      "TUESDAY",
      "WEDNESDAY",
      "THURSDAY",
      "FRIDAY",
      "SATURDAY")]$CreateCopyDays,  
      
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_weekly')] 
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_monthly')]  
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_weekly')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_monthly')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_weekly')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_monthly')]                   
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_w_full_monthly')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_w_full_monthly')]
    [ValidateSet("YEAR",
      "MONTH",
      "WEEK",
      "DAY")]
    [string]$RetentionUnit,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_weekly')] 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_monthly')]  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_weekly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_monthly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_weekly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_monthly')]                   
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_w_full_monthly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_w_full_monthly')]
    [ValidateRange(1, 2555)][int]$RetentionInterval,    
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_weekly')] 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_monthly')]  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_weekly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_monthly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_weekly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_monthly')]                   
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_w_full_monthly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_w_full_monthly')]
    [DateTime][Alias('startime')]$starttime = "8:00PM",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_weekly')] 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_w_full_monthly')]  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_weekly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_w_full_monthly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_weekly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_w_full_monthly')]                   
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_w_full_monthly')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_w_full_monthly')]
    [DateTime]$endtime = "6:00AM"


    
  )
  begin {

  }     
  Process {
    if ($endtime -lt $starttime) {
      $endtime = $endtime + 1d
    }
    $PTHours = ($endtime - $starttime).Hours
    $schedule = @{}
    $retention = @{
      'interval' = $RetentionInterval
      'unit'     = $RetentionUnit
    }
    $copySchedule = @{
      'duration'  = "PT$($PTHours)H"
      'startTime' = $(Get-Date $starttime -Format yyyy-MM-ddThh:mm:ss.000Z)
    }                  

    $fullSchedule = @{
      'duration'  = "PT$($PTHours)H"
      'startTime' = $(Get-DAte $starttime -Format yyyy-MM-ddThh:mm:ss.000Z)
    }            
    switch (($($PSCmdlet.ParameterSetName) -split "_")[0]) {
      'hourly' {
        $copyschedule.Add('frequency', 'HOURLY')
        $copyschedule.Add('interval', $CreateCopyIntervalHrs)
      }
      'daily' {
        $copyschedule.Add('frequency', 'DAILY')
      } 
      'weekly' {
        $copyschedule.Add('frequency', 'WEEKLY')
        $copyschedule.Add('weekDays', @($CreateCopyDays))
      }
      'monthlyday' {
        $copyschedule.Add('frequency', 'MONTHLY')
        $copyschedule.Add('dayOfMonth', $CreateCopydayofMonth)
      }
              
      'monthlydayofweek' {
        $copyschedule.Add('frequency', 'MONTHLY')
        $copyschedule.Add('weekDays', @($CreateCopyDayofWeek))
        If ($CreateCopyWeekofMonth) {
          $copyschedule.Add('weekOfMonth', $CreateCopyWeekofMonth)    
        }
        else {
          $copyschedule.Add('genericDay', 'LAST')    
        }
      }                      
    }


    $Schedule.Add('CopySchedule', $copySchedule)
    $schedule.Add('Retention', $retention)


    switch (($($PSCmdlet.ParameterSetName) -split "_w_")[1]) {

      'full_weekly' {
        $fullschedule.Add('frequency', 'WEEKLY')
        $fullschedule.Add('weekDays', @($CreateFull_Every_DayofWeek))
        $Schedule.Add('FullSchedule', $fullSchedule)        
      }
      'full_monthly' {
        $fullschedule.Add('frequency', 'MONTHLY')
        $fullschedule.Add('dayOfMonth', $CreateFull_Every_DayofMonth)
        $Schedule.Add('FullSchedule', $fullSchedule)
      }

    } 

    

  } 
  end {    
    switch ($PsCmdlet.ParameterSetName) {
      default {
        write-output $Schedule
      } 
    }   
  }
}


function New-PPDMDatabaseBackupSchedule {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [switch]$hourly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [switch]$daily,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]
    [switch]$weekly,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [switch]$monthly_day,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [switch]$monthly_day_of_week,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]        
    [int][ValidateRange(1, 22)]$CreateCopyIntervalHrs, 
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [int][ValidateRange(1, 28)]$CreateCopydayofMonth,   
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [String][ValidateSet("SUNDAY",
      "MONDAY",
      "TUESDAY",
      "WEDNESDAY",
      "THURSDAY",
      "FRIDAY",
      "SATURDAY")]$CreateCopyDayofWeek,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [int][ValidateRange(1, 4)]$CreateCopyWeekofMonth,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]  
    [String[]][ValidateSet("SUNDAY",
      "MONDAY",
      "TUESDAY",
      "WEDNESDAY",
      "THURSDAY",
      "FRIDAY",
      "SATURDAY")]$CreateCopyDays,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]               
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [ValidateSet("MINUTELY",
      "HOURLY")]
    [string]$LogBackupUnit,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]               
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [int]$LogBackupInterval,      
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]               
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [ValidateSet("MINUTELY",
      "HOURLY")]
    [string]$DifferentialBackupUnit,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]               
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [int]$DifferentialBackupInterval,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]               
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [ValidateSet("MINUTELY",
      "HOURLY")]
    [string]$CumulativeBackupUnit,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]               
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [int]$CumulativeBackupInterval,             
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]               
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [ValidateSet("YEAR",
      "MONTH",
      "WEEK",
      "DAY")]
    [string]$RetentionUnit,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]               
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [ValidateRange(1, 2555)][int]$RetentionInterval,    
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]              
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [DateTime][Alias('startime')]$starttime = "8:00PM",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'hourly_')]                        
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'daily_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'weekly_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlyday_')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'monthlydayofweek_')]
    [DateTime]$endtime = "6:00AM"


    
  )
  begin {

  }     
  Process {
    if ($endtime -lt $starttime) {
      $endtime = $endtime + 1d
    }
    $PTHours = ($endtime - $starttime).Hours
    $schedule = @{}
    $retention = @{
      'interval' = $RetentionInterval
      'unit'     = $RetentionUnit
    }
    $copySchedule = @{
      'duration'  = "PT$($PTHours)H"
      'startTime' = $(Get-Date $starttime -Format yyyy-MM-ddThh:mm:ss.000Z)
    }  
    switch (($($PSCmdlet.ParameterSetName) -split "_")[0]) {
      'hourly' {
        $copyschedule.Add('frequency', 'HOURLY')
        $copyschedule.Add('interval', $CreateCopyIntervalHrs)
      }
      'daily' {
        $copyschedule.Add('frequency', 'DAILY')
      } 
      'weekly' {
        $copyschedule.Add('frequency', 'WEEKLY')
        $copyschedule.Add('weekDays', @($CreateCopyDays))
      }
      'monthlyday' {
        $copyschedule.Add('frequency', 'MONTHLY')
        $copyschedule.Add('dayOfMonth', $CreateCopydayofMonth)
      }
              
      'monthlydayofweek' {
        $copyschedule.Add('frequency', 'MONTHLY')
        $copyschedule.Add('weekDays', @($CreateCopyDayofWeek))
        If ($CreateCopyWeekofMonth) {
          $copyschedule.Add('weekOfMonth', $CreateCopyWeekofMonth)    
        }
        else {
          $copyschedule.Add('genericDay', 'LAST')    
        }
      }                      
    }
    $Schedule.Add('copySchedule', $copySchedule) 
    
    $schedule.Add('retention', $retention)
    if ($LogBackupInterval) {
      $LogSchedule = @{
        "backupType" = "LOG" 
      }

      
      $LogSchedule.Add('schedule', @{})
      $LogSchedule.schedule.Add('interval', $LogBackupInterval)
      $LogSchedule.schedule.Add('frequency', $LogBackupUnit)
#      $LogSchedule.schedule.Add('logEnabled', $True) strict API
      $LogSchedule.schedule.Add('duration' , "PT$($PTHours)H")
      $LogSchedule.schedule.Add('startTime', $(Get-DAte $starttime -Format yyyy-MM-ddThh:mm:ss.000Z))
      $Schedule.Add('logSchedule', $logSchedule)   
    } 
    if ($DifferentialBackupInterval) {
      $DifferentialSchedule = @{
        'backupType' = 'DIFFERENTIAL' 
      }
      $DifferentialSchedule.Add('schedule', @{})
      $DifferentialSchedule.schedule.Add('frequency', $DifferentialBackupUnit)
      $DifferentialSchedule.schedule.Add('interval', $DifferentialBackupInterval)
      $DifferentialSchedule.schedule.Add('duration', "PT$($PTHours)H")
      $DifferentialSchedule.schedule.Add('startTime', $(Get-DAte $starttime -Format yyyy-MM-ddThh:mm:ss.000Z))
      $Schedule.Add('differentialSchedule', $DifferentialSchedule)    
    }         
    if ($CumulativeBackupInterval) {
      $CumulativeSchedule = @{
        'backupType' = 'CUMULATIVE' 
      }
      $CumulativeSchedule.Add('schedule', @{})
      $CumulativeSchedule.schedule.Add('frequency', $CumulativeBackupUnit)
      $CumulativeSchedule.schedule.Add('interval', $CumulativeBackupInterval)
      $CumulativeSchedule.schedule.Add('duration', "PT$($PTHours)H")
      $CumulativeSchedule.schedule.Add('startTime', $(Get-DAte $starttime -Format yyyy-MM-ddThh:mm:ss.000Z))
      $Schedule.Add('cumulativeSchedule', $CumulativeSchedule)    
    }  
  } 
  end {    
    switch ($PsCmdlet.ParameterSetName) {
      default {
        write-output $Schedule
      } 
    }   
  }
}

<#
.SYNOPSIS
Creates a new VM Backup Policcy


.EXAMPLE
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve.home.labbuildr.com"}
$Schedule=New-PPDMBackupSchedule -daily  -RetentionUnit DAY -RetentionInterval 4
$SLA=New-PPDMBackupService_Level_Agreements -NAME PLATINUM -RecoverPointObjective -RecoverPointUnit HOURS -RecoverPointInterval 24 -DeletionCompliance -ComplianceWindow -ComplianceWindowCopyType ALL
New-PPDMVMBackupPolicy -Schedule $Schedule -Name Linux -backupMode FSS -StorageSystemID $StorageSystem.id -SLAId $SLA.id

id                             : 91f37d35-686e-4ae4-a5f5-7bd1fcaf5128
name                           : Linux
description                    :
assetType                      : VMWARE_VIRTUAL_MACHINE
type                           : ACTIVE
category                       : CENTRALIZED_PROTECTION
targetStorageProvisionStrategy : AUTO_PROVISION
enabled                        : False
passive                        : False
forceFull                      : False
priority                       : 1
credentials                    :
encrypted                      : False
dataConsistency                : CRASH_CONSISTENT
complianceInterval             :
details                        : @{vm=}
summary                        : @{numberOfAssets=0; totalAssetCapacity=0; totalAssetProtectionCapacity=0; numberOfJobFailures=0; numberOfSlaFailures=0; numberOfSlaSuccess=0; lastExecutionStatus=IDLE}
stages                         : {@{id=04ffa229-89b5-4e3f-87c4-da2e5778da4d; type=PROTECTION; passive=False; retention=; target=; slaId=5c0d180d-7100-4f54-a2ba-3b9b3fb5ea07; attributes=;
                                 operations=System.Object[]}}
filterIds                      :
createdAt                      : 24/07/2023 12:53:37
updatedAt                      : 24/07/2023 12:53:37
slaId                          :
_links                         : @{self=}
#>
function New-PPDMVMBackupPolicy {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [psobject]$Schedule,    
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [ValidateLength(1, 150)][string]$Name,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [ValidateLength(1, 150)][string]$StorageSystemID,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [Alias('dataTargetId')][System.Guid]$StorageUnitID, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [Alias('IfId')]$preferredInterfaceId, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [Alias('backupMode')][string][ValidateSet('FSS', 'VSS')]$SizeSegmentation = 'VSS',
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [switch]$excludeSwapFiles,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [switch]$disableQuiescing,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    <# This Swich will enable the Policy #> 
    [switch]$enabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    <# This switch will enable Enable Metadata Indexing (requires seacrhc index deployed) #>
    [switch]$indexingEnabled,     
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [switch]$encrypted, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [string]$SLAId,     
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    [string]$Description = '' ,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'Stage0')]
    [ValidateSet('VADP', 'SDM')]
    [string]$DataMover = "SDM",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    $apiver = "/api/v2",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Stage0')]
    <# noop Parameter will simulate the command only #> 
    [switch]$noop           
  )
  begin {
    $Response = @()
    $METHOD = "POST"
  }     
  Process {

    $URI = "/protection-policies"

    switch ($DataMover) {
      'SDM' {
        $disableQuiescing = $true
        $excludeSwapFiles = $false
      }
    }
    $operations = @()
    $copyoperation = @{}
    $copyoperation.Add('schedule', $Schedule.CopySchedule)
    $copyoperation.Add('backupType', 'SYNTHETIC_FULL') 
    $operations += $copyoperation 
    if ($Schedule.FullSchedule) {
      $fulloperation = @{}
      $fulloperation.Add('schedule', $Schedule.FullSchedule)
      $fulloperation.Add('backupType', 'FULL')     
      $operations += $fulloperation 
    }
    Write-Verbose ($operations | out-string)
    $Body = [ordered]@{ 
      'name'            = $Name
      'assetType'       = 'VMWARE_VIRTUAL_MACHINE'
      'type'            = 'ACTIVE'
      'dataConsistency' = 'CRASH_CONSISTENT'
      'enabled'         = $enabled.IsPresent
      'description'     = $Description
      'encrypted'       = $encrypted.IsPresent
      'priority'        = 1
      'passive'         = $false
      'forceFull'       = $false
      'details'         = @{
        'vm' = @{
          'protectionEngine'        = 'VMDIRECT'
          'metadataIndexingEnabled' = $indexingEnabled.IsPresent
        }
      }
      'stages'          = @(
        @{
          'id'         = (New-Guid).Guid   
          'type'       = 'PROTECTION'
          'passive'    = $false
          'slaId'      = $SLAId 
          'attributes' = @{
            'vm'         = @{
              'excludeSwapFiles' = $excludeSwapFiles.IsPresent
              'disableQuiescing' = $disableQuiescing.IsPresent
              'dataMoverType'    = $DataMover
            }
            'protection' = @{
              'backupMode' = $SizeSegmentation
            }
          }                     
          'target'     = @{
            'storageSystemId' = $StorageSystemID
          }
          'operations' = $operations
          'retention'  = $Schedule.Retention
        }
      ) 
    } 
    if ($preferredInterfaceId) {
      $Body.stages.target.Add('preferredInterfaceId', $preferredInterfaceId)
    }  
    if ($StorageUnitID) {
      $Body.stages.target.Add('dataTargetId', $StorageUnitID)
    }
    $Body = $Body | convertto-json -Depth 7
    write-verbose ($body | out-string)
    $Parameters = @{
      RequestMethod    = 'Rest'
      body             = $body 
      Uri              = $URI
      Method           = $Method
      PPDM_API_BaseUri = $PPDM_API_BaseUri
      apiver           = $apiver
      Verbose          = $PSBoundParameters['Verbose'] -eq $true
    } 
    if (!$noop.IsPresent) {      
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
<#
.Synopsis
Creates a K8S Backup Policy
.Description
K8S Backup Policy is a Syntetic Full and Requires a copy only schedule ( hourly, daily, weekly or monthly )

.Example
This example Creates a K8S Protection Policy with an 2 - hourly schedule,
and than adds  
$Storage_system=Get-PPDMstorage_systems | where type -match DATA_DOMAIN_SYSTEM
$Schedule=New-PPDMBackupSchedule -hourly -CreateCopyIntervalHrs 2 -RetentionUnit DAY -RetentionInterval 7
$Policy=New-PPDMK8SBackupPolicy -Schedule $Schedule -StorageSystemID $Storage_system.id -enabled -encrypted -Name CI_K8S_CLI
$AssetID=(Get-PPDMassets | where { $_.name -match "mongo" -and $_.subtype -eq "K8S_NAMESPACE"}).id
Add-PPDMProtection_policy_assignment -AssetID $AssetID -id $Policy.id
Runthe Protection via policy:
Start-PPDMprotection -PolicyObject $Policy -AssetIDs  $Asset.id

#>
function New-PPDMK8SBackupPolicy {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    [psobject]$Schedule,    
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    [ValidateLength(1, 150)][string]$Name,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    [ValidateLength(1, 150)][string]$StorageSystemID,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    [Alias('dataTargetId')][System.Guid]$StorageUnitID, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    [Alias('IfId')]$preferredInterfaceId, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    [Alias('BackupMode')][string][ValidateSet('FSS', 'VSS')]$SizeSegmentation = 'VSS',
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    [string]$SLAId,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    <# This Swich will enable the Policy #> 
    [switch]$enabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    [switch]$encrypted, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    [string]$Description = '' ,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    $apiver = "/api/v2",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'Set1')]
    <# noop Parameter will simulate the command only #> 
    [switch]$noop           
  )
  begin {
    $Response = @()
    $METHOD = "POST"
  }     
  Process {

    $URI = "/protection-policies"
  
    $operations = @()
    $copyoperation = @{}
    $copyoperation.Add('schedule', $Schedule.CopySchedule)
    $copyoperation.Add('backupType', 'SYNTHETIC_FULL')         


    $operations += $copyoperation 

    $Body = [ordered]@{ 
      'name'            = $Name
      'assetType'       = 'KUBERNETES'
      'type'            = 'ACTIVE'
      'dataConsistency' = 'CRASH_CONSISTENT'
      'enabled'         = $enabled.IsPresent
      'description'     = $Description
      'encrypted'       = $encrypted.IsPresent
      'priority'        = 1
      'passive'         = $false
      'forceFull'       = $false
      'details'         = @{
        'vm' = @{
          'protectionEngine' = 'VMDIRECT'
        }
      }
      'stages'          = @(
        @{
          'id'         = (New-Guid).Guid
          'slaId'      = $SLAId    
          'type'       = 'PROTECTION'
          'passive'    = $false
          'attributes' = @{}                     
          'target'     = @{
            'storageSystemId' = $StorageSystemID
          }
          'operations' = $operations
          'retention'  = $Schedule.Retention
        }
      ) 
    } 

    if ($preferredInterfaceId) {
      $Body.stages.target.Add('preferredInterfaceId', $preferredInterfaceId)
    }  
    if ($StorageUnitID) {
      $Body.stages.target.Add('dataTargetId', $StorageUnitID)
    }
    $Body = $body | convertto-json -Depth 7


        
    write-verbose ($body | out-string)
    $Parameters = @{
      RequestMethod    = 'Rest'
      body             = $body 
      Uri              = $URI
      Method           = $Method
      PPDM_API_BaseUri = $PPDM_API_BaseUri
      apiver           = $apiver
      Verbose          = $PSBoundParameters['Verbose'] -eq $true
    } 
    if (!$noop.IsPresent) {      
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


<#
.SYNOPSIS
Creates a Backup Policy for FileSystem
.EXAMPLE
$FSSchedule=New-PPDMBackupSchedule -hourly -CreateCopyIntervalHrs 8 -RetentionUnit DAY -RetentionInterval 5
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve.home.labbuildr.com"}
New-PPDMFSBackupPolicy -Schedule $FSSchedule -Name "Windows Cluster Filesystem" -Description "Windows Cluster File System Backup" -StorageSystemID $StorageSystem.id -enabled -indexingEnabled -ignoreMissingSystemStateFiles
.EXAMPLE
# This Approves an Agent, creates a Policy and assigns Assets

Set-PPDMWhitelist -IP hvnode2022.dpslab.home.labbuildr.com -state APPROVED
$FSSchedule=New-PPDMBackupSchedule -hourly -CreateCopyIntervalHrs 8 -RetentionUnit DAY -RetentionInterval 5
$StorageSystem=Get-PPDMStorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve.home.labbuildr.com"}
$Policy=New-PPDMFSBackupPolicy -Schedule $FSSchedule -Name "Windows Filesystem" -Description "Windows File System Backup" -StorageSystemID $StorageSystem.id -enabled -backupMechanism Auto
$Assets=Get-PPDMassets -filter 'details.fileSystem.clusterName in ("hvnode2022.dpslab.home.labbuildr.com")'
$Policy | Add-PPDMProtection_policy_assignment -AssetID $Assets.id
#>
function New-PPDMFSBackupPolicy {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [psobject]$Schedule,    
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [ValidateLength(1, 150)][string]$Name,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [ValidateLength(1, 150)][string]$StorageSystemID,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [Alias('dataTargetId')][System.Guid]$StorageUnitID, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [Alias('IfId')]$preferredInterfaceId, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    <# This Swich will enable the Policy #> 
    [switch]$enabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [switch]$encrypted, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [string]$Description = '' ,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [string[]]$FilterIDS,    
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$indexingEnabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$systemStateRecoveryOnly,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$ignoreMissingSystemStateFiles,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$excludeNonCriticalDynamicDisks,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$ignoreThirdPartyServices,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [string]$SLAId,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    $apiver = "/api/v2",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$TroubleshootingDebug,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'selfservice')]
    [ValidateSet("YEAR",
      "MONTH",
      "WEEK",
      "DAY")]
    [string]$RetentionUnit,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'selfservice')]
    [ValidateRange(1, 2555)][int]$RetentionInterval,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [ValidateSet("AUTO",
      # "BBB",
      "FBB")]
    <# Backup type using BBB, FBB or Auto #> 
    [string]$backupMechanism = "AUTO",     
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    <# noop Parameter will simulate the command only #> 
    [switch]$noop                  
  )
  begin {
    $Response = @()
    $METHOD = "POST"
  }     
  Process {
    $URI = "/protection-policies"
    switch ($pscmdlet.ParameterSetName ) {
      'centralized' { 
        $operations = @()
        if ($Schedule.CopySchedule) {
          $copyoperation = @{}
          $copyoperation.Add('schedule', $Schedule.CopySchedule)
          $copyoperation.Add('backupType', 'SYNTHETIC_FULL')
          $copyoperation.Add('id', ((New-Guid).GUID))    
          $operations += $copyoperation            
        }
        if ($Schedule.FullSchedule) {
          $fulloperation = @{}
          $fulloperation.Add('schedule', $Schedule.FullSchedule)
          $fulloperation.Add('backupType', 'FULL')    
          $operations += $fulloperation           
        }  
        [switch]$passive = $false
        $options = @{
          'indexingEnabled'                = $indexingEnabled.ispresent
          'systemStateRecoveryOnly'        = $systemStateRecoveryOnly.ispresent
          'ignoreMissingSystemStateFiles'  = $ignoreMissingSystemStateFiles.ispresent
          'excludeNonCriticalDynamicDisks' = $excludeNonCriticalDynamicDisks.ispresent
          'ignoreThirdPartyServices'       = $ignoreThirdPartyServices.ispresent
        }
      }
      Default {
        [switch]$passive = $true
        $schedule = @{}
        $schedule.add('Retention', @{})
        $schedule.Retention.add('interval', $RetentionInterval)
        $schedule.Retention.add('unit', $RetentionUnit)

      }
    }

    $Body = [ordered]@{ 
      'name'            = $Name
      'assetType'       = 'FILE_SYSTEM'
      'type'            = 'ACTIVE'
      'dataConsistency' = 'CRASH_CONSISTENT'
      'enabled'         = $enabled.IsPresent
      'description'     = $Description
      'encrypted'       = $encrypted.IsPresent
      'priority'        = 1
      'passive'         = $passive.IsPresent
      'forceFull'       = $false
      'stages'          = @(
        @{
          'id'         = (New-Guid).Guid   
          'type'       = 'PROTECTION'
          'passive'    = $passive.IsPresent
          'slaId'      = $SLAId 
          'attributes' = @{
            'protection' = @{
              'backupMechanism' = $backupMechanism
            }
            'fileSystem' = @{
              'troubleShootingOption' = "debugEnabled=$($TroubleshootingDebug.ToString().ToLower())"
            }
          }                     
          'target'     = @{
            'storageSystemId' = $StorageSystemID

          }
          'operations' = $operations
          'retention'  = $Schedule.Retention
          'options'    = $options
        }
      ) 
    }
    if ($FilterIDS) {
      $Body.Add('filterIds', $FilterIDS)
    }
    if ($preferredInterfaceId) {
      $Body.stages.target.Add('preferredInterfaceId', $preferredInterfaceId)
    }  
    if ($StorageUnitID) {
      $Body.stages.target.Add('dataTargetId', $StorageUnitID)
    }
    $Body = $Body | convertto-json -Depth 7


        
    write-verbose ($body | out-string)
    $Parameters = @{
      RequestMethod    = 'Rest'
      body             = $body 
      Uri              = $URI
      Method           = $Method
      PPDM_API_BaseUri = $PPDM_API_BaseUri
      apiver           = $apiver
      Verbose          = $PSBoundParameters['Verbose'] -eq $true
    } 
    if (!$noop.IsPresent) {      
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


function New-PPDMNASBackupPolicy {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [psobject]$Schedule,    
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [ValidateLength(1, 150)][string]$Name,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [ValidateLength(1, 150)][string]$StorageSystemID,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Alias('dataTargetId')][System.Guid]$StorageUnitID, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Alias('IfId')]$preferredInterfaceId, 
    [Parameter(Mandatory = $True, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    <# NASCid is a nad Credentials ID #>
    [Alias('NasCredentialsID')]$NASCid, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    <# This Swich will enable the Policy #> 
    [switch]$enabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$encrypted, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [string]$Description = '' ,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [string[]]$FilterIDS,    
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$indexingEnabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [ValidateSet("ACL_ACCESS_DENIED",
      "DATA_ACCESS_DENIED",
      "FILENAME_LENGTH_LIMIT_REACHED")][string[]]$ContinueOn,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [ValidateSet("FILENAME_LENGTH_LIMIT_REACHED")][string[]]$skipOn,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [string]$SLAId,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    $apiver = "/api/v2",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$TroubleshootingDebug,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    <# noop Parameter will simulate the command only #> 
    [switch]$noop                  
  )
  begin {
    $Response = @()
    $METHOD = "POST"
  }     
  Process {

    $URI = "/protection-policies"
    switch ($pscmdlet.ParameterSetName ) {
      'centralized' { 
        $operations = @()
        if ($Schedule.CopySchedule) {
          $copyoperation = @{}
          $copyoperation.Add('schedule', $Schedule.CopySchedule)
          $copyoperation.Add('backupType', 'SYNTHETIC_FULL')
          $copyoperation.Add('id', ((New-Guid).GUID))    
          $operations += $copyoperation            
        }
        if ($Schedule.FullSchedule) {
          $fulloperation = @{}
          $fulloperation.Add('schedule', $Schedule.FullSchedule)
          $fulloperation.Add('backupType', 'FULL')    
          $operations += $fulloperation           
        }  
        [switch]$passive = $false
        $options = @{
          'debugEnabled'    = $($TroubleshootingDebug.ToString().ToLower())
          'indexingEnabled' = $indexingEnabled.ispresent
          'continueOn'      = @($ContinueOn)
          'skipOn'          = @($skipOn)
        }
      }

    }
    $credentials = @{
      'id'   = $NasCID
      'type' = 'NAS'
    }
    $Body = [ordered]@{ 
      'name'            = $Name
      'assetType'       = 'NAS_SHARE'
      'type'            = 'ACTIVE'
      'dataConsistency' = 'CRASH_CONSISTENT'
      'filterIds'       = $FilterIDS
      'enabled'         = $enabled.IsPresent
      'description'     = $Description
      'encrypted'       = $encrypted.IsPresent
      'priority'        = 1
      'passive'         = $passive.IsPresent
      'forceFull'       = $false
      'stages'          = @(
        @{
          'id'         = (New-Guid).Guid   
          'type'       = 'PROTECTION'
          'passive'    = $passive.IsPresent
          'slaId'      = $SLAId 
          'attributes' = @{}                     
          'target'     = @{
            'storageSystemId' = $StorageSystemID
          }
          'operations' = $operations
          'retention'  = $Schedule.Retention
          'options'    = $options
        }
      )
      'credentials'     = $credentials 
    } 
    if ($preferredInterfaceId) {
      $Body.stages.target.Add('preferredInterfaceId', $preferredInterfaceId)
    }  
    if ($StorageUnitID) {
      $Body.stages.target.Add('dataTargetId', $StorageUnitID)
    }
    
    $Body = $Body | convertto-json -Depth 7
    write-verbose ($body | out-string)
    $Parameters = @{
      RequestMethod    = 'Rest'
      body             = $body 
      Uri              = $URI
      Method           = $Method
      PPDM_API_BaseUri = $PPDM_API_BaseUri
      apiver           = $apiver
      Verbose          = $PSBoundParameters['Verbose'] -eq $true
    } 
    if (!$noop.IsPresent) {      
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
<#
.SYNOPSIS

.EXAMPLE
# Create a new AppAware MSSQL Policy using TSDM
$Credentials=New-PPDMcredentials -type OS -name sqldemoaccount -authmethod BASIC
$StorageSystem=Get-PPDMstorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve.home.labbuildr.com"}
$BackupSchedule=New-PPDMDatabaseBackupSchedule -daily -LogBackupUnit HOURLY -LogBackupInterval 1 -RetentionUnit DAY -RetentionInterval 3
New-PPDMSQLBackupPolicy -Schedule $BackupSchedule -Name MMSSQL_APPAWARE -AppAware -dbCID $credentials.id -StorageSystemID $StorageSystem.id -DataMover SDM -SizeSegmentation FSS

.EXAMPLE
# Create a New SelfServicee MSSQL Policy
```Powershell
$Credentials=New-PPDMcredentials -type OS -name sqldemoaccount -authmethod BASIC
$StorageSystem=Get-PPDMstorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve.home.labbuildr.com"}
$BackupSchedule=New-PPDMDatabaseBackupSchedule -daily -LogBackupUnit HOURLY -LogBackupInterval 1 -RetentionUnit DAY -RetentionInterval 3
New-PPDMSQLBackupPolicy  -Name MSSQL_SELF -RetentionUnit DAY -RetentionInterval 1 -StorageSystemID $StorageSystem.id
.EXAMPLE
# Create a new Centralized MSSQL Policy
$Credentials=New-PPDMcredentials -type OS -name sqldemoaccount -authmethod BASIC
$StorageSystem=Get-PPDMstorage_systems -Type DATA_DOMAIN_SYSTEM -Filter {name eq "ddve.home.labbuildr.com"}
$BackupSchedule=New-PPDMDatabaseBackupSchedule -daily -LogBackupUnit HOURLY -LogBackupInterval 1 -RetentionUnit DAY -RetentionInterval 3
New-PPDMSQLBackupPolicy -Schedule $BackupSchedule -Name MSSQL_CENTRAL  -dbCID $credentials.id -StorageSystemID $StorageSystem.id

#>
function New-PPDMSQLBackupPolicy {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    [switch]$AppAware, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    [ValidateSet('VADP', 'SDM')]
    [string]$DataMover = "SDM",
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    [ValidateSet('VSS', 'FSS')]
    [string]$SizeSegmentation = "FSS",    
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    [switch]$ExcludeSwapfiles,          
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [psobject]$Schedule,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [string]$dbCID,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [ValidateLength(1, 150)][string]$Name,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [ValidateLength(1, 150)][string]$StorageSystemID,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [Alias('dataTargetId')][Guid]$StorageUnitID,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [Alias('IfId')]$preferredInterfaceId, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [string]$SLAId,      
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    <# This Swich will enable the Policy #> 
    [switch]$enabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [switch]$encrypted, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [string]$Description = '' ,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$TroubleshootingDebug,

    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [ValidateSet(
      'ALL',
      'NONE',
      'NONE_WITH_WARNINGS'
    )][string]$promotionType = "ALL",

    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$skipSimpleDatabase,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$skipUnprotectableState,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$excludeSystemDatabase,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'selfservice')]
    [ValidateSet("YEAR",
      "MONTH",
      "WEEK",
      "DAY")]
    [string]$RetentionUnit,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'selfservice')]
    [ValidateRange(1, 2555)][int]$RetentionInterval,    
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    <# noop Parameter will simulate the command only #> 
    [switch]$noop,                  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    $apiver = "/api/v2"
  )
  begin {
    $Response = @()
    $METHOD = "POST"
  }     
  Process {

    $URI = "/protection-policies"
  
    switch ($pscmdlet.ParameterSetName ) {
      'appaware' {
        $operations = @()
        $copyoperation = @{}
        $copyoperation.Add('schedule', $Schedule.CopySchedule)
        $copyoperation.Add('backupType', 'FULL')         
        $operations += $copyoperation 
        $mssql_credentials = @{
          'id'   = $dbCID
          'type' = 'OS'
        }
        if ($schedule.differentialSchedule) {
          $operations += $schedule.differentialSchedule   
        }
        if ($schedule.logSchedule) {
          $operations += $schedule.logSchedule   
        }
        [switch]$passive = $false
        $Stages = @{}
        $stages.Add('id', (New-Guid).Guid) 
        $stages.Add('type', 'PROTECTION')
        $stages.Add('passive', $passive.IsPresent)
        $Stages.Add('slaId', $SLAId)
        $Stages.Add('target', @{
            'storageSystemId' = $StorageSystemID
          })
        if ($preferredInterfaceId) {
          $Stages.target.Add('preferredInterfaceId', $preferredInterfaceId)
        }  
        if ($StorageUnitID) {
          $Stages.target.Add('dataTargetId', $StorageUnitID)
        }
        $Stages.Add('operations' , $operations)
        $Stages.Add('retention'  , $Schedule.Retention)
      }
      "centralized" {
        $operations = @()
        $copyoperation = @{}
        $copyoperation.Add('schedule', $Schedule.CopySchedule)
        $copyoperation.Add('backupType', 'FULL')         
        $operations += $copyoperation 
        $mssql_credentials = @{
          'id'   = $dbCID
          'type' = 'OS'
        }
        if ($schedule.differentialSchedule) {
          $operations += $schedule.differentialSchedule   
        }
        if ($schedule.logSchedule) {
          $operations += $schedule.logSchedule   
        }
        [switch]$passive = $false
        $mssql_options = @{}
        $mssql_options.Add('excludeSystemDatabase', $excludeSystemDatabase.IsPresent)
        $mssql_options.Add('troubleShootingOption', "debugEnabled=$($TroubleshootingDebug.ToString().ToLower())")
        $stages = @{
          'id'         = (New-Guid).Guid   
          'type'       = 'PROTECTION'
          'passive'    = $passive.IsPresent
          'attributes' = @{
            'mssql' = $mssql_options
          }                     
          'operations' = $operations
          'options'    = @{
            "skipSimpleDatabase"     = $skipSimpleDatabase.IsPresent
            "skipUnprotectableState" = $skipUnprotectableState.IsPresent
            "promotionType"          = $promotionType

          }
        }
        $stages.Add('retention', $Schedule.retention)
        $Stages.Add('target', @{
            'storageSystemId' = $StorageSystemID
          })
        if ($preferredInterfaceId) {
          $Stages.target.Add('preferredInterfaceId', $preferredInterfaceId)
        }  
        if ($StorageUnitID) {
          $Stages.target.Add('dataTargetId', $StorageUnitID)
        }

      }

      "selfservice" {
        [switch]$passive = $true
        $mssql_options = @{}
        $schedule = @{}
        $schedule.add('Retention', @{})
        $schedule.Retention.add('interval', $RetentionInterval)
        $schedule.Retention.add('unit', $RetentionUnit)
        $stages = @{
          'id'         = (New-Guid).Guid   
          'type'       = 'PROTECTION'
          'passive'    = $passive.IsPresent
          'attributes' = @{
            'mssql' = $mssql_options
          }                     
          'target'     = @{
            'storageSystemId' = $StorageSystemID
          }
          'retention'  = $Schedule.Retention
        }
        $Stages.Add('target', @{
            'storageSystemId' = $StorageSystemID
          })
        if ($preferredInterfaceId) {
          $Stages.target.Add('preferredInterfaceId', $preferredInterfaceId)
        }  
        if ($StorageUnitID) {
          $Stages.target.Add('dataTargetId', $StorageUnitID)
        }
      }
    }
    if ($AppAware.IsPresent) {
      Write-Verbose "Checking AppAware"
      $stages.Add('attributes', @{})
      $Stages.attributes.Add('vm', @{})
      $stages.attributes.vm.Add('appConsistentProtection', $false)
      $stages.attributes.vm.Add('dataMoverType', $DataMover)
      $stages.attributes.vm.Add('excludeSwapFiles', $ExcludeSwapfiles.IsPresent)
      $Stages.attributes.Add('protection', @{})
      $Stages.attributes.protection.Add('backupMode', $SizeSegmentation)
      $AssetType = 'VMWARE_VIRTUAL_MACHINE'
      $details = @{}
      $details.Add('vm', @{}) 
      $details.vm.Add('protectionEngine', 'VMDIRECT')
      switch ($DataMover) {
        'SDM' {
          Write-Verbose "Excluding swap for TSDM"
          $stages.attributes.vm.excludeSwapFiles = $false
          $stages.attributes.vm.disableQuiescing = $false
          Write-Verbose "Done"
        }
      }
    }
    else {
      $AssetType = 'MICROSOFT_SQL_DATABASE'
    }
    $Body = [ordered]@{
      'assetType'       = $AssetType
      'name'            = $Name
      'credentials'     = $mssql_credentials
      'type'            = 'ACTIVE'
      'dataConsistency' = 'APPLICATION_CONSISTENT'
      'enabled'         = $enabled.IsPresent
      'description'     = $Description
      'encrypted'       = $encrypted.IsPresent
      'filterIds'       = @()
      'priority'        = 1
      'passive'         = $passive.IsPresent
      'forceFull'       = $false
      'stages'          = @($stages)
       
    } 
    if ($details) {
      $body.Add('details', $details)
    }
    

    $Body = $Body  | convertto-json -Depth 7
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
    if (!$noop.IsPresent) {      
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
<#
.Synopsis
Creates an Centralized or Self Service Primary Backup Policy
.Description
Parametersets are Used to define Centralized or Self-Service Policies
For Centralized Backups, a Schedule Object creted with  must be Provided

.Example
schedule=New-PPDMBackupSchedule -hourly_w_full_weekly -CreateCopyIntervalHrs 2 -CreateFull_Every_DayofWeek SUNDAY -RetentionUnit DAY -RetentionInterval 7 
New-PPDMExchangeBackupPolicy -Schedule $sched -StorageSystemID ed9a3cd6-7e69-4332-a299-aaf258e23328 -consistencyCheck LOGS_ONLY -enabled -encrypted -Name CI_EX_CLI_CENTRAL2         
                                                                                                                                                                 id                             : 3e709bac-a575-4660-b4a0-80b61bc3c832                                                                                            name                           : CI_EX_CLI_CENTRAL2                                                                                                              description                    :                                                                                                                                 
assetType                      : MICROSOFT_EXCHANGE_DATABASE
type                           : ACTIVE
targetStorageProvisionStrategy : AUTO_PROVISION
enabled                        : True
passive                        : False
forceFull                      : False
priority                       : 1
credentials                    : 
encrypted                      : True
dataConsistency                : APPLICATION_CONSISTENT
complianceInterval             : 
details                        : 
summary                        : @{numberOfAssets=0; totalAssetCapacity=0; totalAssetProtectionCapacity=0; numberOfJobFailures=0; numberOfSlaFailures=0; 
                                 numberOfSlaSuccess=0; lastExecutionStatus=IDLE}
stages                         : {@{id=dc394753-3f1a-4d7d-a3dc-610ef803a55e; type=PROTECTION; passive=False; retention=; target=; attributes=; 
                                 operations=System.Object[]}}
filterIds                      : {}
createdAt                      : 05.05.2021 05:03:39
updatedAt                      : 05.05.2021 05:03:39
slaId                          : 
_links                         : @{self=}

#>
function New-PPDMExchangeBackupPolicy {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [psobject]$Schedule,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [ValidateLength(1, 150)][string]$Name,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [ValidateLength(1, 150)][string]$StorageSystemID,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [Alias('dataTargetId')][System.Guid]$StorageUnitID, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [Alias('IfId')]$preferredInterfaceId, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    <# This Swich will enable the Policy #> 
    [switch]$enabled,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [switch]$encrypted, 
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [string]$Description = '' ,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    $apiver = "/api/v2",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [switch]$TroubleshootingDebug,

    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [string][ValidateSet("NONE",
      "ALL",
      "LOGS_ONLY",
      "DATABASE_ONLY")]$consistencyCheck,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'selfservice')]
    [ValidateSet("YEAR",
      "MONTH",
      "WEEK",
      "DAY")]
    [string]$RetentionUnit,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'selfservice')]
    [ValidateRange(1, 2555)][int]$RetentionInterval,    
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    <# noop Parameter will simulate the command only #> 
    [switch]$noop                  
  )
  begin {
    $Response = @()
    $METHOD = "POST"
  }     
  Process {

    $URI = "/protection-policies"
  
    switch ($pscmdlet.ParameterSetName ) {
      'centralized' { 
        $operations = @()
        if ($Schedule.CopySchedule) {
          $copyoperation = @{}
          $copyoperation.Add('schedule', $Schedule.CopySchedule)
          $copyoperation.Add('backupType', 'SYNTHETIC_FULL')         
          $copyoperation.Add('type', 'AUTO_FULL')
          $operations += $copyoperation            
        }
      

        if ($Schedule.FullSchedule) {
          $fulloperation = @{}
          $fulloperation.Add('schedule', $Schedule.FullSchedule)
          $fulloperation.Add('backupType', 'FULL')         
          $fulloperation.Add('type', 'GEN0')         
          $operations += $fulloperation           
        }  




        $exchange_options = @{
          'troubleShootingOption' = "debugEnabled=$($TroubleshootingDebug.ToString().ToLower())"
          'consistencyCheck'      = $consistencyCheck
        }

        [switch]$passive = $false

      }
      Default {
        [switch]$passive = $true
        $exchange_options = @{}
        $schedule = @{}
        $schedule.add('Retention', @{})
        $schedule.Retention.add('interval', $RetentionInterval)
        $schedule.Retention.add('unit', $RetentionUnit)

      }
    }

    $Body = [ordered]@{ 
      'name'            = $Name
      'assetType'       = 'MICROSOFT_EXCHANGE_DATABASE'
      'credentials'     = $exchange_credentials
      'type'            = 'ACTIVE'
      'dataConsistency' = 'APPLICATION_CONSISTENT'
      'enabled'         = $enabled.IsPresent
      'description'     = $Description
      'encrypted'       = $encrypted.IsPresent
      'filterIds'       = @()
      'priority'        = 1
      'passive'         = $passive.IsPresent
      'forceFull'       = $false
      'stages'          = @(
        @{
          'id'         = (New-Guid).Guid   
          'type'       = 'PROTECTION'
          'passive'    = $passive.IsPresent
          'attributes' = @{
            'exchange' = $exchange_options
          }                     
          'target'     = @{
            'storageSystemId' = $StorageSystemID
          }
          'operations' = $operations
          'retention'  = $Schedule.Retention
        }
      ) 
    } 

    if ($preferredInterfaceId) {
      $Body.stages.target.Add('preferredInterfaceId', $preferredInterfaceId)
    }  
    if ($StorageUnitID) {
      $Body.stages.target.Add('dataTargetId', $StorageUnitID)
    }
    $Body = $Body | convertto-json -Depth 7


        
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
    if (!$noop.IsPresent) {      
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



function New-PPDMOracleBackupPolicy {
  [CmdletBinding()]
  param(
    #  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    # [switch]$AppAware, 
    #  [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    #  [ValidateSet('VADP', 'SDM')]
    # [string]$DataMover = "SDM",
    #  [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    #  [ValidateSet('VSS', 'FSS')]
    #  [string]$SizeSegmentation = "FSS",    
    #  [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    #  [switch]$ExcludeSwapfiles,          
    #  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [psobject]$Schedule,
    #  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [string]$dbCID,
    #  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [ValidateLength(1, 150)][string]$Name,
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [ValidateLength(1, 150)][string]$StorageSystemID,
    #  [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [Alias('dataTargetId')]
    [System.Guid]$StorageUnitID,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [Alias('IfId')]$preferredInterfaceId, 
    #  [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [System.Guid]$SLAId,      
    #  [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    <# This Swich will enable the Policy #> 
    [switch]$enabled,
    #  [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [switch]$encrypted, 
    #  [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    [string]$Description = '' ,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [ValidateSet("SBT", 'OIM')]
    [string]$backupMechanism = "SBT",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [switch]$TroubleshootingDebug,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [ValidateRange(0, 3650)][int64]$archiveLogDeletionDays,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [ValidateRange(1, 64)][int64]$filesPerSet,    
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [ValidateRange(1, 4000)][int64]$maximumOpenFiles,   
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [ValidateRange(1, 1024)][int64]$blockSizeKB,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [ValidateRange(1, 1024)][int64]$sectionSize,  
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [ValidateSet("K",
      "M",
      "G")]
    [string]$sectionSizeUnit = "KB",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [ValidateSet("NONE",
      "SYNC",
      "ASYNC")]
    [string]$RecoveryCatalogOption = "NONE",
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-oim')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'selfservice')]
    [ValidateSet("YEAR",
      "MONTH",
      "WEEK",
      "DAY")]
    [string]$RetentionUnit,

    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ParameterSetName = 'selfservice')]
    [ValidateRange(1, 2555)][int]$RetentionInterval,    
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    # [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    <# noop Parameter will simulate the command only #> 
    [switch]$noop,                  
    # [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    $PPDM_API_BaseUri = $Global:PPDM_API_BaseUri,
    # [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'appaware')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'centralized-sbt')]
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ParameterSetName = 'selfservice')]
    $apiver = "/api/v2"
  )
  begin {
    $Response = @()
    $METHOD = "POST"
  }     
  Process {

    $URI = "/protection-policies"
  
    switch ($pscmdlet.ParameterSetName ) {
      <#      'appaware' {
        $operations = @()
        $copyoperation = @{}
        $copyoperation.Add('schedule', $Schedule.CopySchedule)
        $copyoperation.Add('backupType', 'FULL')         
        $operations += $copyoperation 
        $oracle_credentials = @{
          'id'   = $dbCID
          'type' = 'OS'
        }
        if ($schedule.differentialSchedule) {
          $operations += $schedule.differentialSchedule   
        }
        if ($schedule.logSchedule) {
          $operations += $schedule.logSchedule   
        }
        [switch]$passive = $false
        $Stages = @{}
        $stages.Add('id', (New-Guid).Guid) 
        $stages.Add('type', 'PROTECTION')
        $stages.Add('passive', $passive.IsPresent)
        $Stages.Add('slaId', $SLAId)
        $Stages.Add('target', @{})
        
        $Stages.Target.Add('storageSystemId', $StorageSystemID)
        if ($StorageUnitID) {
          $Stages.target.Add('dataTargetId', $StorageUnitID)
        }
        $Stages.Add('operations' , $operations)
        $Stages.Add('retention'  , $Schedule.Retention)
      }
#>
      { ($_ -eq "centralized-sbt") -or ($_ -eq "centralized-oim") } {
        #"centralized-sbt" 
        $details = @{ 
          'oracle' = @{
            'dbConnection' = @{
              'tnsName'  = ""
              'tnsAdmin' = ""
            }
          }

        }
        
        <# #>

        $operations = @()
        $copyoperation = @{}
        $copyoperation.Add('schedule', $Schedule.CopySchedule)
        $extendedRetentions = @()
        switch ($backupMechanism) {
          'SBT' { 
            $copyoperation.Add('backupType', 'FULL')
          }    
          'OIM' {
            $copyoperation.Add('backupType', 'SYNTHETIC_FULL')
            $extendedRetentions += @{
              "retention" = @{
                'id'                         = (New-Guid).Guid 
                'storageSystemRetentionLock' = $false
                'unit'                       = "WEEK"
                'interval'                   = 3
              }
              'selector'  = @{
                'backupType' = 'INCREMENTAL'
              }
              
            }
            $extendedRetentions += @{
              "retention" = @{
                'id'                         = (New-Guid).Guid 
                'storageSystemRetentionLock' = $false
                'unit'                       = $Schedule.retention.Unit
                'interval'                   = $Schedule.retention.interval
              }
              'selector'  = @{
                'backupType' = 'SYNTHETIC_FULL'
              }
              
            }
          }
        }
             
        $operations += $copyoperation 
        #        $oracle_credentials = (Get-PPDMcredentials -Id $dbCID)
        $oracle_credentials = @{
          'id'   = $dbCID
          'type' = 'OS'
        }
        if ($schedule.differentialSchedule) {
          $operations += $schedule.differentialSchedule   
        }
        if ($schedule.logSchedule) {
          $operations += $schedule.logSchedule   
        }
        if ($schedule.cumulativeSchedule) {
          $operations += $schedule.cumulativeSchedule   
        }
        [switch]$passive = $false
        $oracle_options = @{}
        if ($archiveLogDeletionDays) {
          $oracle_options.Add('archiveLogDeletionDays', $archiveLogDeletionDays)
        }
        $options = @{
          "syncCatalog" = $RecoveryCatalogOption
        }
        If ($filesPerSet) {
          $options.Add('filesPerSet', $filesPerSet)
        }
        If ($blockSizeKB) {
          $options.Add('blockSize', "$($blockSizeKB)K" )
        }
        If ($sectionSize) {
          $options.Add('sectionSize', "$sectionSize$sectionSizeUnit" )
        }
        $oracle_options.Add('troubleShootingOption', "debugEnabled=$($TroubleshootingDebug.ToString().ToLower())")
        $stages = @{
          'id'                 = (New-Guid).Guid   
          'type'               = 'PROTECTION'
          'passive'            = $passive.IsPresent
          'attributes'         = @{
            'oracle'     = $oracle_options
            'protection' = @{
              'backupMechanism' = $backupMechanism
            }
          }                     
          'target'             = @{
            'storageSystemId' = $StorageSystemID
          }
          'operations'         = $operations
          'options'            = $options
          'retention'          = $Schedule.retention
          'extendedRetentions' = $extendedRetentions
          
        }

        if ($preferredInterfaceId) {
          $Stages.target.Add('preferredInterfaceId', $preferredInterfaceId)
        }  
        if ($StorageUnitID) {
          $Stages.target.Add('dataTargetId', $StorageUnitID)
        }
      }

      "selfservice" {
        [switch]$passive = $true
        $oracle_options = @{}
        $schedule = @{}
        $schedule.add('Retention', @{})
        $schedule.Retention.add('interval', $RetentionInterval)
        $schedule.Retention.add('unit', $RetentionUnit)
        $stages = @{
          'id'         = (New-Guid).Guid   
          'type'       = 'PROTECTION'
          'passive'    = $passive.IsPresent
          'attributes' = @{
            'oracle' = $oracle_options
          }                     
          'target'     = @{
            'storageSystemId' = $StorageSystemID
          }
          'retention'  = $Schedule.Retention
        }
        $Stages.Add('target', @{
            'storageSystemId' = $StorageSystemID
          })
        if ($preferredInterfaceId) {
          $Stages.target.Add('preferredInterfaceId', $preferredInterfaceId)
        }  
        if ($StorageUnitID) {
          $Stages.target.Add('dataTargetId', $StorageUnitID)
        }
      }
    }
    if ($AppAware.IsPresent) {
      Write-Verbose "Checking AppAware"
      $stages.Add('attributes', @{})
      $Stages.attributes.Add('vm', @{})
      $stages.attributes.vm.Add('appConsistentProtection', $false)
      $stages.attributes.vm.Add('dataMoverType', $DataMover)
      $stages.attributes.vm.Add('excludeSwapFiles', $ExcludeSwapfiles.IsPresent)
      $Stages.attributes.Add('protection', @{})
      $Stages.attributes.protection.Add('backupMode', $SizeSegmentation)
      $AssetType = 'VMWARE_VIRTUAL_MACHINE'
      $details = @{}
      $details.Add('vm', @{}) 
      $details.vm.Add('protectionEngine', 'VMDIRECT')
      switch ($DataMover) {
        'SDM' {
          Write-Verbose "Excluding swap for TSDM"
          $stages.attributes.vm.excludeSwapFiles = $false
          $stages.attributes.vm.disableQuiescing = $false
          Write-Verbose "Done"
        }
      }
    }
    else {
      $AssetType = 'ORACLE_DATABASE'
    }
    $Body = [ordered]@{
      'assetType'       = $AssetType
      'name'            = $Name
      'credentials'     = $oracle_credentials
      'type'            = 'ACTIVE'
      'dataConsistency' = 'APPLICATION_CONSISTENT'
      'enabled'         = $enabled.IsPresent
      'description'     = $Description
      'encrypted'       = $encrypted.IsPresent
      'filterIds'       = @()
      'priority'        = 1
      'passive'         = $passive.IsPresent
      'forceFull'       = $false
      'stages'          = @($stages)
      'slaId'           = $SLAId        
    } 
    if ($details) {
      $body.Add('details', $details)
    }

    $Body = $Body  | convertto-json -Depth 7
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
    if (!$noop.IsPresent) {      
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


function Set-PPDMProtection_Policies {
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
    $METHOD = "PUT"
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

<#
.Synopsis
Creates an Centralized or Self Service Primary Backup Policy
.Description
Parametersets are Used to define Centralized or Self-Service Policies
For Centralized Backups, a Schedule Object creted with  must be Provided

.Example
Get Protection Policy with Policy Filter 'objectives.config.backupMechanism eq "AUTO"'
backup Mechanisms can be 
          - SBT
          - OIM
          - FBB
          - BBB
          - AUTO
          - VADP
          - SDM
Get-PPDMprotection_policy_summaries -Policyfilter 'objectives.config.backupMechanism eq "AUTO"'
#>
function Get-PPDMprotection_policy_summaries {
  [CmdletBinding()]
  param(
      [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
      $filter,
      [Parameter(Mandatory = $false, ParameterSetName = 'all', ValueFromPipelineByPropertyName = $true)]
      $Policyfilter,      
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
      if ($policyFilter) {
        $parameters.Add('policyFilter', $Policyfilter)
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

