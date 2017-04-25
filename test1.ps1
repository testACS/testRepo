

Get-S3Object -BucketName prod-cloudwatch-log-archive -Key prod-log-groups-prodRIWebsiteLogs-1QEXT9O7CJEO9 -Region eu-west-1 -AccessKey $AKProd -SecretKey $SKProd -Verbose | `
select BucketName, @{n="File";e={($_.Key)}}, LastModified, @{n="Size";e={[math]::Round(($_.Size / 1MB ), 2)}} | `
? {$_.LastModified -ge ([DateTime]::Today.AddDays(-2).AddHours(18)) -and ($_.File -ne '/aws-logs-w')} | sort LastModified
