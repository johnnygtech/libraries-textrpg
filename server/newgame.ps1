param(
    $userName,
    $password,
    $characterName
);

$gameRecord = @{
    "gameId"=$([guid]::NewGuid()).guid;
    "characterName"=$characterName;
    "HP"=100;
    "KP"=0;
    "Location"=0;
    "Gold"=25;
    "GameState"=0
}

if($username -eq "john" -and $password -eq "google")
{
    set-content -Path "$psScriptRoot/activeGames/$characterName" -Value $(ConvertTo-Json $gameRecord)
}
else 
{
    Write-host "bad password"
}