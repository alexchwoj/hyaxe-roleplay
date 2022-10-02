#if defined _weapons_callbacks_
    #endinput
#endif
#define _weapons_callbacks_

public OnPlayerSpawn(playerid)
{
    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 40);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 500);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 200);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 200);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 200);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 200);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 50);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 250);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 200);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 200);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 300);

    #if defined WP_OnPlayerSpawn
        return WP_OnPlayerSpawn(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerSpawn
    #undef OnPlayerSpawn
#else
    #define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn WP_OnPlayerSpawn
#if defined WP_OnPlayerSpawn
    forward WP_OnPlayerSpawn(playerid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    for(new i; i < sizeof(g_rgiPlayerWeapons[]); ++i)
        g_rgiPlayerWeapons[playerid][i] = 0;
        
    #if defined WP_OnPlayerDisconnect
        return WP_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect WP_OnPlayerDisconnect
#if defined WP_OnPlayerDisconnect
    forward WP_OnPlayerDisconnect(playerid, reason);
#endif