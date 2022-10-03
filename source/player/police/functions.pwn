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

Police_SendMessage(ePoliceRanks:rank, color, const message[])
{
    new messages[2][145];
    new count = SplitChatMessageInLines(message, messages);

    foreach(new i : Police)
    {
        if(Police_OnDuty(i) && Police_Rank(i) >= _:rank)
        {
            for(new j; j < count; ++j)
                SendClientMessage(i, color, messages[i]);
        }
    }

    return 1;
}