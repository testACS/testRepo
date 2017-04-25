Param(
    [Parameter(Mandatory=$true)]
    [string]$DropboxAccessToken,
    [Parameter(Mandatory=$true)]
    [string]$SourceFilePath,
    [Parameter(Mandatory=$true)]
    [string]$TargetFilePath
)

$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + $DropboxAccessToken

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
 
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers

# curl -X POST https://api.dropboxapi.com/2/files/list_folder --header "Authorization: Bearer FUyJV5BwfjsAAAAAAAAF66OjvkozlfT_c3yNtvk3QI0i7weIX-cNp6uUkmJZ5Evt" --header "Content-Type: application/json" --data "{\"path\": \"/\",\"recursive\": false,\"include_media_info\": false,\"include_deleted\": false,\"include_has_explicit_shared_members\": false}"

# curl -X POST https://content.dropboxapi.com/2/files/upload --header "Authorization: Bearer FUyJV5BwfjsAAAAAAAAF66OjvkozlfT_c3yNtvk3QI0i7weIX-cNp6uUkmJZ5Evt" --header "Dropbox-API-Arg: {\"path\": \"/Misc/new.txt\",\"mode\": \"add\",\"autorename\": true,\"mute\": false}" --header "Content-Type: application/octet-stream" --data-binary "C:\Users\itgj.HQ\Desktop\new.txt"

