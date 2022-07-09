#if defined _gangs_callbacks_
    #endinput
#endif
#define _gangs_callbacks_

static 
    s_rgbSelectingNewOwner[MAX_PLAYERS char];

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
        cache_get_value_name_int(i, "CREATOR_ID", g_rgeGangs[i][e_iGangOwnerId]);
        map_add(g_mapGangIds, g_rgeGangs[i][e_iGangDbId], i);

        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "SELECT `RANK_ID`, `RANK_NAME`, `RANK_HIERARCHY`, `RANK_PERMISSIONS` FROM `GANG_RANKS` WHERE `GANG_ID` = %i ORDER BY `RANK_HIERARCHY` DESC;", g_rgeGangs[i][e_iGangDbId]);
        new Cache:rank_cache = mysql_query(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, .use_cache = true);
        #pragma nodestruct rank_cache
        cache_set_active(rank_cache);

        new ranks;
        cache_get_row_count(ranks);
        for(new j; j < ranks && j < sizeof(g_rgeGangRanks[]); ++j)
        {
            new slot;
            cache_get_value_name_int(j, "RANK_HIERARCHY", slot);
            if(!(1 <= slot <= 10))
            {
                printf("[gangs!] Invalid rank slot caught in gang ID %i (expected number between 1 and 10, got %i)", g_rgeGangs[i][e_iGangDbId], slot);
                continue;
            }
            
            slot--;

            if(g_rgeGangRanks[i][slot][e_iRankId] != 0)
            {
                printf("[gangs!] Duplicate rank slot caught in gang ID %i (gang slot %i is already occupied by rank '%s')", g_rgeGangs[i][e_iGangDbId], slot, g_rgeGangRanks[i][slot][e_szRankName]);
                continue;
            }
            
            cache_get_value_name_int(j, "RANK_ID", g_rgeGangRanks[i][slot][e_iRankId]);
            cache_get_value_name(j, "RANK_NAME", g_rgeGangRanks[i][slot][e_szRankName]);
            cache_get_value_name_int(j, "RANK_PERMISSIONS", g_rgeGangRanks[i][slot][e_iRankPermisionFlags]);
        }

        cache_delete(rank_cache);
        cache_set_active(gangs_cache);
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
    if((newkeys & (KEY_SPRINT | KEY_YES)) == KEY_SPRINT | KEY_YES)
    {
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

    SetExclusiveBroadcast(true);
    TextDrawSetString(g_tdGangs[2], Gang_Data(Player_Gang(playerid))[e_szGangName]);
    TextDrawSetString_s(g_tdGangs[3], @f("Miembros: %i", member_count));
    TextDrawSetString(g_tdGangs[4], g_rgszGangIcons[Gang_Data(Player_Gang(playerid))[e_iGangIcon]][1]);
    SetExclusiveBroadcast(false);
    
    for(new i = sizeof(g_tdGangs) - 3; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdGangs[i]);
    }

    if(member_count > 7)
        TextDrawShowForPlayer(playerid, g_tdGangs[8]);

    SelectTextDraw(playerid, 0xCB3126FF);

    new rowc;
    cache_get_row_count(rowc);

    for(new i; i < rowc; ++i)
    {
        new current_playerid, name[25], rank;
        cache_get_value_name_int(i, "CURRENT_PLAYERID", current_playerid);
        cache_get_value_name(i, "NAME", name);
        cache_get_value_name_int(i, "GANG_RANK", rank);

        TextDrawShowForPlayer(playerid, g_tdGangMemberSlotBg[i]);
        PlayerTextDrawSetString(playerid, p_tdGangMemberSlots[playerid][i]{0}, (current_playerid == -1 ? "~r~." : "~g~."));
        PlayerTextDrawShow(playerid, p_tdGangMemberSlots[playerid][i]{0});
        PlayerTextDrawSetString(playerid, p_tdGangMemberSlots[playerid][i]{1}, name);
        PlayerTextDrawShow(playerid, p_tdGangMemberSlots[playerid][i]{1});
        PlayerTextDrawSetString(playerid, p_tdGangMemberSlots[playerid][i]{2}, g_rgeGangRanks[Player_Gang(playerid)][rank - 1][e_szRankName]);
        PlayerTextDrawShow(playerid, p_tdGangMemberSlots[playerid][i]{2});
    }

    return 1;
}

public GANGS_PanelMembersFetched(playerid)
{
    new rowc, member_count;
    cache_get_row_count(rowc);
    cache_get_value_name_int(0, "MEMBER_COUNT", member_count);

    SetExclusiveBroadcast(true);
    BroadcastToPlayer(playerid);
    TextDrawSetString(g_tdGangs[2], Gang_Data(Player_Gang(playerid))[e_szGangName]);
    TextDrawSetString_s(g_tdGangs[3], @f("Miembros: %i", member_count));
    TextDrawSetString(g_tdGangs[4], g_rgszGangIcons[Gang_Data(Player_Gang(playerid))[e_iGangIcon]][1]);
    BroadcastToPlayer(playerid, false);
    SetExclusiveBroadcast(false);

    DEBUG_PRINT("@ fun GANGS_PanelMembersFetched(playerid = %i)", playerid);
    DEBUG_PRINT("      rowc = %i", rowc);
    DEBUG_PRINT("      member_count = %i", member_count);
    DEBUG_PRINT("[ext] g_rgiPanelPage{%i} = %i", playerid, g_rgiGangPanelPage{playerid});

    if(member_count < (g_rgiGangPanelPage{playerid} * 7))
    {
        TextDrawHideForPlayer(playerid, g_tdGangs[8]);
    }
    else
    {
        if(!IsTextDrawVisibleForPlayer(playerid, g_tdGangs[8]))
        {
            TextDrawShowForPlayer(playerid, g_tdGangs[8]);
        }
    }
    
    for(new i; i < rowc; ++i)
    {
        new current_playerid, name[25], rank;
        cache_get_value_name_int(i, "CURRENT_PLAYERID", current_playerid);
        cache_get_value_name(i, "NAME", name);
        cache_get_value_name_int(i, "GANG_RANK", rank);

        TextDrawShowForPlayer(playerid, g_tdGangMemberSlotBg[i]);
        PlayerTextDrawSetString(playerid, p_tdGangMemberSlots[playerid][i]{0}, (current_playerid == -1 ? "~r~." : "~g~."));
        PlayerTextDrawSetString(playerid, p_tdGangMemberSlots[playerid][i]{1}, name);
        PlayerTextDrawSetString(playerid, p_tdGangMemberSlots[playerid][i]{2}, g_rgeGangRanks[Player_Gang(playerid)][rank - 1][e_szRankName]);
        if(!IsPlayerTextDrawVisible(playerid, p_tdGangMemberSlots[playerid][i]{0}))
        {
            PlayerTextDrawShow(playerid, p_tdGangMemberSlots[playerid][i]{0});
            PlayerTextDrawShow(playerid, p_tdGangMemberSlots[playerid][i]{1});
            PlayerTextDrawShow(playerid, p_tdGangMemberSlots[playerid][i]{2});
        }
    }

    for(new i = rowc; i < sizeof(p_tdGangMemberSlots[]); ++i)
    {
        TextDrawHideForPlayer(playerid, g_tdGangMemberSlotBg[i]);
        PlayerTextDrawHide(playerid, p_tdGangMemberSlots[playerid][i]{0});
        PlayerTextDrawHide(playerid, p_tdGangMemberSlots[playerid][i]{1});
        PlayerTextDrawHide(playerid, p_tdGangMemberSlots[playerid][i]{2});
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

        new caption[128];
        format(caption, sizeof(caption), "{CB3126}>>{DADADA} Banda: {%06x}%s", Gang_Data(Player_Gang(playerid))[e_iGangColor] >>> 8, Gang_Data(Player_Gang(playerid))[e_szGangName]);
        
        if(!Player_IsGangOwner(playerid) && !(Player_GangRankData(playerid)[e_iRankPermisionFlags] & _:(~(GANG_PERM_KICK_MEMBERS | GANG_PERM_EDIT_MEMBERS))))
        {
            Dialog_Show(playerid, "", DIALOG_STYLE_MSGBOX, caption, "{DADADA}No tienes permisos para modificar esta banda.", "Entendido");
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

        strcat(HYAXE_UNSAFE_HUGE_STRING, "{CB3126}>>{DADADA} Abandonar banda");
        if(Player_IsGangOwner(playerid))
            strcat(HYAXE_UNSAFE_HUGE_STRING, "\n{CB3126}>>{DADADA} Ceder administración");

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

static 
    s_rgszSelectedGangMember[MAX_PLAYERS][25];

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(Bit_Get(Player_Flags(playerid), PFLAG_GANG_PANEL_OPEN))
    {
        for(new i = sizeof(p_tdGangMemberSlots[]) - 1; i != -1; --i)
        {
            if(playertextid == p_tdGangMemberSlots[playerid][i]{1})
            {
                PlayerTextDrawGetString(playerid, p_tdGangMemberSlots[playerid][i]{1}, s_rgszSelectedGangMember[playerid]);
                if(!strcmp(s_rgszSelectedGangMember[playerid], Player_Name(playerid)))
                    return 1;

                if(s_rgbSelectingNewOwner{playerid})
                {
                    s_rgbSelectingNewOwner{playerid} = false;
                    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                        SELECT `ID` FROM `ACCOUNT` WHERE `NAME` = '%e' LIMIT 1;\
                    ",
                        s_rgszSelectedGangMember[playerid]
                    );
                    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "GANGS_NewOwnerFetched", "i", playerid);
                    return 1;
                }

                Gangs_ClosePanel(playerid);

                Dialog_Show_s(playerid, "gang_member", DIALOG_STYLE_LIST, @f("{CB3126}>>{DADADA} %s", s_rgszSelectedGangMember[playerid]), @("{CB3126}>{DADADA} Cambiar rol\n{CB3126}>>{DADADA} Expulsar miembro"), "Seleccionar", "Atrás");
                return 1;
            }
        }
    }

    #if defined GANGS_OnPlayerClickPlayerTD
        return GANGS_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerClickPlayerTD
    #undef OnPlayerClickPlayerTD
#else
    #define _ALS_OnPlayerClickPlayerTD
#endif
#define OnPlayerClickPlayerTextDraw GANGS_OnPlayerClickPlayerTD
#if defined GANGS_OnPlayerClickPlayerTD
    forward GANGS_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
#endif

public GANGS_NewOwnerFetched(playerid)
{
    new rowc;
    cache_get_row_count(rowc);
    if(!rowc)
    {
        s_rgbSelectingNewOwner{playerid} = false;
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Se produjo un error al seleccionar el usuario");
        return 1;
    }

    new accid;
    cache_get_value_name_int(0, "ID", accid);

    g_rgeGangs[Player_Gang(playerid)][e_iGangOwnerId] = accid;
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `GANGS` SET `CREATOR_ID` = %i WHERE `GANG_ID` = %i;", accid, Gang_Data(Player_Gang(playerid))[e_iGangDbId]);
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}El dueño de la banda ahora es {CB3126}%s{DADADA}.", s_rgszSelectedGangMember[playerid]);
    Dialog_Show(playerid, "", DIALOG_STYLE_MSGBOX, "{CB3126}>{DADADA} Permisos cedidos", HYAXE_UNSAFE_HUGE_STRING, "Entendido");

    return 1;
}

dialog gang_member(playerid, response, listitem, const inputtext[])
{
    if(!response)
    {
        Gangs_OpenPanel(playerid);
        return 1;
    }

    switch(listitem)
    {
        case 0: // Change role
        {
            strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Los roles están ordenados por su importancia jerárquica\t \n");
            new line[120];

            for(new i = sizeof(g_rgeGangRanks[]) - 1; i != -1; --i)
            {
                if(g_rgeGangRanks[Player_Gang(playerid)][i][e_iRankId])
                {
                    format(line, sizeof(line), "{DADADA}%2i {CB3126}>{%06x} %s\t \n", i + 1, (Player_GangRank(playerid) > i || Player_IsGangOwner(playerid) ? 0xDADADA : 0x969696), g_rgeGangRanks[Player_Gang(playerid)][i][e_szRankName]);
                }
                else
                {
                    format(line, sizeof(line), "{DADADA}%2i {CB3126}>{969696} Vacío\t \n", i + 1);
                }

                strcat(HYAXE_UNSAFE_HUGE_STRING, line);
            }

            format(line, sizeof(line), "{CB3126}>>{DADADA} Cambiar rol de %s", s_rgszSelectedGangMember[playerid]);
            Dialog_Show(playerid, "gang_member_change_role", DIALOG_STYLE_TABLIST_HEADERS, line, HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Cancelar");
        }
        case 1: // Kick member
        {
            Dialog_Show_s(playerid, "gang_kick_member", DIALOG_STYLE_MSGBOX, @("{CB3126}>>{DADADA} Expulsar miembro"), @f("{DADADA}¿Estás seguro de que quieres expulsar a {CB3126}%s{DADADA}?", s_rgszSelectedGangMember[playerid]), "Expulsar", "Cancelar");
        }
    }

    return 1;
}

dialog gang_member_change_role(playerid, response, listitem, const inputtext[])
{
    if(!response)
    {
        Dialog_Show_s(playerid, "gang_member", DIALOG_STYLE_LIST, @f("{CB3126}>>{DADADA} %s", s_rgszSelectedGangMember[playerid]), @("{CB3126}>{DADADA} Cambiar rol\n{CB3126}>>{DADADA} Expulsar miembro"), "Seleccionar", "Atrás");
        return 1;
    }

    new rankid = 9 - listitem;

    if(!(0 <= listitem <= 9) || (rankid >= Player_GangRank(playerid) && !Player_IsGangOwner(playerid)) || !g_rgeGangRanks[Player_Gang(playerid)][rankid][e_iRankId])
    {
        strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Los roles están ordenados por su importancia jerárquica\t \n");
        new line[120];

        for(new i = sizeof(g_rgeGangRanks[]) - 1; i != -1; --i)
        {
            if(g_rgeGangRanks[Player_Gang(playerid)][i][e_iRankId])
            {
                format(line, sizeof(line), "{DADADA}%2i {CB3126}>{%06x} %s\t \n", i + 1, (Player_GangRank(playerid) > i || Player_IsGangOwner(playerid) ? 0xDADADA : 0x969696), g_rgeGangRanks[Player_Gang(playerid)][i][e_szRankName]);
            }
            else
            {
                format(line, sizeof(line), "{DADADA}%2i {CB3126}>{969696} Vacío\t \n", i + 1);
            }

            strcat(HYAXE_UNSAFE_HUGE_STRING, line);
        }

        format(line, sizeof(line), "{CB3126}>>{DADADA} Cambiar rol de %s", s_rgszSelectedGangMember[playerid]);
        Dialog_Show(playerid, "gang_member_change_role", DIALOG_STYLE_TABLIST_HEADERS, line, HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Cancelar");
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No puedes asignarle un rango vacío o superior al tuyo");
        return 1;
    }

    foreach(new i : GangMember[Player_Gang(playerid)])
    {
        if(!strcmp(Player_Name(i), s_rgszSelectedGangMember[playerid]))
        {
            Player_GangRank(i) = rankid;
        }

        if(Bit_Get(Player_Flags(i), PFLAG_GANG_PANEL_OPEN))
            Gangs_UpdatePanel(i);
    }

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `GANG_RANK` = %i WHERE `NAME` = '%e' LIMIT 1;", rankid + 1, s_rgszSelectedGangMember[playerid]);
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    Gang_SendMessage_s(Player_Gang(playerid), @f("[MIEMBRO]{DADADA} %s fue asignado a %s por %s.", s_rgszSelectedGangMember[playerid], g_rgeGangRanks[Player_Gang(playerid)][rankid][e_szRankName], Player_RPName(playerid)));
    Gangs_OpenPanel(playerid);

    return 1;
}

dialog gang_kick_member(playerid, response, listitem, const inputtext[])
{
    if(!response)
    {
        Dialog_Show_s(playerid, "gang_member", DIALOG_STYLE_LIST, @f("{CB3126}>>{DADADA} %s", s_rgszSelectedGangMember[playerid]), @("{CB3126}>{DADADA} Cambiar rol\n{CB3126}>>{DADADA} Expulsar miembro"), "Seleccionar", "Atrás");
        return 1;
    }

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `GANG_ID` = NULL, `GANG_RANK` = 1 WHERE `NAME` = '%e';", s_rgszSelectedGangMember[playerid]);
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    Gang_SendMessage_s(Player_Gang(playerid), @f("[MIEMBRO]{DADADA} %s fue expulsado de la banda por %s.", s_rgszSelectedGangMember[playerid], Player_RPName(playerid)));
    
    foreach(new i : GangMember[Player_Gang(playerid)])
    {
        if(!strcmp(Player_Name(i), s_rgszSelectedGangMember[playerid]))
        {
            if(Bit_Get(Player_Flags(i), PFLAG_GANG_PANEL_OPEN))
                Gangs_ClosePanel(i);

            Player_Gang(i) = -1;
            Iter_SafeRemove(GangMember[Player_Gang(playerid)], i, i);
        }

        if(Bit_Get(Player_Flags(i), PFLAG_GANG_PANEL_OPEN))
            Gangs_UpdatePanel(i);
    }

    Gangs_OpenPanel(playerid);

    return 1;
}

dialog modify_gang(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        Gangs_OpenPanel(playerid);
        return 1;
    }

    new perm = 1 << listitem;

    // Abandon gang
    if(perm == _:GANG_PERM_LAST)
    {
        strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}¿Estás seguro de que quieres abandonar tu banda?");
        if(Player_IsGangOwner(playerid))
            strcat(HYAXE_UNSAFE_HUGE_STRING, " Si abandonas la banda, se borrará.");

        Dialog_Show(playerid, "gang_abandon", DIALOG_STYLE_MSGBOX, "{CB3126}>{DADADA} Abandonar banda", HYAXE_UNSAFE_HUGE_STRING, "Abandonar", "Cancelar");
        return 1;
    }
    else if(perm == (_:GANG_PERM_LAST << 1))
    {
        Dialog_Show(playerid, "gang_give_owner", DIALOG_STYLE_MSGBOX, "{CB3126}>{DADADA} Ceder administración de la banda", "{DADADA}¿Estás seguro de que deseas ceder tu cargo como dueño de la banda? Perderás todos los permisos que no esten asignados a tu rol y no podrás hacer ninguna acción sobre miembros superiores a ti.", "Siguiente", "Cancelar");
        return 1;
    }

    new caption[40];
    format(caption, sizeof(caption), "{CB3126}>>{DADADA} %s", g_rgszGangPermNames[listitem]);
    
    if(!Player_IsGangOwner(playerid) && !(Player_GangRankData(playerid)[e_iRankPermisionFlags] & perm))
    {
        Dialog_Show(playerid, "", DIALOG_STYLE_MSGBOX, caption, "{DADADA}No tienes permisos para usar esta opción.", "Entendido");
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
        case GANG_PERM_CHANGE_ROLES:
        {
            GangPanel_OpenRoles(playerid);
        }
        case GANG_PERM_KICK_MEMBERS, GANG_PERM_EDIT_MEMBERS:
        {
            Dialog_Show(playerid, "null", DIALOG_STYLE_MSGBOX, caption, "{DADADA}Para editar o expulsar a algun miembro de la banda, presiona su nombre en el panel de banda.", "Entendido");
        }
        case GANG_PERM_INVITE_MEMBERS:
        {
            Dialog_Show(playerid, "gang_invite_member", DIALOG_STYLE_INPUT, caption, "{DADADA}Para invitar a un miembro a la banda, introduce su {CB3126}nombre{DADADA} o {CB3126}ID de jugador{DADADA}.", "Reclutar", "Cancelar");
        }
    }

    return 1;
}

dialog gang_give_owner(playerid, response, listitem, const inputtext[])
{
    if(response)
    {
        s_rgbSelectingNewOwner{playerid} = true;
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Selecciona al nuevo dueño en la lista de miembros");
    }

    Gangs_OpenPanel(playerid);
    return 1;
}

dialog gang_abandon(playerid, response, listitem, const inputtext[])
{
    if(!response)
        return 1;

    if(Player_IsGangOwner(playerid))
    {
        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "DELETE FROM `GANGS` WHERE `GANG_ID` = %i;", Gang_Data(Player_Gang(playerid))[e_iGangDbId]);
        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

        Gang_SendMessage(Player_Gang(playerid), "[BANDA]{DADADA} La banda fue eliminada.");
        new gangid = Player_Gang(playerid);

        foreach(new i : GangMember[gangid])
        {
            Gangs_ClosePanel(i);
            Player_Gang(i) = -1;
        }

        Iter_Clear(GangMember[gangid]);
        g_rgeGangs[gangid][e_iGangDbId] =
        g_rgeGangs[gangid][e_szGangName] = '\0';

        for(new i = sizeof(g_rgeGangRanks[]) - 1; i != -1; --i)
        {
            g_rgeGangRanks[gangid][i][e_iRankId] = 0;
        }
    }
    else
    {
        Gang_SendMessage_s(Player_Gang(playerid), @f("[MIEMBROS]{DADADA} %s abandonó la banda.", Player_RPName(playerid)));
        
        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `GANG_ID` = NULL WHERE `ID` = %i;", Player_AccountID(playerid));
        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
        
        Iter_Remove(GangMember[Player_Gang(playerid)], playerid);
        Player_Gang(playerid) = -1;
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

dialog gang_change_role(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        Gangs_OpenPanel(playerid);
        return 1;
    }

    if(!(0 <= listitem < sizeof(g_rgeGangRanks[])))
        return 1;

    new rankid = 9 - listitem;
    if(!Player_IsGangOwner(playerid) && rankid > Player_GangRank(playerid))
    {
        GangPanel_OpenRoles(playerid);
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No puedes modificar roles superiores al tuyo");
        return 1;
    }

    if(!g_rgeGangRanks[Player_Gang(playerid)][rankid][e_iRankId])
    {
        g_rgiPanelSelectedRole{playerid} = rankid;
        g_rgeGangRanks[Player_Gang(playerid)][rankid][e_iRankId] = -1;
        Dialog_Show(playerid, "gang_create_role", DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Crear nuevo rol", "{DADADA}Introduce el nombre del rol a crear. No debe contener más de {CB3126}32{DADADA} caracteres.", "Siguiente", "Cancelar");
    }
    else if(g_rgeGangRanks[Player_Gang(playerid)][rankid][e_iRankId] == -1)
    {
        Dialog_Show(playerid, "gang_role_being_created", DIALOG_STYLE_MSGBOX, "{CB3126}>>{DADADA} Crear nuevo rol", "{DADADA}Otro jugador ya está creando este rol, podrás modificarlo cuando termine de crearlo.", "Entendido");
    }
    else
    {
        g_rgiPanelSelectedRole{playerid} = rankid;
        GangPanel_OpenRoleOptions(playerid);
    }

    return 1;
}

dialog gang_role_being_created(playerid, response, listitem, inputtext[])
{
    GangPanel_OpenRoles(playerid);
    return 1;
}

dialog gang_create_role(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankId] = 0;
        g_rgiPanelSelectedRole{playerid} = 0xFF;
        Gangs_OpenPanel(playerid);
        return 1;
    }

    if(isnull(inputtext) || strlen(inputtext) > 32)
    {
        Dialog_Show(playerid, "gang_create_role", DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Crear nuevo rol", "{DADADA}Introduce el nombre del rol a crear. No debe contener más de {CB3126}32{DADADA} caracteres.", "Siguiente", "Cancelar");
        return 1;
    }

    strcpy(g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_szRankName], inputtext);
    g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankPermisionFlags] = 0;

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        INSERT INTO `GANG_RANKS` \
            (`GANG_ID`, `RANK_NAME`, `RANK_HIERARCHY`, `RANK_PERMISSIONS`) \
        VALUES \
            (%i, '%e', %i, 0);\
        ",
    Gang_Data(Player_Gang(playerid))[e_iGangDbId], inputtext, g_rgiPanelSelectedRole{playerid} + 1);
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "GANGS_RoleCreated", "i", playerid);

    return 1;
}

public GANGS_RoleCreated(playerid)
{
    g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankId] = cache_insert_id();
    g_rgiPanelSelectedRole{playerid} = 0xFF;
    Dialog_Show(playerid, "gang_role_created", DIALOG_STYLE_MSGBOX, "{CB3126}>>{DADADA} Rol creado", "{DADADA}El rol fue creado exitosamente. Dirígete al panel de roles para editar sus permisos.", "Entendido");
    return 1;
}

dialog gang_role_created(playerid, response, listitem, inputtext[])
{
    GangPanel_OpenRoles(playerid);
    return 1;
}

dialog gang_role_modify_option(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        GangPanel_OpenRoles(playerid);
        g_rgiPanelSelectedRole{playerid} = 0xFF;
        return 1;
    }

    switch(listitem)
    {
        case 0:
        {
            Dialog_Show(playerid, "gang_role_change_name", DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Cambiar nombre del rol", "{DADADA}Introduce el nuevo nombre del rol a crear. No debe contener más de {CB3126}32{DADADA} caracteres.", "Cambiar", "Cancelar");
        }
        case 1:
        {
            GangPanel_OpenRolePermissions(playerid);
        }
        case 2:
        {
            GangPanel_OpenRoleSwap(playerid);
        }
    }
    
    return 1;
}

dialog gang_role_change_name(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        GangPanel_OpenRoleOptions(playerid);
        return 1;
    }

    if(isnull(inputtext) || strlen(inputtext) > 32)
    {
        Dialog_Show(playerid, "gang_role_change_name", DIALOG_STYLE_INPUT, "{CB3126}>>{DADADA} Cambiar nombre del rol", "{DADADA}Introduce el nuevo nombre del rol a crear. No debe contener más de {CB3126}32{DADADA} caracteres.", "Cambiar", "Atrás");
        return 1;
    }

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "[BANDA]{DADADA} %s cambió el nombre del rango '%s' a '%s'.", Player_RPName(playerid), g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_szRankName], inputtext);
    Gang_SendMessage(Player_Gang(playerid), HYAXE_UNSAFE_HUGE_STRING);

    strcpy(g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_szRankName], inputtext);

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, 
        "UPDATE `GANG_RANKS` SET `RANK_NAME` = '%e' WHERE `RANK_ID` = %i;",
    inputtext, g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankId]);
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    GangPanel_OpenRoleOptions(playerid);
    return 1;
}

dialog gang_role_change_perms(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, 
            "UPDATE `GANG_RANKS` SET `RANK_PERMISSIONS` = %i WHERE `RANK_ID` = %i;",
            g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankPermisionFlags],
            g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankId]
        );
        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

        GangPanel_OpenRoleOptions(playerid);
        return 1;
    }

    if((1 << listitem) == _:GANG_PERM_CHANGE_ROLES && (Player_GangRank(playerid) == g_rgiPanelSelectedRole{playerid} && !Player_IsGangOwner(playerid)))
    {
        Dialog_Show(playerid, "gang_cant_change_perm", DIALOG_STYLE_MSGBOX, "{CB3126}>>{DADADA} Permisos", "{DADADA}No puedes deshabilitar este permiso para tu rango actual.", "Entendido");
        return 1;
    }

    g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankPermisionFlags] ^= (1 << listitem);
    GangPanel_OpenRolePermissions(playerid);
    return 1;
}

dialog gang_cant_change_perm(playerid, response, listitem, inputtext[])
{
    GangPanel_OpenRolePermissions(playerid);
    return 1;
}

dialog gang_exchange_slot(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        GangPanel_OpenRoleOptions(playerid);
        return 1;
    }

    if(!(0 <= listitem < sizeof(g_rgeGangRanks[])))
        return 1;

    new rankid = 9 - listitem;
    if(rankid > Player_GangRank(playerid) && !Player_IsGangOwner(playerid))
    {
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No puedes intercambiarlo por un rol superior al tuyo");
        GangPanel_OpenRoleSwap(playerid);
        return 1;
    }

    new copy[eGangRankData];
    copy = g_rgeGangRanks[Player_Gang(playerid)][rankid];

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        UPDATE `GANG_RANKS` \
        SET `RANK_HIERARCHY` = CASE `RANK_ID` \
        WHEN %i THEN %i \
        WHEN %i THEN %i \
        ELSE `RANK_HIERARCHY` END WHERE `RANK_ID` IN(%i, %i);\
    ",
        copy[e_iRankId], g_rgiPanelSelectedRole{playerid} + 1,
        g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankId], rankid + 1,
        copy[e_iRankId], g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankId]
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    g_rgeGangRanks[Player_Gang(playerid)][rankid] = g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}];
    g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}] = copy;

    Dialog_Show(playerid, "gang_role_swap_success", DIALOG_STYLE_MSGBOX, "{CB3126}>>{DADADA} Roles intercambiados", "{DADADA}Los roles fueron intercambiados con éxito.", "Entendido");
    return 1;
}

dialog gang_role_swap_success(playerid, response, listitem, inputtext[])
{
    GangPanel_OpenRoles(playerid);
    return 1;
}

dialog gang_invite_member(playerid, response, listitem, const inputtext[])
{
    if(!response)
    {
        Gangs_OpenPanel(playerid);
        return 1;
    }

    new recruit;
    if(sscanf(inputtext, "r", recruit) || !IsPlayerConnected(recruit))
    {
        Dialog_Show(playerid, "gang_invite_member", DIALOG_STYLE_INPUT, "{CB3126}>{DADADA} Usuario inválido o desconectado", "{DADADA}Para invitar a un miembro a la banda, introduce su {CB3126}nombre{DADADA} o {CB3126}ID de jugador{DADADA}.", "Reclutar", "Cancelar");
        return 1;
    }

    if(recruit == playerid)
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "No te puedes invitar a ti mism%c", (Player_Sex(recruit) == SEX_MALE ? 'o' : 'a'));
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, HYAXE_UNSAFE_HUGE_STRING);
        Dialog_Show(playerid, "gang_invite_member", DIALOG_STYLE_INPUT, "{CB3126}>{DADADA} Invitar jugadores", "{DADADA}Para invitar a un miembro a la banda, introduce su {CB3126}nombre{DADADA} o {CB3126}ID de jugador{DADADA}.", "Reclutar", "Cancelar");
        return 1;
    }

    if(Player_Gang(recruit) == Player_Gang(playerid))
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "%s ya está en tu banda", (Player_Sex(recruit) == SEX_MALE ? "El jugador" : "La jugadora"));
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, HYAXE_UNSAFE_HUGE_STRING);
        Dialog_Show(playerid, "gang_invite_member", DIALOG_STYLE_INPUT, "{CB3126}>{DADADA} Invitar jugadores", "{DADADA}Para invitar a un miembro a la banda, introduce su {CB3126}nombre{DADADA} o {CB3126}ID de jugador{DADADA}.", "Reclutar", "Cancelar");
        return 1;
    }

    if(Player_Gang(recruit) != -1)
    {
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "%s ya está en otra banda", (Player_Sex(recruit) == SEX_MALE ? "El jugador" : "La jugadora"));
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, HYAXE_UNSAFE_HUGE_STRING);
        Dialog_Show(playerid, "gang_invite_member", DIALOG_STYLE_INPUT, "{CB3126}>{DADADA} Invitar jugadores", "{DADADA}Para invitar a un miembro a la banda, introduce su {CB3126}nombre{DADADA} o {CB3126}ID de jugador{DADADA}.", "Reclutar", "Cancelar");
        return 1;
    }

    new rank = Gang_GetLowestRank(Player_Gang(playerid));

    SetPVarInt(recruit, "gang:invite_id", Player_Gang(playerid));
    Dialog_Show_s(recruit, "gang_invite_notice", DIALOG_STYLE_MSGBOX, @("{CB3126}>{DADADA} Invitación a banda"), 
        @f("%{DADADA%}Fuiste invitad%c para unirte a la banda %{%06x%}%s%{DADADA%} con el rango de %s.", 
            (Player_Sex(recruit) == SEX_MALE ? 'o' : 'a'), 
            g_rgeGangs[Player_Gang(playerid)][e_iGangColor] >>> 8, 
            g_rgeGangs[Player_Gang(playerid)][e_szGangName], 
            g_rgeGangRanks[Player_Gang(playerid)][rank][e_szRankName]
        ), "Aceptar", "Rechazar");
    Dialog_Show_s(playerid, "", DIALOG_STYLE_MSGBOX, @f("{CB3126}>{DADADA} %s", (Player_Sex(recruit) == SEX_MALE ? "Jugador invitado" : "Jugadora invitada")), @f("{DADADA}%s {CB3126}%s{DADADA} fue invitado a la banda con el rango menor de %s. Espera a que responda.", (Player_Sex(recruit) == SEX_MALE ? "El jugador" : "La jugadora"), Player_RPName(recruit), g_rgeGangRanks[Player_Gang(playerid)][rank][e_szRankName]), "Entendido");

    return 1;
}

dialog gang_invite_notice(playerid, response, listitem, const inputtext[])
{
    if(response)
    {
        new gangid = GetPVarInt(playerid, "gang:invite_id"); 
        Player_Gang(playerid) = gangid;
        Player_GangRank(playerid) = Gang_GetLowestRank(gangid);
        Iter_Add(GangMember[gangid], playerid);

        Gang_SendMessage_s(gangid, @f("[MIEMBRO]{DADADA} %s %s se unio a la banda con el rango %s.", (Player_Sex(playerid) == SEX_MALE ? "El jugador" : "La jugadora"), Player_RPName(playerid), g_rgeGangRanks[gangid][Player_GangRank(playerid)][e_szRankName]));
        mysql_tquery_s(g_hDatabase, @f("UPDATE `ACCOUNT` SET `GANG_ID` = %i, `GANG_RANK` = %i WHERE `ID` = %i;", g_rgeGangs[gangid][e_iGangDbId], Player_GangRank(playerid) + 1, Player_AccountID(playerid)));
    }

    DeletePVar(playerid, "gang:invite_id");
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(g_rgiPanelSelectedRole{playerid} != 0xFF && g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankId] == -1)
    {
        g_rgeGangRanks[Player_Gang(playerid)][g_rgiPanelSelectedRole{playerid}][e_iRankId] = 0;
        g_rgiPanelSelectedRole{playerid} = 0xFF;
    }

    DeletePVar(playerid, "gang:invite_id");

    #if defined GANGS_OnPlayerDisconnect
        return GANGS_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect GANGS_OnPlayerDisconnect
#if defined GANGS_OnPlayerDisconnect
    forward GANGS_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerCancelTDSelection(playerid)
{
    if(Bit_Get(Player_Flags(playerid), PFLAG_GANG_PANEL_OPEN))
    {
        s_rgbSelectingNewOwner{playerid} = false;
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

public OnPlayerText(playerid, text[])
{
    if (text[0] == '!')
    {
        if (Player_Gang(playerid) != -1)
        {
            new messages[2][144];
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{%06x}[%s] {DADADA}%s: %s", Gang_Data(Player_Gang(playerid))[e_iGangColor] >>> 8, Gang_Data(Player_Gang(playerid))[e_szGangName], Player_RPName(playerid), text[1]);
            for(new i, j = SplitChatMessageInLines(HYAXE_UNSAFE_HUGE_STRING, messages); i < j; ++i)
                Gang_SendMessage(Player_Gang(playerid), messages[i]);

            return 0;
        }
    }

    #if defined GANGS_OnPlayerText
        return GANGS_OnPlayerText(playerid, text);
    #else
        return 0;
    #endif
}

#if defined _ALS_OnPlayerText
    #undef OnPlayerText
#else
    #define _ALS_OnPlayerText
#endif
#define OnPlayerText GANGS_OnPlayerText
#if defined GANGS_OnPlayerText
    forward GANGS_OnPlayerText(playerid, text[]);
#endif
