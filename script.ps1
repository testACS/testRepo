param(
[Parameter(Mandatory=$true,ValueFromPipeline,ValueFromPipelineByPropertyName)]
[string]$a,
[string]$b
)

Write-Output "`$a = $a"
Write-Output "`$b = $b"

if($a -eq '1')
{
    Write-Output "`$a is EQUAL to 1."
}
elseif ($a -ne '1')
{
   Write-Output "$a is NOT EQUAL to 1." 
}
