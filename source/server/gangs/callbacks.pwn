#if defined _gangs_callbacks_
    #endinput
#endif
#define _gangs_callbacks_

public OnGameModeInit()
{
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
