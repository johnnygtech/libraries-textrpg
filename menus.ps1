$gameSelect = @{
    1="New Game";
    2="Continue";
    3="Exit";
}

$interface = {
Write-host @"
HP:[$([int]$global:playerHP)] KP:[$([int]$global:playerKP)] GOLD: [$([int]$global:playerGold)] LOCATION: [$($locations.$([int]$global:playerLocation).name)]
"@
}