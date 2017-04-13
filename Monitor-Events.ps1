Get-Service a* | Convertto-Html | Out-File -Title "Services.html" -Head "<style> html{font-family: 'Segoe UI';} table{border: 1px solid grey;} th{border: 1px solid grey; color: ghostwhite; background-color: navy; padding: 5px;} td{border: 1px solid grey; padding: 5px;} </style>"

Get-EventLog -LogName System -Newest 5 | select -Property EventId, TimeWritten, Message | sort TimeWritten | Convertto-Html -Title "Events_$env:COMPUTERNAME" -Head "<style> html{font-family: 'Segoe UI';} table{border: 1px solid grey;} th{border: 1px solid grey; color: ghostwhite; background-color: navy; padding: 5px;} td{border: 1px solid grey; padding: 5px;} </style>" | Out-File Events-($env:COMPUTERNAME).html

