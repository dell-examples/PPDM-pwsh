#
# Module manifest for module 'PPDM-pwsh'
#
# Generated by: Karsten.Bott@dell.com
#
# Generated on: 03/09/2020
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PPDM-pwsh.psm1'

# Version number of this module.
ModuleVersion = '19.8.9'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '779958a6-5b27-44b0-a37d-cb0db8f068e7'

# Author of this module
Author = 'karsten.bott@dell.com'

# Company or vendor of this module
CompanyName = 'Private build by individual'

# Copyright statement for this module
Copyright = '(c) 2021 karsten.bott@dell.com. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Powershell Module to interact with the PowerProdect Data Manager (PPDM) API'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @(
    './errors/errors',
    './modules/clouddr',
    './modules/storage',
    './modules/cndm',
    './modules/credentials',
    './modules/agents',
    './modules/assets',
    './modules/activity',
    './modules/protection_policies',
    './modules/secrets',
    './modules/inventory',
    './modules/copies',
    './modules/user',
    './modules/monitoring',
    './modules/sdr',
    './modules/locations',
    './modules/appliance-management'
)

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Wait-PPDMApplianceFresh',
    'Connect-PPDMapiEndpoint',
    'Disconnect-PPDMsession',
    'Get-PPDMassets',
    'Get-PPDMactivities',
    'Restart-PPDMactivities',
    'New-PPDMUsers',
    'Unblock-PPDMSSLCerts',
    'Update-PPDMAccessToken',
    'Invoke-PPDMapirequest',
    'Start-PPDMasset_backups',
    'Get-PPDMprotection_engines',
    'Get-PPDMprotection_policies',
    'New-PPDMprotection_policies',
    'Get-PPDMdiscoveries',
    'Start-PPDMprotection_policies',
    'Start-PPDMdiscoveries',
    'Update-PPDMtoken',
    'Get-PPDMcommon_settings',
    'Get-PPDMinventory_sources',  
    'Add-PPDMinventory_sources',
    'Remove-PPDMinventory_sources',   
    'Get-PPDMcomponents',
    'Get-PPDMconfigurations',
    'Set-PPDMconfigurations',
    'Get-PPDMconfigStatus',
    'Get-PPDMnodes',
    'Set-PPDMnodes',    
    'Get-PPDMDisks',
    'Get-PPDMcloud_dr_accounts',
    'Set-PPDMcomponents',
    'Get-PPDMdata_targets',
    'Get-PPDMdatadomain_mtrees',
    'Get-PPDMstorage_systems',
    'Set-PPDMstorage_systems',
    'Get-PPDMcloud_dr_server_deployment',
    'Get-PPDMcloud_dr_server_version',
    'Get-PPDMTELEMETRY_SETTING',
    'Get-PPDMcloud_dr_data_targets',
    'Get-PPDMcloud_dr_storage_containers',
    'Get-PPDMcloud_dr_server_configuration',
    'Get-PPDMcloud_dr_sessions',
    'Get-PPDMcloud_dr_vcenters',
    'Get-PPDMdatadomain_cloud_units',
    'Get-PPDMkubernetes_clusters',
    'Get-PPDMpvc_storage_class_mappings',
    'Get-PPDMdatadomain_ddboost_encryption_settings',
    'Get-PPDMcredentials',
    'New-PPDMcredentials',
    'Remove-PPDMcredentials',
    'Get-PPDMagents_list',
    'Get-PPDMagent_registration_status',
    'Get-PPDMalerts',
    'Set-PPDMalerts_acknowledgement',
    'Get-PPDMcopy_map',
    'Get-PPDMactivity_metrics',
    'Approve-PPDMEula',
    'Get-PPDMCertificates',
    'Update-PPDMCertificates',
    'Approve-PPDMCertificates',,
    'Remove-PPDMCertificates',
    'Get-PPDMCopies',
    'Get-PPDMUser_groups',
    'Get-PPDMUsers',
    'Get-PPDMroles',
    'Get-PPDMWebException',
    'Get-PPDMprotection_details',
    'Get-PPDMlatest_copies',
    'Get-PPDMTimezones',
    'Get-PPDMserver_disaster_recovery_configurations',
    'Set-PPDMserver_disaster_recovery_configurations',
    'Get-PPDMserver_disaster_recovery_backups',
    'New-PPDMserver_disaster_recovery_backups',
    'Remove-PPDMserver_disaster_recovery_backups',
    'Update-PPDMserver_disaster_recovery_backups',
    'Get-PPDMserver_disaster_recovery_hosts',
    'Get-PPDMserver_disaster_recovery_status',
    'Get-PPDMLocations',
    'New-PPDMLocations',
    'Remove-PPDMLocations',
    'Get-PPDMsmtp',
    'New-PPDMsmtp',
    'Set-PPDMsmtp',
    'Remove-PPDMsmtp',
    'Get-PPDMprotection_storage_metrics',
    'New-PPDMVMPrimaryBackupPolicy',
    'Remove-PPDMprotection_policies',
    'Add-PPDMProtection_policy_assignment',
    'Remove-PPDMProtection_policy_assignment',
    'New-PPDMBackupSchedule',
    'New-PPDMVMBackupPolicy',
    'New-PPDMFSBackupPolicy',
    'New-PPDMDatabaseBackupSchedule',
    'New-PPDMSQLBackupPolicy',
    'New-PPDMExchangeBackupPolicy',
    'Set-PPDMcertificates',
    'Start-PPDMprotection'    
    )

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('PPDM','PowerProtect','PowerProtect_Datamanager','DELLEMC','DELL','BRS')

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
         ProjectUri = 'https://github.com/bottkars/PPDM-pwsh'

        # A URL to an icon representing this module.
        IconUri = 'https://vectorified.com/images/dell-emc-icon-12.png'

        # ReleaseNotes of this module
        ReleaseNotes = '
        2021-05-06:
        - added Pre-Release for new 19.8
        - adeed Protection Policy Managemnt Step 1
        - Introduced Query and Pagination       
        2021-02-13:
        - added alert acknowledgement by id
        2020-11-01:
        - added Server Disaster Recovers
        2020-10-28:
        - adding inventory_sources 
        2020-10-27:
        - added certs management
        2020-10-09:
        Added Miles Features
        - clouddr
        - STorage 
        - SPBM
        2019-12-09:
        Initial module version supporting PDM API 1.5 onwards
        - added diconnect (removes Global Variables )
        - added force connect (removes Global Variables )
        '
        Prerelease = 'Pre'
    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

