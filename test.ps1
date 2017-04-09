param(
[Parameter(Mandatory=$true)]
[string]$UrlCsv,
[string]$UrlList
)

$ErrorActionPreference = 'Stop'

Start-Transcript -Path 'C:\Projects\Scripts\TestScript\TestScript.log' -Verbose

$Urls = (Import-Csv -Path $UrlCsv).UrlList
$StatusCode = = $null
$UrlIterationValue = (Import-Csv -Path $UrlCsv).UrlIterationValue

Write-Output "INFO: Getting list of urls." -Verbose
$Urls = gc $UrlList

foreach ($Url in $Urls)
{
    Write-Output "INFO: Getting website status: $Url" -Verbose
    iwr $Url -UseBasicParsing | select -exp StatusCode -OutVariable StatusCode

        If ($StatusCode -eq '200')
            {
                write-Output "Website $Url is OK!" -Verbose
                
            }

        Else
            {
                Write-Output "INFO: Website $Url is down!" -Verbose
                Write-Output "INFO: Sending email for $Url" -Verbose
                $From = "alert@riuat.com"
                $To = "gowtham.jakka@river-island.com"
                $SMTPServer = "email-smtp.eu-west-1.amazonaws.com"
                $SMTPPort = "587"
                $Username = "AKIAIILLYIMWNRLJPIGA"
                $Password = "AmngfTmfRWL7ZiGLyO8WIONEM4iYDbbcXPYB3MJqR8mv"
                $subject = "Site not responding - $Url"
                $body = "Site is down $Url"

                $smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);

                $smtp.EnableSSL = $true
                $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
                $smtp.Send($From, $To, $subject, $body);
                Write-Output "INFO: Email sent for $Url" -Verbose
            }
}

Write-Output "INFO: Script processing completed. Exiting." -Verbose

Stop-Transcript -Verbose
