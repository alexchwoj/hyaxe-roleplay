#if defined _hookers_callbacks_
    #endinput
#endif
#define _hookers_callbacks_

#include <YSI_Coding/y_hooks>

hook OnGameModeInit()
{
    for(new i = HYAXE_MAX_HOOKERS - 1; i != -1; --i)
    {
        new name[16];
        format(name, sizeof(name), "__Hooker_%i__", i);
        g_rgiHookers[i] = FCNPC_Create(name);
        g_rgiHookerAreas[i] = CreateDynamicCircle(g_rgfHookerPos[i][0], g_rgfHookerPos[i][1], 5.0, .worldid = 0, .interiorid = 0);
        AttachDynamicAreaToPlayer(g_rgiHookerAreas[i], g_rgiHookers[i]);
        Streamer_SetIntData(STREAMER_TYPE_AREA, g_rgiHookerAreas[i], E_STREAMER_CUSTOM(0x57484F52), i);
        Key_Alert(g_rgfHookerPos[i][0], g_rgfHookerPos[i][1], g_rgfHookerPos[i][2], 5.0, KEYNAME_CTRL_BACK, .attachedplayer = g_rgiHookers[i]);
        
        Hooker_Spawn(i);
    }

    return 1;
}

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
    new const player_state = GetPlayerState(playerid);
    if((player_state == PLAYER_STATE_ONFOOT && (newkeys & KEY_CTRL_BACK) != 0) || (player_state == PLAYER_STATE_DRIVER && (newkeys & KEY_CROUCH) != 0))
    {
        if(IsPlayerInAnyDynamicArea(playerid))
        {
            GetPlayerDynamicAreas(playerid, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH);
            for(new i; YSI_UNSAFE_HUGE_STRING[i] != INVALID_STREAMER_ID; ++i)
            {
                new areaid = YSI_UNSAFE_HUGE_STRING[i];
                if(Streamer_HasIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x57484F52)))
                {
                    new hookerid = Streamer_GetIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x57484F52));
                    DEBUG_PRINT("Player %i interacted with hooker %i", playerid, hookerid);

                    if(!g_rgbHookerAvailable{hookerid})
                        return 1;

                    DEBUG_PRINT("Hooker is available");

                    if(player_state == PLAYER_STATE_ONFOOT)
                    {
                        g_rgbHookerAvailable{hookerid} = false;
                        g_rgiPlayerInteractingHooker[playerid] = hookerid;
                        g_rgiHookerInteractingPlayer[hookerid] = playerid;

                        FCNPC_AimAtPlayer(g_rgiHookers[hookerid], playerid);
                        FCNPC_SetAnimationByName(g_rgiHookers[hookerid], "KISSING:GF_STREETARGUE_02", 4.1, 1, 0, 0, 0, 0);
                        Dialog_Show(playerid, "hooker_accept", DIALOG_STYLE_TABLIST_HEADERS, 
                                "Prostituta", 
                                    "{DADADA}Hablaste con la prostituta y te dio sus precios.\t \n\
                                    Beso\t{64A752}50${DADADA}\n\
                                    Mamada\t{64A752}200${DADADA}", 
                                "Veni mamucha", "Todas putas"
                        );
                    }
                    else if(player_state == PLAYER_STATE_DRIVER)
                    {
                        //PlayerPlaySound(playerid, 39073);
                        //FCNPC_EnterVehicle(g_rgiHookers[hookerid], GetPlayerVehicleID(playerid), 1);
                    }

                    return 1;
                }
            }
        }
    }
    else if((newkeys & KEY_YES) != 0)
    {
        if(g_rgiPlayerInteractingHooker[playerid] != INVALID_PLAYER_ID)
        {
            new hookerid = g_rgiPlayerInteractingHooker[playerid];
            if(g_rgiHookerPendingTask[hookerid] == HOOKER_WAIT_FOR_AREA)
            {
                KillTimer(g_rgiHookerUpdateTimer[hookerid]);
                g_rgiHookerUpdateTimer[hookerid] = 0;

                // TogglePlayerControllable(playerid, false);

                new Float:x, Float:y, Float:z, Float:angle;
                GetPlayerPos(playerid, x, y, z);
                GetPlayerFacingAngle(playerid, angle);

                x += (0.8 * floatsin(-angle, degrees));
                y += (0.8 * floatcos(-angle, degrees));

                FCNPC_AimAtPlayer(g_rgiHookers[hookerid], playerid);
                FCNPC_GoTo(g_rgiHookers[hookerid], x, y, z, FCNPC_MOVE_TYPE_WALK);
                g_rgiHookerPendingTask[hookerid] = HOOKER_BLOWJOB;

                ApplyAnimation(g_rgiHookerInteractingPlayer[hookerid], "BLOWJOBZ", "BJ_STAND_START_P", 4.1, 0, 0, 0, 1, 0);

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

dialog hooker_accept(playerid, response, listitem, inputtext[])
{
    new hookerid = g_rgiPlayerInteractingHooker[playerid];
    new npcid = g_rgiHookers[hookerid];

    FCNPC_ResetAnimation(npcid);
    FCNPC_ClearAnimations(npcid);
    FCNPC_Stop(npcid);

    if(!response)
    {
        FCNPC_StopAim(g_rgiHookers[hookerid]);
        g_rgbHookerAvailable{hookerid} = true;

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

    switch(listitem)
    {
        case 0:
        {
            Player_GiveMoney(playerid, -50);

            new Float:x, Float:y, Float:z, Float:angle;
            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, angle);

            x += (0.9 * floatsin(-angle, degrees));
            y += (0.9 * floatcos(-angle, degrees));

            FCNPC_GoTo(npcid, x, y, z, FCNPC_MOVE_TYPE_WALK);
            TogglePlayerControllable(playerid, false);
            g_rgiHookerPendingTask[hookerid] = HOOKER_KISS_ONFOOT;
            ApplyAnimation(playerid, "KISSING", "null", 4.1, 0, 0, 0, 0, 0, 0);
        }
        case 1:
        {
            FCNPC_StopAim(g_rgiHookers[hookerid]);
            g_rgiHookerPendingTask[hookerid] = HOOKER_WAIT_FOR_AREA;
            g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_Update", 750, true, "i", hookerid);
            FCNPC_ResetAnimation(npcid);

            Notification_Show(playerid, "La prostituta te seguirá a un lugar alejado. Usa ~r~Y~w~ para empezar. Si lo haces en un lugar público podras ser multado por obscenidad.", 8000);
            FCNPC_ApplyAnimation(g_rgiHookers[hookerid], "BLOWJOBZ", "null", 4.1, 0, 0, 0, 0, 0);
            FCNPC_ApplyAnimation(g_rgiHookers[hookerid], "KISSING", "null", 4.1, 0, 0, 0, 0, 0);
            ApplyAnimation(playerid, "BLOWJOBZ", "null", 4.1, 0, 0, 0, 0, 0, 0);
            ApplyAnimation(playerid, "FOOD", "null", 4.1, 0, 0, 0, 0, 0, 0);
            ApplyAnimation(playerid, "KISSING", "null", 4.1, 0, 0, 0, 0, 0, 0);
        }
    }

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
            TogglePlayerControllable(playerid, true);

            FCNPC_AimAtPlayer(npcid, playerid);
            FCNPC_ApplyAnimation(npcid, "KISSING", "GRLFRD_KISS_03", 4.0, 0, 0, 0, 0, -1);
            ApplyAnimation(playerid, "KISSING", "PLAYA_KISS_03", 4.1, false, false, false, true, 0, 1);

            SetTimerEx("HOOKER_KissingDone", 5500, false, "ii", playerid, hookerid);
        }
        else if(g_rgiHookerPendingTask[hookerid] == HOOKER_WALK_BACK_TO_SITE)
        {
            FCNPC_SetAngle(npcid, g_rgfHookerPos[hookerid][3]);
            FCNPC_SetAnimationByName(npcid, "BAR:BARCUSTOM_LOOP", 4.1, 1, 0, 0, 0, 0);
            g_rgiHookerPendingTask[hookerid] = HOOKER_NONE;
        }
        else if(g_rgiHookerPendingTask[hookerid] == HOOKER_BLOWJOB)
        {
            FCNPC_StopAim(g_rgiHookers[hookerid]);
            FCNPC_ApplyAnimation(npcid, "BLOWJOBZ", "BJ_STAND_START_W", 4.1, 0, 0, 0, 1, 0);
            g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_StartBlowing", 2000, false, "ii", hookerid, g_rgiHookerInteractingPlayer[hookerid]);
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
    ClearAnimations(playerid);

    FCNPC_StopAim(g_rgiHookers[hookerid]);
    FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
    g_rgiHookerPendingTask[hookerid] = HOOKER_WALK_BACK_TO_SITE;

    g_rgiHookerInteractingPlayer[hookerid] = 
    g_rgiPlayerInteractingHooker[playerid] = INVALID_PLAYER_ID;

    return 1;
}

forward HOOKER_Update(hookerid);
public HOOKER_Update(hookerid)
{
    new npcid = g_rgiHookers[hookerid];

    if(g_rgiHookerPendingTask[hookerid] == HOOKER_WAIT_FOR_AREA)
    {
        new playerid = g_rgiHookerInteractingPlayer[hookerid];
        FCNPC_GoToPlayer(npcid, playerid, .pathfinding = FCNPC_MOVE_PATHFINDING_RAYCAST);
    }

    return 1;
}

forward HOOKER_StartBlowing(hookerid, playerid);
public HOOKER_StartBlowing(hookerid, playerid)
{
    FCNPC_ApplyAnimation(g_rgiHookers[hookerid], "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.1, 1, 0, 0, 1, 0);
    ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 1, 0, 0, 1, 0);
    g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_FinishBlowing", Random(15000, 30000), false, "ii", hookerid, playerid);
    return 1;
}

forward HOOKER_FinishBlowing(hookerid, playerid);
public HOOKER_FinishBlowing(hookerid, playerid)
{
    FCNPC_ApplyAnimation(g_rgiHookers[hookerid], "BLOWJOBZ", "BJ_STAND_END_W", 4.1, 0, 0, 0, 1, 0);
    ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_P", 4.1, 0, 0, 0, 1, 0);
    g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_FinishBlowingAnim", 4000, false, "ii", hookerid, playerid);
    return 1;
}

forward HOOKER_FinishBlowingAnim(hookerid, playerid);
public HOOKER_FinishBlowingAnim(hookerid, playerid)
{
    new bool:kiss = (random(100) % 2) == 0;
    
    if(kiss)
    {
        FCNPC_ApplyAnimation(g_rgiHookers[hookerid], "KISSING", "GRLFRD_KISS_02", 4.1, 0, 0, 0, 0, 0);
        ApplyAnimation(playerid, "KISSING", "PLAYA_KISS_02", 4.1, 0, 0, 0, 1, 0);
        g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_BlowingEnd", 6000, false, "ii", hookerid, playerid);
    }
    else
    {
        ClearAnimations(playerid);
        
        g_rgbHookerAvailable{hookerid} = true;
        FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
        g_rgiHookerPendingTask[hookerid] = HOOKER_WALK_BACK_TO_SITE;

        g_rgiHookerInteractingPlayer[hookerid] = 
        g_rgiPlayerInteractingHooker[playerid] = INVALID_PLAYER_ID;
        g_rgiHookerUpdateTimer[hookerid] = 0;

        // TogglePlayerControllable(playerid, true);
    }

    return 1;
}

forward HOOKER_BlowingEnd(hookerid, playerid);
public HOOKER_BlowingEnd(hookerid, playerid)
{
    Player_Puke(playerid);
    FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
    g_rgiHookerPendingTask[hookerid] = HOOKER_WALK_BACK_TO_SITE;

    g_rgiHookerInteractingPlayer[hookerid] = 
    g_rgiPlayerInteractingHooker[playerid] = INVALID_PLAYER_ID;
    g_rgiHookerUpdateTimer[hookerid] = 0;
    g_rgbHookerAvailable{hookerid} = true;

    return 1;
}