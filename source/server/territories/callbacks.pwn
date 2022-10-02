#if defined _territories_callbacks_
    #endinput
#endif
#define _territories_callbacks_

public OnScriptInit()
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
            g_rgeTerritories[i][e_iGangAttacking] = -1;
            g_rgeTerritories[i][e_iColor] = 0xD1D1D133;
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

            mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "SELECT `GANG_TERRITORIES`.`GANG_ID`, `GANGS`.`GANG_COLOR` FROM `GANG_TERRITORIES`, `GANGS` WHERE `TERRITORY_ID` = '%d' AND `GANGS`.`GANG_ID` = `GANG_TERRITORIES`.`GANG_ID`;", g_rgeTerritories[i][e_iID]);
            new Cache:territory_cache = mysql_query(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, .use_cache = true);
            #pragma nodestruct territory_cache

            new gang_territory;
            if (cache_get_row_count(gang_territory))
            {
                cache_get_value_name_int(0, "GANG_ID", g_rgeTerritories[i][e_iGangID]);
                cache_get_value_name_int(0, "GANG_COLOR", g_rgeTerritories[i][e_iColor]);

                new r, g, b;
                r = (g_rgeTerritories[i][e_iColor] >> 24) & 0xFF;
                g = (g_rgeTerritories[i][e_iColor] >> 16) & 0xFF;
                b = (g_rgeTerritories[i][e_iColor] >> 8) & 0xFF;
                g_rgeTerritories[i][e_iColor] = (r << 24 | g << 16 | b << 8 | 135);
            }

            cache_delete(territory_cache);
        }

        cache_set_active(territories_cache);
    }

    cache_delete(territories_cache);

    printf("[territory] Loaded %i territories.", rowc);

    #if defined TERR_OnScriptInit
        return TERR_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit TERR_OnScriptInit
#if defined TERR_OnScriptInit
    forward TERR_OnScriptInit();
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

forward TERR_UpdateProgress(territory_index);
public TERR_UpdateProgress(territory_index)
{
    // Check if there are members within the territory
    new members;
    foreach(new i : Player)
    {
        if (IsPlayerInDynamicArea(i, g_rgeTerritories[territory_index][e_iArea]) && !Bit_Get(Player_Flags(i), PFLAG_INJURED) && Player_Gang(i) == g_rgeTerritories[territory_index][e_iGangAttacking])
            ++members;
    }
    printf("TERR_UpdateProgress, territory members: %d", members);

    if (!members)
    {
        new str_text[164];
        format(str_text, sizeof(str_text), "La banda ~y~%s~w~ no pudo conquistar el territorio en ~y~%s~w~ porque no hay quien lo defienda.", Gang_Data(g_rgeTerritories[territory_index][e_iGangAttacking])[e_szGangName], g_rgeTerritories[territory_index][e_szName]);
        GangEvent_SendNotification(str_text, 5000, 0xDAA838FF);

        Territory_CancelConquest(territory_index);
        return 0;
    }

    // Increase progress
    g_rgeTerritories[territory_index][e_fConquestProgress] += 5.0;
    if (g_rgeTerritories[territory_index][e_fConquestProgress] >= 100.0)
    {
        new str_text[164], payment = 100 + random(500);
        format(str_text, sizeof(str_text), "La banda ~y~%s~w~ ha conquistado el territorio en ~y~%s~w~, y cada miembro ha ganado $%s.", Gang_Data(g_rgeTerritories[territory_index][e_iGangAttacking])[e_szGangName], g_rgeTerritories[territory_index][e_szName], Format_Thousand(payment));
        GangEvent_SendNotification(str_text, 5000, 0xDAA838FF);

        foreach(new i : Player)
        {
            if (Player_Gang(i) == g_rgeTerritories[territory_index][e_iGangAttacking])
                Player_GiveMoney(i, payment);
        }

        Territory_SetGang(territory_index, g_rgeTerritories[territory_index][e_iGangAttacking]);
        Territory_CancelConquest(territory_index);
        return 0;
    }

    // Update text
    new str_text[144];
    format(str_text, sizeof(str_text), "Progreso de conquista: {CA3737}%.1f%%{FFFFFF}\n{CA3737}", g_rgeTerritories[territory_index][e_fConquestProgress]);

    new painted_lines = floatround(3 * (g_rgeTerritories[territory_index][e_fConquestProgress] / 5.0));
    for(new i; i <= painted_lines; ++i)
        strcat(str_text, "|");

    new unpainted_lines = 60 - painted_lines;
    strcat(str_text, "{7D3535}");
    for(new i; i <= unpainted_lines; ++i)
        strcat(str_text, "|");

    UpdateDynamic3DTextLabelText(g_rgeTerritories[territory_index][e_iLabel], 0xFFFFFFFF, str_text);
    return 1;
}