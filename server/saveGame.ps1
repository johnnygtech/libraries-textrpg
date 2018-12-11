$gameRecord = @{
    "gameId"=$global:GameId
    "characterName"=$Global:characterName;
    "HP"=$global:playerHP;
    "KP"=$global:playerKP;
    "Location"=$global:playerloation;
    "Gold"=$global:PlayerGold;
    "GameState"=$global:GameState;
}

Set-content -path "$psScriptRoot/activeGames/$($global:characterName)" -Value $(ConvertTo-Json $gamerecord) -Force
