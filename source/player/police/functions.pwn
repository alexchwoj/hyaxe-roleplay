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
    foreach(new i : Police)
    {
        if(Police_Rank(i) >= _:rank)
        {
            SendClientMessage(i, color, message);
        }
    }

    return 1;
}