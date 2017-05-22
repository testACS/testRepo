Get-Service a* | Convertto-Html | Out-File -Title "Services.html" -Head "<style> html{font-family: 'Segoe UI';} table{border: 1px solid grey;} th{border: 1px solid grey; color: ghostwhite; background-color: navy; padding: 5px;} td{border: 1px solid grey; padding: 5px;} </style>"

Get-EventLog -LogName System -Newest 5 | select -Property EventId, TimeWritten, Message | sort TimeWritten | Convertto-Html -Title "Events_$env:COMPUTERNAME" -Head "<style> html{font-family: 'Segoe UI';} table{border: 1px solid grey;} th{border: 1px solid grey; color: ghostwhite; background-color: navy; padding: 5px;} td{border: 1px solid grey; padding: 5px;} </style>" | Out-File Events-($env:COMPUTERNAME).html

[DateTime]::Today.AddDays(-10).AddHours(-18)

Get-S3Object -BucketName prod-cloudwatch-log-archive -Key prod-log-groups-prodRIWebsiteLogs-1QEXT9O7CJEO9 -Region eu-west-1 -AccessKey $AKProd -SecretKey $SKProd -Verbose `
| select @{n="File";e={($_.Key).Trim("prod-log-groups-prodRIWebsiteLogs-1QEXT9O7CJEO9")}}, LastModified, @{n="Size";e={[math]::Round(($_.Size / 1MB ), 2)}} `
| ?{$_.LastModified -ge '(([DateTime]::Today.AddDays(-10)).AddHours(-18))'} -OutVariable WebS3Objects

$WebS3Objects.LastModified.ToString("MM/dd/yyyy hh:mm:ss").ToDateTime
(([DateTime]::Today.AddDays(-10)).AddHours(-18))

$x = $WebS3Objects.LastModified.ToString("MM/dd/yyyy hh:mm:ss")
$x.DateTime
