[CmdletBinding()]
Param
(
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName,ValueFromPipeline)]
    [string]$Name,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName,ValueFromPipeline)]
    [int64]$EmployeeId,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName,ValueFromPipeline)]
    [string]$Department,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName,ValueFromPipeline)]
    [string]$City
)

Process
{
    Write-Output "============================"
    Write-Output "Name: $Name`nDepartment: $Department`nEmployeeId: $EmployeeId`nCity: $City"
    Write-Output "============================"
}