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
        new name[64];
        cache_get_value_name_int(i, "GANG_ID", g_rgeGangs[i][e_iGangDbId]);
        cache_get_value_name(i, "GANG_NAME", name);
        strpack(g_rgeGangs[i][e_szGangName], name);
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
