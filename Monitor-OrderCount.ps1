

#Invoke-Sqlcmd -ServerInstance SQLAG1Listener.ri-prod.local -Query "SELECT replica_server_name, HAGS.primary_replica, endpoint_url, availability_mode_desc, failover_mode_desc FROM sys.availability_replicas AR INNER JOIN sys.dm_hadr_availability_group_states HAGS ON HAGS.group_id = AR.group_id;"
#Invoke-Sqlcmd -ServerInstance PPESQL1Listener.ri-test.local -Query "SELECT replica_server_name, HAGS.primary_replica, endpoint_url, availability_mode_desc, failover_mode_desc FROM sys.availability_replicas AR INNER JOIN sys.dm_hadr_availability_group_states HAGS ON HAGS.group_id = AR.group_id;"

#(Invoke-Sqlcmd -ServerInstance SQLAG1Listener.ri-prod.local -Database DCP_Transactions -Query "select * from dbo.purchaseorders where created > '$Start' and created < '$End' order by created Desc").Count
#(Invoke-Sqlcmd -ServerInstance PPESQL1Listener.ri-test.local -Database DCP_Transactions -Query "select * from dbo.purchaseorders where created > '$Start' and created < '$End' order by created Desc").Count


Import-Module SQLPS -DisableNameChecking

Start-Transcript -Path .\Monitor-OrderCount.log -Append

# Order Count
Write-Output "Setting start date."
$Start = (Get-Date).AddDays(0).AddHours(-1).AddMinutes(-5).ToString("yyyy-MM-dd HH:mm:ss")
Write-Output "Start time is $Start."
Write-Output "Setting end date."
$End = (Get-Date).AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss")
Write-Output "End time is $End."
Write-Output "Getting order count."
$OrderCount = (Invoke-Sqlcmd -ServerInstance SQLAG1Listener.ri-prod.local -Database DCP_Transactions -Query "select * from dbo.purchaseorders where created > '$Start' and created < '$End' order by created Desc").Count
Write-Output "$OrderCount orders have been processed in the last 5 minuntes."

If ($OrderCount -lt 5)
{
                Write-Output "Order count for last 5 minutes is less than 5, sending email notification."

                $From = "OrderCount@riuat.com"
                $To = "Gowtham.Jakka@river-island.com"
                $SMTPServer = "email-smtp.eu-west-1.amazonaws.com"
                $SMTPPort = "587"
                $Username = "AKIAIILLYIMWNRLJPIGA"
                $Password = "AmngfTmfRWL7ZiGLyO8WIONEM4iYDbbcXPYB3MJqR8mv"
                $subject = "Order count between $Start and $End is $OrderCount"
                $body = "Order count between $Start and $End is $OrderCount"

                $smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);

                $smtp.EnableSSL = $true
                $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
                $smtp.Send($From, $To, $subject, $body);
                Write-Output "INFO: Email sent for $OrderCount" -Verbose

}

Else 
{
                Write-Output "Nothing to report about Order Count."   
}

# Order Created / Modified

# Per Server
Invoke-Sqlcmd -ServerInstance SQLAG1Listener.ri-prod.local -Database DCP_Transactions -Query "select top 20 * from dbo.purchaseorders where ServerId like 'WebT%' order by Created desc"

# Per website

# Sent to ODBMS




Stop-Transcript -Verbose
