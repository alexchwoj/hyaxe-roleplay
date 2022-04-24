#if defined _gangs_functions_
    #endinput
#endif
#define _gangs_functions_

Gangs_OpenPanel(playerid)
{
    if(Bit_Get(Player_Flags(playerid), PFLAG_GANG_PANEL_OPEN))
        return 0;

    Bit_Set(Player_Flags(playerid), PFLAG_GANG_PANEL_OPEN, true);
    g_rgiGangPanelPage{playerid} = 0;

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, 
        "SELECT `CURRENT_PLAYERID`, `NAME`, `GANG_RANK`, COUNT(*) OVER() AS `MEMBER_COUNT` \
            FROM `ACCOUNT` \
            WHERE \
                `ACCOUNT`.`GANG_ID` = %i \
            ORDER BY `GANG_RANK` DESC \
            LIMIT 7;",
        Gang_Data(Player_Gang(playerid))[e_iGangDbId]
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "GANGS_PanelDataFetched", "i", playerid);

    return 1;
}

Gangs_PanelForward(playerid)
{
    g_rgiGangPanelPage{playerid}++;
    if(!IsTextDrawVisibleForPlayer(playerid, g_tdGangs[7]))
    {
        TextDrawShowForPlayer(playerid, g_tdGangs[7]);
    }

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, 
        "SELECT `CURRENT_PLAYERID`, `NAME`, `GANG_RANK`, COUNT(*) OVER() AS `MEMBER_COUNT` \
            FROM `ACCOUNT` \
            WHERE \
                `ACCOUNT`.`GANG_ID` = %i \
            ORDER BY `GANG_RANK` DESC \
            LIMIT 7 OFFSET %i;",
        Gang_Data(Player_Gang(playerid))[e_iGangDbId],
        (7 * g_rgiGangPanelPage{playerid})
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "GANGS_PanelMembersFetched", "i", playerid);
}

Gangs_PanelBackwards(playerid)
{
    g_rgiGangPanelPage{playerid}--;
    if(g_rgiGangPanelPage{playerid} == 0)
    {
        TextDrawHideForPlayer(playerid, g_tdGangs[7]);
    }

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, 
        "SELECT `CURRENT_PLAYERID`, `NAME`, `GANG_RANK` \
            FROM `ACCOUNT` \
            WHERE \
                `ACCOUNT`.`GANG_ID` = %i \
            ORDER BY `GANG_RANK` DESC \
            LIMIT 7 OFFSET %i;",
        Gang_Data(Player_Gang(playerid))[e_iGangDbId],
        (7 * g_rgiGangPanelPage{playerid})
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "GANGS_PanelMembersFetched", "i", playerid);
}

Gangs_ClosePanel(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_GANG_PANEL_OPEN, false);
    for(new i = sizeof(g_tdGangs) - 3; i != -1; --i)
    {
        TextDrawHideForPlayer(playerid, g_tdGangs[i]);
    }

    for(new i = sizeof(g_tdGangMemberSlots) - 1; i != -1; --i)
    {
        TextDrawHideForPlayer(playerid, g_tdGangMemberSlots[i][0]);
        TextDrawHideForPlayer(playerid, g_tdGangMemberSlots[i][1]);
        TextDrawHideForPlayer(playerid, g_tdGangMemberSlots[i][2]);
        TextDrawHideForPlayer(playerid, g_tdGangMemberSlots[i][3]);
    }
}