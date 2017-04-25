

$x = Get-S3Object -BucketName prod-cloudwatch-log-archive -Key prod-log-groups-prodRIWebsiteLogs-1QEXT9O7CJEO9 -Region eu-west-1 -AccessKey $AKProd -SecretKey $SKProd -Verbose | `
select BucketName, @{n="File";e={($_.Key)}}, LastModified, @{n="Size";e={[math]::Round(($_.Size / 1MB ), 2)}} | `
? {$_.LastModified -ge ([DateTime]::Today.AddDays(-2).AddHours(18)) -and ($_.File -notlike '*aws-logs-w*')} | sort LastModified

$WebS3Objects = $x | ? {$_.LastModified -le ([DateTime]::Today.AddDays(-1).AddHours(18))}
$WebS3Objects | % {Read-S3Object -BucketName $_.BucketName -Key $_.File -File .\Logs\$($_.File.Trim("/b689d251-4aa5-4666-a7ac-793964e0a08e").Replace("/","-")) -Region eu-west-1 -AccessKey $AKProd -SecretKey $SKProd -Verbose}

$WebS3Objects = $x | ? {$_.LastModified -ge ([DateTime]::Today.AddDays(-1).AddHours(18))}
$WebS3Objects | % {Read-S3Object -BucketName $_.BucketName -Key $_.File -File .\Logs\$($_.File.Trim("/5e158dc2-adda-4dd0-820e-96609502593e").Replace("/","-")) -Region eu-west-1 -AccessKey $AKProd -SecretKey $SKProd -Verbose}

