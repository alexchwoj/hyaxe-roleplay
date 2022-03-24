#if defined _hookers_callbacks_
    #endinput
#endif
#define _hookers_callbacks_

public OnGameModeInit()
{    
    for(new i = HYAXE_MAX_HOOKERS - 1; i != -1; --i)
    {
        g_rgiHookers[i] = FCNPC_Create_s(Str_Random(24));
        
        g_rgiHookerAreas[i] = CreateDynamicCircle(g_rgfHookerPos[i][0], g_rgfHookerPos[i][1], 5.0, .worldid = 0, .interiorid = 0);
        AttachDynamicAreaToPlayer(g_rgiHookerAreas[i], g_rgiHookers[i]);
        new info[2] = { 0x57484F52 }; // WHOR
        info[1] = i;
        Streamer_SetArrayData(STREAMER_TYPE_AREA, g_rgiHookerAreas[i], E_STREAMER_EXTRA_ID, info);
        
        Hooker_Spawn(i);
    }

    #if defined HOOKERS_OnGameModeInit
        return HOOKERS_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit HOOKERS_OnGameModeInit
#if defined HOOKERS_OnGameModeInit
    forward HOOKERS_OnGameModeInit();
#endif

public OnGameModeExit()
{
    for(new i = HYAXE_MAX_HOOKERS - 1; i != -1; --i)
    {
        if(FCNPC_IsValid(g_rgiHookers[i]))
        {
            FCNPC_Destroy(g_rgiHookers[i]);
        }
    }

    #if defined HOOKERS_OnGameModeExit
        return HOOKERS_OnGameModeExit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeExit
    #undef OnGameModeExit
#else
    #define _ALS_OnGameModeExit
#endif
#define OnGameModeExit HOOKERS_OnGameModeExit
#if defined HOOKERS_OnGameModeExit
    forward HOOKERS_OnGameModeExit();
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_CTRL_BACK) != 0)
    {
        if(IsPlayerInAnyDynamicArea(playerid))
        {
            new List:areas = GetPlayerAllDynamicAreas(playerid);
            for_list(i : areas)
            {
                new areaid = iter_get(i);
                new info[2];
                Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, info);

                if(info[0] != 0x57484F52)
                    continue;

                new hookerid = info[1];

                if(!g_rgbHookerAvailable{hookerid})
                    return 1;

                g_rgiPlayerInteractingHooker[playerid] = hookerid;

                if(!IsPlayerInAnyVehicle(playerid))
                {
                    FCNPC_AimAtPlayer(g_rgiHookers[hookerid], playerid);
                    FCNPC_SetAnimationByName(g_rgiHookers[hookerid], "KISSING:GF_STREETARGUE_02", 4.1, 1, 0, 0, 0, 0);
                    Dialog_Show(playerid, "hooker_kiss", DIALOG_STYLE_MSGBOX, "Prostituta", "{DADADA}La prostituta te ofrecio darte un beso por {64A752}50${DADADA}.", "Veni mamucha", "Todas putas");
                }
                else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
                {

                }

                return 1;
            }
        }
    }

    #if defined HOOKERS_OnPlayerKeyStateChange
        return HOOKERS_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange HOOKERS_OnPlayerKeyStateChange
#if defined HOOKERS_OnPlayerKeyStateChange
    forward HOOKERS_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

dialog hooker_kiss(playerid, response, listitem, inputtext[])
{
    new hookerid = g_rgiPlayerInteractingHooker[playerid];
    new npcid = g_rgiHookers[hookerid];

    FCNPC_ResetAnimation(npcid);
    FCNPC_Stop(npcid);

    if(!response)
    {
        FCNPC_StopAim(g_rgiHookers[hookerid]);

        if(g_rgiHookerPendingTask[hookerid] == HOOKER_WALK_BACK_TO_SITE)
        {
            FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
        }
        else
        {
            FCNPC_SetAngle(npcid, g_rgfHookerPos[hookerid][3]);
            FCNPC_SetAnimationByName(npcid, "BAR:BARCUSTOM_LOOP", 4.1, 1, 0, 0, 0, 0);
        }

        g_rgiPlayerInteractingHooker[playerid] = INVALID_PLAYER_ID;
        
        return 1;
    }

    g_rgbHookerAvailable{hookerid} = false;
    Player_GiveMoney(playerid, -50);

    new Float:x, Float:y, Float:z, Float:angle;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);

    x += (0.8 * floatsin(-angle, degrees));
    y += (0.8 * floatcos(-angle, degrees));

    FCNPC_GoTo(npcid, x, y, z, FCNPC_MOVE_TYPE_WALK);
    TogglePlayerControllable(playerid, false);
    g_rgiHookerPendingTask[hookerid] = HOOKER_KISS_ONFOOT;
    g_rgiHookerInteractingPlayer[hookerid] = playerid;
    ApplyAnimation(playerid, "KISSING", "null", 4.1, 0, 0, 0, 0, 0, 0);

    return 1;
}

public FCNPC_OnReachDestination(npcid)
{
    new hookerid = binary_search(g_rgiHookers, npcid);
    if(hookerid != -1)
    {
        if(g_rgiHookerPendingTask[hookerid] == HOOKER_KISS_ONFOOT)
        {
            new playerid = g_rgiHookerInteractingPlayer[hookerid];

            FCNPC_AimAtPlayer(npcid, playerid);
            FCNPC_ApplyAnimation(npcid, "KISSING", "GRLFRD_KISS_03", 4.0, 0, 0, 0, 0, -1);
            ApplyAnimation(playerid, "KISSING", "PLAYA_KISS_03", 4.1, false, false, false, false, 0, 1);

            SetTimerEx("HOOKER_KissingDone", 8000, false, "ii", playerid, hookerid);
        }
        else if(g_rgiHookerPendingTask[hookerid] == HOOKER_WALK_BACK_TO_SITE)
        {
            FCNPC_SetAngle(npcid, g_rgfHookerPos[hookerid][3]);
            FCNPC_SetAnimationByName(npcid, "BAR:BARCUSTOM_LOOP", 4.1, 1, 0, 0, 0, 0);
            g_rgiHookerPendingTask[hookerid] = HOOKER_NONE;
        }
    }

    #if defined HKRS_FCNPC_OnReachDestination
        return HKRS_FCNPC_OnReachDestination(npcid);
    #else
        return 1;
    #endif
}

#if defined _ALS_FCNPC_OnReachDestination
    #undef FCNPC_OnReachDestination
#else
    #define _ALS_FCNPC_OnReachDestination
#endif
#define FCNPC_OnReachDestination HKRS_FCNPC_OnReachDestination
#if defined HKRS_FCNPC_OnReachDestination
    forward HKRS_FCNPC_OnReachDestination(npcid);
#endif

forward HOOKER_KissingDone(playerid, hookerid);
public HOOKER_KissingDone(playerid, hookerid)
{
    g_rgbHookerAvailable{hookerid} = true;
    TogglePlayerControllable(playerid, true);

    FCNPC_StopAim(g_rgiHookers[hookerid]);
    FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
    g_rgiHookerPendingTask[hookerid] = HOOKER_WALK_BACK_TO_SITE;

    g_rgiHookerInteractingPlayer[hookerid] = INVALID_PLAYER_ID;
    g_rgiPlayerInteractingHooker[playerid] = INVALID_PLAYER_ID;

    return 1;
}