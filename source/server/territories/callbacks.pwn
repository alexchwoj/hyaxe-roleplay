#if defined _territories_callbacks_
    #endinput
#endif
#define _territories_callbacks_

public OnGameModeInit()
{
    new Cache:territories_cache = mysql_query(g_hDatabase, "SELECT * FROM `ZONES`;", .use_cache = true);
    #pragma nodestruct territories_cache

    new rowc;
    cache_get_row_count(rowc);
    
    for(new i; i < rowc; ++i)
    {
        g_rgeTerritories[i][e_bValid] = true;

        cache_get_value_name_int(i, "ID", g_rgeTerritories[i][e_iID]);
        cache_get_value_name(i, "NAME", g_rgeTerritories[i][e_szName]);

        cache_get_value_name_float(i, "MIN_X", g_rgeTerritories[i][e_fMinX]);
        cache_get_value_name_float(i, "MIN_Y", g_rgeTerritories[i][e_fMinY]);
        cache_get_value_name_float(i, "MIN_Z", g_rgeTerritories[i][e_fMinZ]);
        cache_get_value_name_float(i, "MAX_X", g_rgeTerritories[i][e_fMaxX]);
        cache_get_value_name_float(i, "MAX_Y", g_rgeTerritories[i][e_fMaxY]);
        cache_get_value_name_float(i, "MAX_Z", g_rgeTerritories[i][e_fMaxZ]);

        cache_get_value_name_bool(i, "GANG_ZONE", g_rgeTerritories[i][e_bIsConquerable]);

        if (g_rgeTerritories[i][e_bIsConquerable])
        {
            g_rgeTerritories[i][e_iColor] = 0xF7F7F755;
            g_rgeTerritories[i][e_iGangZone] = GangZoneCreate(g_rgeTerritories[i][e_fMinX], g_rgeTerritories[i][e_fMinY], g_rgeTerritories[i][e_fMaxX], g_rgeTerritories[i][e_fMaxY]);
            g_rgeTerritories[i][e_iArea] = CreateDynamicCube(
                g_rgeTerritories[i][e_fMinX],
                g_rgeTerritories[i][e_fMinY],
                g_rgeTerritories[i][e_fMinZ],
                g_rgeTerritories[i][e_fMaxX],
                g_rgeTerritories[i][e_fMaxY],
                g_rgeTerritories[i][e_fMaxZ],
                .worldid = 0, .interiorid = 0
            );
            Streamer_SetIntData(STREAMER_TYPE_AREA, g_rgeTerritories[i][e_iArea], E_STREAMER_CUSTOM(0x544552), i); // TER
        }        

        cache_set_active(territories_cache);
    }

    cache_delete(territories_cache);

    printf("[territory] Loaded %i territories.", rowc);

    #if defined TERR_OnGameModeInit
        return TERR_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit TERR_OnGameModeInit
#if defined TERR_OnGameModeInit
    forward TERR_OnGameModeInit();
#endif


public OnPlayerConnect(playerid)
{
    for(new i; i < HYAXE_MAX_TERRITORIES; ++i)
    {
        if (g_rgeTerritories[i][e_bValid] && g_rgeTerritories[i][e_bIsConquerable])
        {
            GangZoneShowForPlayer(playerid, g_rgeTerritories[i][e_iGangZone], g_rgeTerritories[i][e_iColor]);
        }
    }

    #if defined TERR_OnPlayerConnect
        return TERR_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect TERR_OnPlayerConnect
#if defined TERR_OnPlayerConnect
    forward TERR_OnPlayerConnect(playerid);
#endif
