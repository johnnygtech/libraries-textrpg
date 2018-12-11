$debug=$true
$gameDir = $PSScriptRoot
. ./menus.ps1
. ./gameStates.ps1
. ./gameStateFunctions.ps1
. ./assets/locations.ps1
$exit=$false
$printGameState=$true
Clear-Host
Write-Output "Connecting to game...."
$continue=$false;
do
{
    $gameSelect = Read-Host "1: New Game`r`n2: Continue; 3: Exit"
    switch($gameselect)
    {
        1 {
            Write-host "New Game - Create Character"
            $name=Read-host "Character Name:"
            ./server/newgame.ps1 -userName "john" -password "google" -characterName $name
            ./server/loadGame.ps1 -userName "john" -password "google" -characterName $name
            $continue=$true;
        }
        2 {
            Write-host "Loading Game"
            $name = Read-host "Character Name:"
            ./server/loadGame.ps1 -userName "john" -password "google" -characterName $name
            $continue=$true;
        }
        3 {
            $exit=$true;
            $continue=$true;
        }
        default {}
    }
}
until($continue);

do
{
    ##Print Game state
    if($printGameState)
    {
        & $gamestates.$([int]$global:gamestate).dialogue;
    }
    else 
    {
        $printGameState = $true
    }
    ##Get User Action
    $userInput = read-host "What action do you choose?";
    if($userInput){clear-host}
    & $interface
    switch($userInput)
    {
        "help" {}
        "stats" {}
        "inventory" {}
        "exit" {$exit=$true}
        "" { $printGameState = $false }
        default {
            ##update gamestate$
            try
            {
                & $gamestates.$([int]$global:gamestate).validOptions.$([int]$userInput);
            }catch
            {
                Write-Host -ForegroundColor red "{'error':'invalid option'}"
                #$printGameState=$false
            }
            ./server/saveGame.ps1
        }
    }
}
until($exit)
Write-Output "Goodbye..."