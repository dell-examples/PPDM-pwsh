Function Get-PPDMWebException {
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        [System.Management.Automation.ErrorRecord]$ExceptionMessage
    )
    $type = $MyInvocation.MyCommand.Name -replace "Get-", "" -replace "WebException", ""
        
    switch -Wildcard ($ExceptionMessage.FullyQualifiedErrorId) {

        default {
            Write-Host -Foregroundcolor White "$($ExceptionMessage.ToString())"
#            Write-Host -ForegroundColor Cyan "error not yet declared or no specific returncode"
#            Write-host -Foregroundcolor Gray "Exception caught at '$($ExceptionMessage.InvocationInfo.InvocationName) '
#Calling Position: $($ExceptionMessage.InvocationInfo.PositionMessage)
#$($ExceptionMessage.FullyQualifiedErrorId)"
        }
    }
}
