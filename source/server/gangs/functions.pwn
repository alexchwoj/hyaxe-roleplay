#if defined _gangs_functions_
    #endinput
#endif
#define _gangs_functions_

Gangs_FindFreeIndex()
{
    for(new i; i < HYAXE_MAX_GANGS; ++i)
    {
        if(!g_rgeGangs[i][e_iGangDbId])
            return i;
    }

    return -1;
}

Gangs_OpenPanel(playerid)
{
    if(Bit_Get(Player_Flags(playerid), PFLAG_GANG_PANEL_OPEN))
        return 0;

    Bit_Set(Player_Flags(playerid), PFLAG_GANG_PANEL_OPEN, true);
    g_rgiGangPanelPage{playerid} = 1;

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

Gangs_UpdatePanel(playerid)
{
    if(!Bit_Get(Player_Flags(playerid), PFLAG_GANG_PANEL_OPEN))
        return 0;

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, 
        "SELECT `CURRENT_PLAYERID`, `NAME`, `GANG_RANK`, COUNT(*) OVER() AS `MEMBER_COUNT` \
            FROM `ACCOUNT` \
            WHERE \
                `ACCOUNT`.`GANG_ID` = %i \
            ORDER BY `GANG_RANK` DESC \
            LIMIT 7 OFFSET %i;",
        Gang_Data(Player_Gang(playerid))[e_iGangDbId],
        (7 * (g_rgiGangPanelPage{playerid} - 1))
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "GANGS_PanelMembersFetched", "i", playerid);

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
        (7 * (g_rgiGangPanelPage{playerid} - 1))
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "GANGS_PanelMembersFetched", "i", playerid);
}

Gangs_PanelBackwards(playerid)
{
    g_rgiGangPanelPage{playerid}--;
    if(g_rgiGangPanelPage{playerid} == 1)
    {
        TextDrawHideForPlayer(playerid, g_tdGangs[7]);
    }

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, 
        "SELECT `CURRENT_PLAYERID`, `NAME`, `GANG_RANK`, COUNT(*) OVER() AS `MEMBER_COUNT` \
            FROM `ACCOUNT` \
            WHERE \
                `ACCOUNT`.`GANG_ID` = %i \
            ORDER BY `GANG_RANK` DESC \
            LIMIT 7 OFFSET %i;",
        Gang_Data(Player_Gang(playerid))[e_iGangDbId],
        (7 * (g_rgiGangPanelPage{playerid} - 1))
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "GANGS_PanelMembersFetched", "i", playerid);
}

Gangs_ClosePanel(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_GANG_PANEL_OPEN, false);
    for(new i = sizeof(g_tdGangs) - 1; i != -1; --i)
    {
        TextDrawHideForPlayer(playerid, g_tdGangs[i]);
    }

    for(new i = sizeof(p_tdGangMemberSlots[]) - 1; i != -1; --i)
    {
        PlayerTextDrawHide(playerid, p_tdGangMemberSlots[playerid][i]{0});
        PlayerTextDrawHide(playerid, p_tdGangMemberSlots[playerid][i]{1});
        PlayerTextDrawHide(playerid, p_tdGangMemberSlots[playerid][i]{2});
        TextDrawHideForPlayer(playerid, g_tdGangMemberSlotBg[i]);
    }

    CancelSelectTextDraw(playerid);
}

Gang_SendMessage(gangid, const message[])
{
    foreach(new i : GangMember[gangid])
    {
        SendClientMessage(i, g_rgeGangs[gangid][e_iGangColor], message);
    }

    return 1;
}

Gang_SendMessage_s(gangid, ConstString:message)
{
    new ConstAmxString:msg_address = str_addr_const(message);
    
    foreach(new i : GangMember[gangid])
    {
        SendClientMessage_s(i, g_rgeGangs[gangid][e_iGangColor], msg_address);
    }

    return 1;
}

GangPanel_OpenRoles(playerid)
{
    strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Los roles están ordenados por su importancia jerárquica\t \n");

    new line[90];
    for(new i = sizeof(g_rgeGangRanks[]) - 1; i != -1; --i)
    {
        if(g_rgeGangRanks[Player_Gang(playerid)][i][e_iRankId])
        {
            format(line, sizeof(line), "{DADADA}%2i {CB3126}>{DADADA} %s\t \n", i + 1, g_rgeGangRanks[Player_Gang(playerid)][i][e_szRankName]);
        }
        else
        {
            format(line, sizeof(line), "{DADADA}%2i {CB3126}>{969696} Vacío\t \n", i + 1);
        }

        strcat(HYAXE_UNSAFE_HUGE_STRING, line);
    }

    Dialog_Show(playerid, "gang_change_role", DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}>>{DADADA} Cambiar roles", HYAXE_UNSAFE_HUGE_STRING, "Seleccionar", "Cancelar");
    return 1;
}

GangPanel_OpenRoleOptions(playerid)
{
    new caption[64];
    format(caption, sizeof(caption), "{CB3126}>>{DADADA} Modificando rol {CB3126}%s", g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_szRankName]);
    Dialog_Show(playerid, "gang_role_modify_option", DIALOG_STYLE_LIST, caption, "\
        {CB3126}>{DADADA} Cambiar nombre\n\
        {CB3126}>{DADADA} Modificar permisos\n\
        {CB3126}>{DADADA} Cambiar de posición\n\
    ", "Seleccionar", "Atrás");
    return 1;
}

GangPanel_OpenRolePermissions(playerid)
{
    strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Permiso\t{DADADA}Estado\n");

    new line[92];
    for(new i; i < sizeof(g_rgszGangPermNames); ++i)
    {
        format(line, sizeof(line), "{DADADA}%s\t%s\n", g_rgszGangPermNames[i], ((g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankPermisionFlags] & (1 << i)) != 0 ? "{64A752}+" : "{A83225}-"));
        strcat(HYAXE_UNSAFE_HUGE_STRING, line);
    }

    Dialog_Show(playerid, "gang_role_change_perms", DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}>>{DADADA} Permisos", HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Atrás");
    return 1;
}

GangPanel_OpenRoleSwap(playerid)
{
    strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Selecciona el rango para intercambiar sus posiciones\t \n");

    new line[90];
    for(new i = sizeof(g_rgeGangRanks[]) - 1; i != -1; --i)
    {
        if(g_rgeGangRanks[Player_Gang(playerid)][i][e_iRankId])
        {
            format(line, sizeof(line), "{DADADA}%2i {CB3126}>{%06x} %s\t \n", i + 1, (g_rgiPanelSelectedRole{playerid} == i ? 0xCB3126 : (Player_GangRank(playerid) > i || Player_IsGangOwner(playerid) ? 0xDADADA : 0x969696)), g_rgeGangRanks[Player_Gang(playerid)][i][e_szRankName]);
        }
        else
        {
            format(line, sizeof(line), "{DADADA}%2i {CB3126}>{%06x} Vacío\t \n", i + 1, (Player_GangRank(playerid) > i || Player_IsGangOwner(playerid) ? 0xBFBDBD : 0x969696));
        }

        strcat(HYAXE_UNSAFE_HUGE_STRING, line);
    }

    Dialog_Show(playerid, "gang_exchange_slot", DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}>>{DADADA} Intercambiar posiciones", HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Atrás");
    return 1;
}

Gang_GetLowestRank(gangid)
{
    for(new i; i < sizeof(g_rgeGangRanks[]); ++i)
    {
        if(g_rgeGangRanks[gangid][i][e_iRankId])
            return i;
    }
    return -1;
}