#if defined _death_callbacks_
    #endinput
#endif
#define _death_callbacks_

public OnPlayerDeath(playerid, killerid, reason)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_IN_GAME))
    {
        GetPlayerPos(playerid, g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ]);
        GetPlayerFacingAngle(playerid, g_rgePlayerData[playerid][e_fPosAngle]);
        SetSpawnInfo(playerid, NO_TEAM, Player_Skin(playerid), g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ], g_rgePlayerData[playerid][e_fPosAngle], 0, 0, 0, 0, 0, 0);
            
        SpawnPlayer(playerid);
        TogglePlayerSpectating(playerid, true);
        TogglePlayerSpectating(playerid, false);

        RemovePlayerFromVehicle(playerid);
        Player_SetPos(playerid, g_rgePlayerData[playerid][e_fPosX], g_rgePlayerData[playerid][e_fPosY], g_rgePlayerData[playerid][e_fPosZ]);
        SetCameraBehindPlayer(playerid);

        ApplyAnimation(playerid, "SWEET", "null", 4.0, 0, 0, 0, 0, 0, 1);

        if (Bit_Get(Player_Flags(playerid), PFLAG_INJURED))
        {
            ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0);
            
            KillTimer(g_rgiPlayerCorpseTimer[playerid]);
            DestroyDynamicActor(g_rgiPlayerCorpseActor[playerid]);

            g_rgiPlayerCorpseActor[playerid] = CreateDynamicActor(
                Player_Skin(playerid),
                g_rgePlayerData[playerid][e_fPosX],
                g_rgePlayerData[playerid][e_fPosY],
                g_rgePlayerData[playerid][e_fPosZ],
                g_rgePlayerData[playerid][e_fPosAngle],
                .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)
            );
            ApplyDynamicActorAnimation(g_rgiPlayerCorpseActor[playerid], "WUZI", "CS_Dead_Guy", 4.1, 0, 0, 0, 1, 0);
            g_rgiPlayerCorpseTimer[playerid] = SetTimerEx("DEATH_DeleteCorpse", 30000, false, "i", playerid);
            
            Player_SetHealth(playerid, 4);
            Bit_Set(Player_Flags(playerid), PFLAG_INJURED, false);

            KillTimer(g_rgeCrawlData[playerid][e_iCrawlKeyTimer]);
            Player_GoToTheNearestHospital(playerid);
        }
        else
        {
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            Sound_PlayInRange(
                1136,
                15.0, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)
            );

            Player_SetHealth(playerid, 100);
            Bit_Set(Player_Flags(playerid), PFLAG_INJURED, true);

            ApplyAnimation(playerid, "SWEET", "SWEET_INJUREDLOOP", 4.1, true, false, false, 1, 0, 1);
            KillTimer(g_rgeCrawlData[playerid][e_iCrawlKeyTimer]);
            g_rgeCrawlData[playerid][e_iCrawlKeyTimer] = SetTimerEx("CRAWL_ProcessKey", 200, true, "i", playerid);
        }
    }

    #if defined CRAWL_OnPlayerDeath
        return CRAWL_OnPlayerDeath(playerid, killerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDeath
    #undef OnPlayerDeath
#else
    #define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath CRAWL_OnPlayerDeath
#if defined CRAWL_OnPlayerDeath
    forward CRAWL_OnPlayerDeath(playerid, killerid, reason);
#endif

forward DEATH_DeleteCorpse(playerid);
public DEATH_DeleteCorpse(playerid)
{
    new Float:x, Float:y, Float:z;
    GetDynamicActorPos(g_rgiPlayerCorpseActor[playerid], x, y, z);

    new amount = 1 + random(3);
    if (Skin_IsFat( Player_Skin(playerid) ))
        amount += 4;

    for(new i; i < amount; ++i)
    {
        DroppedItem_Create(ITEM_MEAT, 1, 0, x + math_random_float(-1.0, 1.0), y + math_random_float(-1.0, 1.0), z, GetDynamicActorVirtualWorld(g_rgiPlayerCorpseActor[playerid]), 0, playerid);
    }

    DestroyDynamicActor(g_rgiPlayerCorpseActor[playerid]);
    return 1;
}

forward CRAWL_ProcessKey(playerid);
public CRAWL_ProcessKey(playerid)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_INJURED) && !g_rgeCrawlData[playerid][e_bCrawlAnim])
    {
        new Keys, ud, lr;
        GetPlayerKeys(playerid, Keys, ud, lr);

        if (ud == KEY_UP)
        {
            g_rgeCrawlData[playerid][e_bCrawlAnim] = true;
            ApplyAnimation(playerid, "PED", "CAR_CRAWLOUTRHS", 4.1, false, true, true, false, 500, false);
            SetPlayerFacingAngle(playerid, CameraLookToAngle(playerid) + 90.0);

            SetTimerEx("CRAWL_StopAnimation", 400, false, "i", playerid);
        }
    }

    return 1;
}

forward CRAWL_StopAnimation(playerid);
public CRAWL_StopAnimation(playerid)
{
    g_rgeCrawlData[playerid][e_bCrawlAnim] = false;
    
    ApplyAnimation(playerid, "SWEET", "SWEET_INJUREDLOOP", 4.1, true, false, false, 1, 0, 1);
    SetPlayerFacingAngle(playerid, CameraLookToAngle(playerid));
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(g_rgiPlayerCorpseTimer[playerid]);
    DestroyDynamicActor(g_rgiPlayerCorpseActor[playerid]);
    KillTimer(g_rgeCrawlData[playerid][e_iCrawlKeyTimer]);
    g_rgeCrawlData[playerid] = g_rgeCrawlData[MAX_PLAYERS];

    #if defined CRAWL_OnPlayerDisconnect
        return CRAWL_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect CRAWL_OnPlayerDisconnect
#if defined CRAWL_OnPlayerDisconnect
    forward CRAWL_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_INJURED))
    {
        new Float:x, Float:y, Float:z;
	    GetPlayerPos(playerid, x, y, z);
	    SetPlayerPos(playerid, x, y, z);
	    ApplyAnimation(playerid, "SWEET", "SWEET_INJUREDLOOP", 4.1, true, false, false, 1, 0, 1);
    }

    #if defined CRAWL_OnPlayerEnterVehicle
        return CRAWL_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterVehicle
    #undef OnPlayerEnterVehicle
#else
    #define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle CRAWL_OnPlayerEnterVehicle
#if defined CRAWL_OnPlayerEnterVehicle
    forward CRAWL_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
#endif
