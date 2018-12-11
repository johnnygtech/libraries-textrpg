$gameStates = @{
    0= @{
        "dialogue" = {
            Write-host "Welcome to the game!"
            Write-Host "You are a librarian's assistant"
            Write-host "The librarians guild is attempting to compile all knowledge in the known world"
            write-host "They ask you to help with their quest!"
            Write-host -ForegroundColor Green "Will you take a quest? 1 for yes, 2 for no"
        };
        "validOptions" = @{
            1=
                {
                    Write-host -ForegroundColor Cyan "[Librarian]" -NoNewline 
                    Write-Host "Thank you, assistant!  Go down to the market and count how many apples are available for sale."
                    $global:gameState++;
                }
            2=
                {
                    Write-host -ForegroundColor Cyan "[Librarian]" -NoNewline 
                    Write-Host "Well, I suppose you should come back when your ready..."
                }
        };
    };

    1 = @{
        "validOptions" = @{
            1=
            {
                Write-Host "<you approach the Gaurd, he glares at you as you make eye contact>"
                Write-host -ForegroundColor Cyan "[Gaurd]" -NoNewline 
                Write-Host -ForegroundColor DarkRed "HALT!!!" -NoNewline
                Write-Host "Where are your credentials, foreigner?"
                Write-host -ForegroundColor Cyan "[You]" -NoNewline 
                write-host "Many Apologies, Sir; I am assisting the " -NoNewline
                Write-host -ForegroundColor Yellow "[Librarian]"
                Write-host "<the Gaurd eyes you, maliciously>"
                & { $gaurdDecision = read-host "You think to yourself;`r`n1: I should bribe him, quickly`r`n2: I should ask him my question" 
                    switch($gaurdDecision)
                    {
                        1 { 
                            Write-host -ForegroundColor Cyan "[You]" -NoNewline 
                            Write-host "I am trying to find the fruit vendor, would you take this <small pouch of gold> to direct me?"}
                        2 { 
                            Write-host -ForegroundColor Cyan "[You]" -NoNewline 
                            Write-Host "I am looking for the fruit vendor, can you point me in the right direction?" 
                        }
                        default {}
                    }
                    switch($gaurdDecision)
                    {
                        1 { 
                            Write-host -ForegroundColor Cyan "[Gaurd]" -NoNewline 
                            Write-host "You should be more careful, bribing gaurds is illegal.  But fortuitously for you, these are hard times... The fruit vendor is down the" -NoNewline
                            Write-host -ForegroundColor DarkBlue " <southern corridor>." 
                            
                            & {
                                Write-host "{'event':'deduct 5 Gold'}"
                                $global:playerGold = $global:playerGold - 5
                            }

                            & {
                                Write-Host "{'event':'move player to <souther corridor>}"
                                $global:playerLocation = 2;
                                $global:gameState++;
                            }
                        }
                        2 { 
                            Write-host -ForegroundColor Cyan "[Gaurd]" -NoNewline 
                            Write-host "Well, your in luck, my brother is one of the vendors... I'll let you go, if you promise to shop with him."
                            read-host
                            Write-host -ForegroundColor Cyan "[Gaurd]" -NoNewline 
                            Write-host "He sells baked goods and specializes in brea... I'll speak with him tonight so i'll know if you choose to avoid him and I won't be forgiving"
                            read-host
                            Write-host -ForegroundColor Cyan "[You]" -NoNewLine 
                            Write-host " Of course, I appreciate the consideration..."
                            & {
                                Write-Host "{'event':'player moves <southern corridor>}"
                                $global:playerLocation = 2;
                                $global:gameState++;
                            }
                        }
                        default {
                            Write-host -ForegroundColor Cyan "[Gaurd]" -NoNewline 
                            Write-host "Wrong Answer!"
                             & {
                                 Write-host "{'event':'[Gaurd] attacks [Player]'}"
                                 $npc = & "$psscriptRoot/assets/npcs/loadnpc.ps1" -npcType gaurd
                                 #Npc will do base damage to our hero
                                 write-host "{'event':'[Gaurd]s attack does $($npc.CP) damage}"
                                 $global:playerHP = $global:playerHP - $npc.CP
                             }
                        }
                    }
                }
            }
            
            2= {
                Write-host "You flag the barker down, just as he finishes his latest advertisment"
                Write-host -ForegroundColor Cyan "[Barker]" -NoNewline 
                Write-host "Oye, friend! 2 Gold peices for some of the latest gossip, the crooked habidasher, the visiting royal family..."
                Read-Host
                Write-host -ForegroundColor Cyan "[You]" -NoNewline 
                Write-host "No thank you, would you kindly point me toward the apple vendor?"
                Read-host
                Write-host "<the [Barker] glares at you>"
                Write-host -ForegroundColor Cyan "[Barker]" -NoNewline
                Write-host "I am NOT a road sign.  Information ain't cheap y'know..."
                 & {
                     $barkerDecision = read-host "1. Offer barker 2 Gold for gossip about the habidasher`r`n2. Offer the barker 2 Gold for gossip about the Royal family`r`n3. Offer the barker 2 Gold to tell you where the apple vendor is"
                 
                    switch($barkerDecision)
                    {
                        1 {
                            Write-host -ForegroundColor Cyan "[You]" -NoNewline
                            Write-host "Well, why don't you tell me about the habidasher?"
                            & {
                                Write-host "{'event':'deduct 2 Gold'}"
                                $Global:playerGold = $global:playerGold - 2
                            }
                            Write-host -ForegroundColor Cyan "[Barker]" -NoNewline
                            Write-host "The habidasher, is rumored to be runnin a bit of a side business; I have it on good authority that he's smuggling beagles out of his shop..."
                            Read-Host
                            Write-host -ForegroundColor Cyan "[Barker]" -NoNewline
                            Write-Host "Actually come to think of it, the apple vendor's cart is right outside the habidashery..."
                        }
                        2 {
                            Write-host -ForegroundColor Cyan "[You]" -NoNewline
                            Write-host "Why is the royal family here?"
                            & {
                                Write-host "{'event':'deduct 2 Gold'}"
                                $Global:playerGold = $global:playerGold - 2
                            }
                            Write-host -ForegroundColor Cyan "[Barker]" -NoNewline
                            Write-host "There is going to be a wedding.  You might actually catch a glimpse of them if you hurry; head towards towards the " -NoNewline                        
                            Write-host -ForegroundColor DarkBlue "< Market >"
                            Write-host -ForegroundColor Cyan "[Barker]" -NoNewline
                            Write-host "Your apple cart is there too... Come back any time you want an apple, <ha ha ha ha>"
                        }
                        3 {
                            Write-host -ForegroundColor Cyan "[You]" -NoNewline 
                            Write-host "well, I don't care about your gossip, but heres 2 Gold for troubling you for the location of the vendor I asked for."
                            & {
                                Write-host "{'event':'deduct 2 Gold'}"
                                $Global:playerGold = $global:playerGold - 2
                            }
                            Write-host -ForegroundColor Cyan "[Barker]" -NoNewline
                            Write-host "HA, excellent!  You'll need to be looking in the " -NoNewline
                            Write-host -ForegroundColor DarkBlue "< Market >"
                            Write-host "He's near the road, a small cart..."
                        }
                        default {}
                    }
                }
                 & {
                     $Global:playerLocation=4
                     $global:gameState++;
                 }
            }
        };

        "dialogue" = {
            write-host "You are in the [$($locations.$([int]$global:playerLocation).name)], you see vendors for all types of goods"
            read-host
            Write-host "There is a" -NoNewline
            Write-Host -ForegroundColor Yellow " <city gaurd>" -NoNewline
            Write-host " near you, and on the other side of the road is a" -NoNewline
            Write-Host -ForegroundColor Yellow " <news barker>" -NoNewline
            Write-host " shouting something about a 'tournament'."
            Write-host -ForegroundColor Green "You approach the? 1 for gaurd, 2 for barker"
        };
    };

    2 = @{
        "validOptions" = @{

        };

        "dialogue" = {
            Write-Host "You have made it to the [$($locations.$([int]$global:playerLocation).name)], you see loads of fresh produce and start looking for the apple vendor."
            Write-host "You a group of grungy looking ruffians"
        }
    }
};