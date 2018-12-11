param(
    $npctype
);

return ConvertFrom-Json $(GC -raw "$psScriptRoot/$npctype")
