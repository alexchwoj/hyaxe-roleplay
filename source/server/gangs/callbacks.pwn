#if defined _gangs_callbacks_
    #endinput
#endif
#define _gangs_callbacks_

public OnGameModeInit()
{
    Iter_Init(GangMember);
    g_mapGangIds = map_new();

    new Cache:gangs_cache = mysql_query(g_hDatabase, "SELECT * FROM `GANGS`;", .use_cache = true);
    #pragma nodestruct gangs_cache // We take care of this manually so there's no need to call the destructor

    new rowc;
    cache_get_row_count(rowc);
    
    for(new i; i < rowc; ++i)
    {
        cache_get_value_name_int(i, "GANG_ID", g_rgeGangs[i][e_iGangDbId]);
        cache_get_value_name(i, "GANG_NAME", g_rgeGangs[i][e_szGangName]);
        cache_get_value_name_int(i, "GANG_COLOR", g_rgeGangs[i][e_iGangColor]);
        cache_get_value_name_int(i, "GANG_ICON", g_rgeGangs[i][e_iGangIcon]);
        map_add(g_mapGangIds, g_rgeGangs[i][e_iGangDbId], i);
        g_rglGangRanks[i] = list_new();

        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "SELECT `RANK_ID`, `RANK_NAME`, `RANK_HIERARCHY`, `RANK_PERMISSIONS` FROM `GANG_RANKS` WHERE `GANG_ID` = %i;", g_rgeGangs[i][e_iGangDbId]);
        new Cache:rank_cache = mysql_query(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, .use_cache = true);
        #pragma nodestruct rank_cache
        cache_set_active(rank_cache);

        new ranks;
        cache_get_row_count(ranks);
        for(new j; j < ranks; ++j)
        {
            new rank[eGangRankData];
            cache_get_value_name_int(j, "RANK_ID", rank[e_iRankId]);
            cache_get_value_name(j, "RANK_NAME", rank[e_szRankName]);
            cache_get_value_name_int(j, "RANK_HIERARCHY", rank[e_iRankHierarchy]);
            cache_get_value_name_int(j, "RANK_PERMISSIONS", rank[e_iRankPermisionFlags]);

            list_add_arr(g_rglGangRanks[i], rank);
        }

        cache_delete(rank_cache);
        cache_set_active(gangs_cache);

        list_sort(g_rglGangRanks[i], e_iRankHierarchy);
    }

    cache_delete(gangs_cache);

    printf("[gang] Loaded %i gangs.", rowc);
    
    #if defined GANGS_OnGameModeInit
        return GANGS_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit GANGS_OnGameModeInit
#if defined GANGS_OnGameModeInit
    forward GANGS_OnGameModeInit();
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    log_function();

    if(((newkeys & (KEY_SPRINT | KEY_YES)) == KEY_SPRINT | KEY_YES) && !IsPlayerInAnyVehicle(playerid))
    {
        printf("gang = %i", Player_Gang(playerid));

        if(Player_Gang(playerid) != -1)
        {
            Gangs_OpenPanel(playerid);
            return 1;
        }
    }

    #if defined GANGS_OnPlayerKeyStateChange
        return GANGS_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange GANGS_OnPlayerKeyStateChange
#if defined GANGS_OnPlayerKeyStateChange
    forward GANGS_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public GANGS_PanelDataFetched(playerid)
{
    new member_count;
    cache_get_value_name_int(0, "MEMBER_COUNT", member_count);

    for(new i = sizeof(g_tdGangs) - 3; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdGangs[i]);
    }

    if(member_count > 7)
        TextDrawShowForPlayer(playerid, g_tdGangs[8]);

    SelectTextDraw(playerid, 0xCB3126FF);

    TextDrawSetStringForPlayer(g_tdGangs[2], playerid, Gang_Data(Player_Gang(playerid))[e_szGangName]);
    TextDrawSetStringForPlayer(g_tdGangs[3], playerid, "Miembros: %i", member_count);
    TextDrawSetStringForPlayer(g_tdGangs[4], playerid, "%s", g_rgszGangIcons[Gang_Data(Player_Gang(playerid))[e_iGangIcon]][1]);

    new rowc;
    cache_get_row_count(rowc);

    for(new i; i < rowc; ++i)
    {
        new current_playerid, name[25], rank;
        cache_get_value_name_int(i, "CURRENT_PLAYERID", current_playerid);
        cache_get_value_name(i, "NAME", name);
        cache_get_value_name_int(i, "GANG_RANK", rank);

        TextDrawShowForPlayer(playerid, g_tdGangMemberSlots[i][0]);
        TextDrawShowForPlayer(playerid, g_tdGangMemberSlots[i][1]);
        TextDrawShowForPlayer(playerid, g_tdGangMemberSlots[i][2]);
        TextDrawShowForPlayer(playerid, g_tdGangMemberSlots[i][3]);

        TextDrawSetStringForPlayer(g_tdGangMemberSlots[i][1], playerid, (current_playerid == -1 ? "~r~." : "~g~."));
        TextDrawSetStringForPlayer(g_tdGangMemberSlots[i][2], playerid, name);

        new rank_data[eGangRankData];
        list_get_arr(g_rglGangRanks[Player_Gang(playerid)], Player_GangRank(playerid), rank_data);
        TextDrawSetStringForPlayer(g_tdGangMemberSlots[i][3], playerid, rank_data[e_szRankName]);
    }

    return 1;
}

public GANGS_PanelMembersFetched(playerid)
{
    new rowc, member_count;
    cache_get_row_count(rowc);
    cache_get_value_name_int(0, "MEMBER_COUNT", member_count);

    if(member_count < (g_rgiGangPanelPage{playerid} * 7))
    {
        TextDrawHideForPlayer(playerid, g_tdGangs[8]);
    }
    
    for(new i; i < rowc; ++i)
    {
        new current_playerid, name[25], rank;
        cache_get_value_name_int(i, "CURRENT_PLAYERID", current_playerid);
        cache_get_value_name(i, "NAME", name);
        cache_get_value_name_int(i, "GANG_RANK", rank);

        TextDrawShowForPlayer(playerid, g_tdGangMemberSlots[i][0]);
        TextDrawShowForPlayer(playerid, g_tdGangMemberSlots[i][1]);
        TextDrawShowForPlayer(playerid, g_tdGangMemberSlots[i][2]);
        TextDrawShowForPlayer(playerid, g_tdGangMemberSlots[i][3]);

        TextDrawSetStringForPlayer(g_tdGangMemberSlots[i][1], playerid, (current_playerid == -1 ? "~r~." : "~g~."));
        TextDrawSetStringForPlayer(g_tdGangMemberSlots[i][2], playerid, name);

        new rank_data[eGangRankData];
        list_get_arr(g_rglGangRanks[Player_Gang(playerid)], Player_GangRank(playerid), rank_data);
        TextDrawSetStringForPlayer(g_tdGangMemberSlots[i][3], playerid, rank_data[e_szRankName]);
    }

    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == g_tdGangs[7])
    {
        if(g_rgiGangPanelPage{playerid} != 0)
            Gangs_PanelBackwards(playerid);

        return 1;
    }
    else if(clickedid == g_tdGangs[8])
    {
        Gangs_PanelForward(playerid);
        return 1;
    }
    else if(clickedid == g_tdGangs[6])
    {
        Gangs_ClosePanel(playerid);

        new rank_data[eGangRankData];
        list_get_arr(g_rglGangRanks[Player_Gang(playerid)], Player_GangRank(playerid), rank_data);

        new caption[128];
        format(caption, sizeof(caption), "{CB3126}>>{DADADA} Banda: {%0.6x}%s", Gang_Data(Player_Gang(playerid))[e_iGangColor] >>> 8, Gang_Data(Player_Gang(playerid))[e_szGangName]);
        
        printf("gang perms: %b", rank_data[e_iRankPermisionFlags]);

        if(!(rank_data[e_iRankPermisionFlags] & _:(GANG_PERM_KICK_MEMBERS | GANG_PERM_EDIT_MEMBERS)))
        {
            Dialog_Show(playerid, "null", DIALOG_STYLE_MSGBOX, caption, "{DADADA}No tienes permisos para modificar esta banda.", "Entendido");
            return 1;
        }

        HYAXE_UNSAFE_HUGE_STRING[0] = '\0';

        new temp[40];
        for(new i = 1; i < _:GANG_PERM_LAST; i <<= 1)
        {
            new normal_idx = Cell_GetLowestBit(i);
            format(temp, sizeof(temp), "{CB3126}>{DADADA} %s\n", g_rgszGangPermNames[normal_idx]);
            strcat(HYAXE_UNSAFE_HUGE_STRING, temp);
        }

        Dialog_Show(playerid, "modify_gang", DIALOG_STYLE_LIST, caption, HYAXE_UNSAFE_HUGE_STRING, "Siguiente", "Cancelar");
        return 1;
    }

    #if defined GANGS_OnPlayerClickTextDraw
        return GANGS_OnPlayerClickTextDraw(playerid, clickedid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw GANGS_OnPlayerClickTextDraw
#if defined GANGS_OnPlayerClickTextDraw
    forward GANGS_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

dialog modify_gang(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        Gangs_OpenPanel(playerid);
        return 1;
    }

    new perm = 1 << listitem;
    new rank_data[eGangRankData];
    list_get_arr(g_rglGangRanks[Player_Gang(playerid)], Player_GangRank(playerid), rank_data);

    new caption[40];
    format(caption, sizeof(caption), "{CB3126}>>{DADADA} %s", g_rgszGangPermNames[listitem]);

    if(!(rank_data[e_iRankPermisionFlags] & perm))
    {
        Dialog_Show(playerid, "null", DIALOG_STYLE_MSGBOX, caption, "{DADADA}No tienes permisos para usar esta opción.", "Entendido");
        return 1;
    }

    switch(perm)
    {
        case GANG_PERM_CHANGE_COLOR:
        {
            Dialog_Show(playerid, "gang_change_color", DIALOG_STYLE_INPUT, caption, "{DADADA}Introduce el nuevo color de la banda en el formato #{FF0000}RR{00FF00}GG{0000FF}BB{DADADA}. Cada color debe ser un número hexadecimal válido.", "Cambiar", "Cancelar");
        }
        case GANG_PERM_CHANGE_NAME:
        {
            Dialog_Show(playerid, "gang_change_name", DIALOG_STYLE_INPUT, caption, "{DADADA}Introduce el nuevo nombre de la banda. Debe tener una longitud entre {CB3126}1{DADADA} y {CB3126}64{DADADA} caracteres.", "Cambiar", "Cancelar");
        }
        case GANG_PERM_CHANGE_ICON:
        {
            HYAXE_UNSAFE_HUGE_STRING[0] = '\0';

            for(new i = 0; i < sizeof(g_rgszGangIcons); ++i)
            {
                strcat(HYAXE_UNSAFE_HUGE_STRING, g_rgszGangIcons[i][0]);
                strcat(HYAXE_UNSAFE_HUGE_STRING, "\n");
            }

            Dialog_Show(playerid, "gang_change_icon", DIALOG_STYLE_LIST, caption, HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Cancelar");
        }
        case GANG_PERM_KICK_MEMBERS, GANG_PERM_EDIT_MEMBERS:
        {
            Dialog_Show(playerid, "null", DIALOG_STYLE_MSGBOX, caption, "{DADADA}Para editar o expulsar a algun miembro de la banda, presiona su nombre en el panel de banda.", "Entendido");
        }
    }

    return 1;
}

dialog gang_change_color(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        Gangs_OpenPanel(playerid);
        return 1;
    }

    new new_color;
    if(sscanf(inputtext, "?<SSCANF_COLOUR_FORMS=2>m", new_color))
    {
        Dialog_Show(playerid, "gang_change_color", DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Cambiar color", "{DADADA}Introduce el nuevo color de la banda en el formato #{FF0000}RR{00FF00}GG{0000FF}BB{DADADA}. Cada color debe ser un número hexadecimal válido.", "Cambiar", "Cancelar");
        return 1;
    }

    printf("new_color = %i (%x)", new_color, new_color);

    Gang_Data(Player_Gang(playerid))[e_iGangColor] = new_color;
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        UPDATE `GANGS` SET `GANG_COLOR` = %i WHERE `GANG_ID` = %i;\
    ", new_color, Gang_Data(Player_Gang(playerid))[e_iGangDbId]);
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "[BANDA] {DADADA}%s cambió el color de la {%06x}banda{DADADA}.", Player_RPName(playerid), new_color >>> 8);
    Gang_SendMessage(Player_Gang(playerid), HYAXE_UNSAFE_HUGE_STRING);

    Gangs_OpenPanel(playerid);
    return 1;
}

dialog gang_change_name(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        Gangs_OpenPanel(playerid);
        return 1;
    }

    new new_name[64];
    if(sscanf(inputtext, "s[64]", new_name))
    {
        Dialog_Show(playerid, "gang_change_name", DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Cambiar nombre", "{DADADA}Introduce el nuevo nombre de la banda. Debe tener una longitud entre {CB3126}1{DADADA} y {CB3126}64{DADADA} caracteres.", "Cambiar", "Cancelar");
        return 1;
    }

    strcpy(Gang_Data(Player_Gang(playerid))[e_szGangName], new_name);

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "[BANDA] {DADADA}%s cambió el nombre de la banda a %s.", Player_RPName(playerid), new_name);
    Gang_SendMessage(Player_Gang(playerid), HYAXE_UNSAFE_HUGE_STRING);

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        UPDATE `GANGS` SET `GANG_NAME` = '%e' WHERE `GANG_ID` = %i;\
    ", new_name, Gang_Data(Player_Gang(playerid))[e_iGangDbId]);
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    
    Gangs_OpenPanel(playerid);
    return 1;
}

dialog gang_change_icon(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        Gangs_OpenPanel(playerid);
        return 1;
    }

    Gang_Data(Player_Gang(playerid))[e_iGangIcon] = listitem;
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        UPDATE `GANGS` SET `GANG_ICON` = %i WHERE `GANG_ID` = %i;\
    ", listitem, Gang_Data(Player_Gang(playerid))[e_iGangDbId]);
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "[BANDA] {DADADA}%s cambió el ícono de la banda.", Player_RPName(playerid));
    Gang_SendMessage(Player_Gang(playerid), HYAXE_UNSAFE_HUGE_STRING);

    return 1;
}

public OnPlayerCancelTDSelection(playerid)
{
    if(Bit_Get(Player_Flags(playerid), PFLAG_GANG_PANEL_OPEN))
    {
        Gangs_ClosePanel(playerid);
        return 1;
    }

    #if defined GANGS_OnPlayerCancelTDSelection
        return GANGS_OnPlayerCancelTDSelection(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerCancelTDSelection
    #undef OnPlayerCancelTDSelection
#else
    #define _ALS_OnPlayerCancelTDSelection
#endif
#define OnPlayerCancelTDSelection GANGS_OnPlayerCancelTDSelection
#if defined GANGS_OnPlayerCancelTDSelection
    forward GANGS_OnPlayerCancelTDSelection(playerid);
#endif
