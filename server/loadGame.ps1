param(
    $userName,
    $password,
    $characterName
);

write-host "$psScriptRoot/activeGames/$characterName"
$gameload=ConvertFrom-Json $(GC -raw "$psScriptRoot/activeGames/$characterName")

$global:playerHP = $gameload.HP;
$global:playerKP = $gameload.KP;
$global:playerGold = $gameload.Gold;
$global:playerLocation = $gameload.Location;
$Global:GameState = $gameload.GameState;
$Global:characterName = $gameload.characterName;
$Global:GameGuid = $gameload.GameId;