#if defined _safe_zones_callbacks_
    #endinput
#endif
#define _safe_zones_callbacks_

public OnScriptInit()
{
    for(new i; i < sizeof(g_rgeSafeZones); ++i)
    {
        new area_id = CreateDynamicSphere(g_rgeSafeZones[i][e_fZoneX], g_rgeSafeZones[i][e_fZoneY], g_rgeSafeZones[i][e_fZoneZ], g_rgeSafeZones[i][e_fRange], g_rgeSafeZones[i][e_iWorld], g_rgeSafeZones[i][e_iInterior]);
        Streamer_SetIntData(STREAMER_TYPE_AREA, area_id, E_STREAMER_CUSTOM(0x534146), 0); // SAF
    }

    #if defined SAZO_OnScriptInit
        return SAZO_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit SAZO_OnScriptInit
#if defined SAZO_OnScriptInit
    forward SAZO_OnScriptInit();
#endif

public OnPlayerDeath(playerid, killerid, reason)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME) && !Bit_Get(Player_Flags(playerid), PFLAG_IN_JAIL) && IsPlayerConnected(killerid))
    {
        new areas = GetPlayerNumberDynamicAreas(killerid);
        if (areas)
        {
            YSI_UNSAFE_HUGE_STRING[areas] = INVALID_STREAMER_ID;
            GetPlayerDynamicAreas(playerid, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH);
            
            for(new i; YSI_UNSAFE_HUGE_STRING[i] != INVALID_STREAMER_ID; ++i)
            {
                new areaid = YSI_UNSAFE_HUGE_STRING[i];
                if(Streamer_HasIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x534146)))
                {
                    Police_AddChargesToPlayer(playerid, 4);
                }
            }
        }
    }

    #if defined SAZO_OnPlayerDeath
        return SAZO_OnPlayerDeath(playerid, killerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDeath
    #undef OnPlayerDeath
#else
    #define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath SAZO_OnPlayerDeath
#if defined SAZO_OnPlayerDeath
    forward SAZO_OnPlayerDeath(playerid, killerid, reason);
#endif