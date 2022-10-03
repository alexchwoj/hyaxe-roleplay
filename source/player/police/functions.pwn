#if defined _police_functions_
    #endinput
#endif
#define _police_functions_

Police_SetRank(playerid, ePoliceRanks:new_rank)
{
    if(Police_Rank(playerid) == new_rank)
        return 0;

    Police_Rank(playerid) = new_rank;
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `POLICE_OFFICERS` SET `RANK` = %i WHERE `ACCOUNT_ID` = %i;", _:new_rank, Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    return 1;
}

Police_SendMessage(ePoliceRanks:rank, color, const message[], soundid = 0, suspect = INVALID_PLAYER_ID)
{
    new messages[2][145];
    new count = SplitChatMessageInLines(message, messages);

    foreach(new i : Police)
    {
        if(Police_OnDuty(i) && Police_Rank(i) >= _:rank)
        {
            for(new j; j < count; ++j)
                SendClientMessage(i, color, messages[j]);

            if(soundid && suspect != INVALID_PLAYER_ID)
                PlayCrimeReportForPlayer(i, suspect, soundid);
        }
    }

    return 1;
}

Player_SpawnInPrison(playerid)
{
    new pos = random(sizeof(g_rgfJailPositions));
    g_rgePlayerData[playerid][e_fPosX] = g_rgfJailPositions[pos][0];
    g_rgePlayerData[playerid][e_fPosY] = g_rgfJailPositions[pos][1];
    g_rgePlayerData[playerid][e_fPosZ] = g_rgfJailPositions[pos][2];
    Player_VirtualWorld(playerid) = 0;
    Player_Interior(playerid) = 0;

    return 1;
}

Police_SetMarkers(playerid)
{
    foreach(new i : Player)
    {
        if(Player_WantedLevel(i))
        {
            SetPlayerMarkerForPlayer(playerid, i, 0xCB3126FF);
        }
    }
}

Police_ClearMarkers(playerid)
{
    foreach(new i : Player)
    {
        if(Player_WantedLevel(i))
        {
            SetPlayerMarkerForPlayer(playerid, i, 0xF7F7F700);
        }
    }
}