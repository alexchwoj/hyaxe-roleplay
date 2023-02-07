#if defined _hookers_callbacks_
    #endinput
#endif
#define _hookers_callbacks_

static Hooker_OnKeyPress(playerid, hookerid)
{
    if (g_rgeHookerTasks[hookerid] != HOOKER_TASK_IDLE)
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Esta prostituta no está disponible");
        return 1;
    }

    if (g_rgiPlayerHooker[playerid] != INVALID_HOOKER_ID)
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Ya estás interactuando con otra prostituta");
        return 1;
    }

    new hookernpcid = g_rgiHookers[hookerid];
    FCNPC_SetAngleToPlayer(hookernpcid, playerid);
    FCNPC_AimAtPlayer(hookernpcid, playerid);
    FCNPC_ApplyAnimation(hookernpcid, "PED", "FACTALK", 4.1, 1, 0, 0, 0, 0);

    g_rgiHookerCustomer[hookerid] = playerid;
    g_rgiPlayerHooker[playerid] = hookerid;
    g_rgeHookerTasks[hookerid] = HOOKER_TASK_WAIT_FOR_CUSTOMER;

    inline const Response(response, listitem, string:inputtext[])
    {
        #pragma unused inputtext

        if (!response)
        {
            g_rgiHookerCustomer[hookerid] = INVALID_PLAYER_ID;
            g_rgiPlayerHooker[playerid] = INVALID_HOOKER_ID;
            g_rgeHookerTasks[hookerid] = HOOKER_TASK_IDLE;

            FCNPC_StopAim(hookernpcid);
            FCNPC_SetAngle(hookernpcid, g_rgfHookerPos[hookerid][3]);
            FCNPC_SetAnimationByName(hookernpcid, "PED:FACGUM", 4.1, true, false, false, false, 0);

            return 1;
        }

        switch (listitem)
        {
            case 0:
            {
                if (Player_Money(playerid) < 50)
                {
                    SetPlayerChatBubbleForPlayer(playerid, hookernpcid, "Salí, pobretón", 0xDADADFF, 10.0, 5000);
                    Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes dinero suficiente");

                    inline const Due()
                    {
                        FCNPC_StopAim(hookernpcid);
                        FCNPC_SetAngle(hookernpcid, g_rgfHookerPos[hookerid][3]);
                        FCNPC_SetAnimationByName(hookernpcid, "PED:FACGUM", 4.1, true, false, false, false, 0);
                    }
                    Timer_CreateCallback(using inline Due, 5000, 1);

                    return 1;
                }

                Player_GiveMoney(playerid, -50);
                TogglePlayerControllable(playerid, false);

                g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_TO_FRONT_OF_PLY | HOOKER_TASK_KISS;

                new Float:x, Float:y, Float:z, Float:ang;
                GetPlayerPos(playerid, x, y, z);
                GetPlayerFacingAngle(playerid, ang);

                new Float:add_x, Float:add_y;
                GetXYFromAngle(add_x, add_y, ang, 0.9);
                x += add_x;
                y += add_y;

                FCNPC_GoTo(hookernpcid, x, y, z, FCNPC_MOVE_TYPE_WALK);
            }
            case 1:
            {
                if (Player_Money(playerid) < 200)
                {
                    SetPlayerChatBubbleForPlayer(playerid, hookernpcid, "Salí, pobretón", 0xDADADFF, 10.0, 5000);
                    Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes dinero suficiente");

                    inline const Due()
                    {
                        FCNPC_StopAim(hookernpcid);
                        FCNPC_SetAngle(hookernpcid, g_rgfHookerPos[hookerid][3]);
                        FCNPC_SetAnimationByName(hookernpcid, "PED:FACGUM", 4.1, true, false, false, false, 0);
                    }
                    Timer_CreateCallback(using inline Due, 5000, 1);

                    return 1;
                }

                g_rgeHookerTasks[hookerid] = HOOKER_TASK_FOLLOW_PLAYER | HOOKER_TASK_BLOWJOB;

                Notification_Show(playerid, "La prostituta te seguirá a un lugar alejado. Usa ~r~Y~w~ para empezar. Si lo haces en un lugar público podras ser multado por obscenidad.", 10000);
                FCNPC_ApplyAnimation(hookernpcid, "BLOWJOBZ", "null", 4.1, 0, 0, 0, 0, 0);
                FCNPC_ApplyAnimation(hookernpcid, "KISSING", "null", 4.1, 0, 0, 0, 0, 0);
                ApplyAnimation(playerid, "BLOWJOBZ", "null", 4.1, 0, 0, 0, 0, 0, 0);
                ApplyAnimation(playerid, "FOOD", "null", 4.1, 0, 0, 0, 0, 0, 0);

                FCNPC_ResetAnimation(hookernpcid);
                g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_MoveInFrontOfPlayer", 1000, true, "ii", hookernpcid, playerid);
            }
        }

        FCNPC_ApplyAnimation(hookernpcid, "KISSING", "null", 4.1, 0, 0, 0, 0, 0);
        ApplyAnimation(playerid, "KISSING", "null", 4.1, 0, 0, 0, 0, 0, 0);
    }
    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}Prostituta", "{DADADA}Hablaste con la prostituta y te dio sus precios.\t \n{DADADA}Beso\t{64A752}50$\n{DADADA}Mamada\t{64A752}200$", "Veni mamucha", "Todas putas");
}

public OnScriptInit()
{
    for (new i; i < HYAXE_MAX_HOOKERS; ++i)
    {
        new name[25];
        Str_Random(name, 24);
        g_rgiHookers[i] = FCNPC_Create(name);
        Iter_Add(Hookers, g_rgiHookers[i]);
        g_rgeHookerTasks[i] = HOOKER_TASK_IDLE;

        printf("[hookers] Spawning hooker %d", g_rgiHookers[i]);
        FCNPC_SetInvulnerable(g_rgiHookers[i], true);
        FCNPC_Spawn(g_rgiHookers[i], g_rgiHookerSkins[random(sizeof(g_rgiHookerSkins))], g_rgfHookerPos[i][0], g_rgfHookerPos[i][1], g_rgfHookerPos[i][2]);
        FCNPC_SetAngle(g_rgiHookers[i], g_rgfHookerPos[i][3]);
        FCNPC_SetInterior(g_rgiHookers[i], 0);
        FCNPC_SetVirtualWorld(g_rgiHookers[i], 0);
        FCNPC_SetAnimationByName(g_rgiHookers[i], "PED:FACGUM", 4.1, true, false, false, false, 0);

        Key_Alert(g_rgfHookerPos[i][0], g_rgfHookerPos[i][1], g_rgfHookerPos[i][2], 3.0, KEYNAME_YES, 0, 0, KEY_TYPE_FOOT, g_rgiHookers[i], __addressof(Hooker_OnKeyPress), i);
    }

    #if defined HOOKERS_OnScriptInit
        return HOOKERS_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit HOOKERS_OnScriptInit
#if defined HOOKERS_OnScriptInit
    forward HOOKERS_OnScriptInit();
#endif

public FCNPC_OnReachDestination(npcid)
{
    new const hookerid = Hooker_FindIdxFromPlayerId(npcid);
    if (hookerid != INVALID_HOOKER_ID)
    {
        new const playerid = g_rgiHookerCustomer[hookerid];

        if (_:(g_rgeHookerTasks[hookerid] & HOOKER_TASK_GO_TO_FRONT_OF_PLY) != 0)
        {
            FCNPC_SetAngleToPlayer(npcid, g_rgiHookerCustomer[hookerid]);
            g_rgeHookerTasks[hookerid] &= ~HOOKER_TASK_GO_TO_FRONT_OF_PLY;
        }

        switch (g_rgeHookerTasks[hookerid])
        {
            case HOOKER_TASK_KISS:
            {
                FCNPC_ApplyAnimation(npcid, "KISSING", "GRLFRD_KISS_03", 4.0, 0, 0, 0, 0, -1);
                ApplyAnimation(playerid, "KISSING", "PLAYA_KISS_03", 4.1, 0, 0, 0, 1, 0, 1);
                
                inline const Due()
                {
                    ClearAnimations(playerid);
                    TogglePlayerControllable(playerid, true);

                    g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_BACK_TO_SPOT;
                    g_rgiHookerCustomer[hookerid] = INVALID_PLAYER_ID;
                    g_rgiPlayerHooker[playerid] = INVALID_HOOKER_ID;

                    FCNPC_StopAim(npcid);
                    FCNPC_GoTo(npcid, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2], FCNPC_MOVE_TYPE_WALK);
                }
                Timer_CreateCallback(using inline Due, 5500, 1);
            }
            case HOOKER_TASK_GO_BACK_TO_SPOT:
            {
                g_rgeHookerTasks[hookerid] = HOOKER_TASK_IDLE;
                FCNPC_SetAngle(npcid, g_rgfHookerPos[hookerid][3]);
            }
            case HOOKER_TASK_BLOWJOB:
            {
                Player_GiveMoney(playerid, -200);
                
                FCNPC_SetAngleToPlayer(npcid, playerid); // just in case
                FCNPC_ApplyAnimation(npcid, "BLOWJOBZ", "BJ_STAND_START_W", 4.1, 0, 0, 0, 1, 0);
                g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_StartBlowing", 2000, false, "ii", hookerid, playerid);

                ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_START_P", 4.1, 0, 0, 0, 1, 0);
            }
        }
    }

    #if defined HOOKER_FCNPC_OnReachDestination
        return HOOKER_FCNPC_OnReachDestination(npcid);
    #else
        return 1;
    #endif
}

#if defined _ALS_FCNPC_OnReachDestination
    #undef FCNPC_OnReachDestination
#else
    #define _ALS_FCNPC_OnReachDestination
#endif
#define FCNPC_OnReachDestination HOOKER_FCNPC_OnReachDestination
#if defined HOOKER_FCNPC_OnReachDestination
    forward HOOKER_FCNPC_OnReachDestination(npcid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    if (g_rgiPlayerHooker[playerid] != INVALID_HOOKER_ID)
    {
        new const hookerid = g_rgiPlayerHooker[playerid];

        if (g_rgiHookerUpdateTimer[hookerid])
        {
            KillTimer(g_rgiHookerUpdateTimer[hookerid]);
            g_rgiHookerUpdateTimer[hookerid] = 0;
        }

        g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_BACK_TO_SPOT;
        FCNPC_Stop(g_rgiHookers[hookerid]);
        FCNPC_StopAim(g_rgiHookers[hookerid]);
        FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2], FCNPC_MOVE_TYPE_WALK);

        g_rgiHookerCustomer[hookerid] = INVALID_PLAYER_ID;
        g_rgiPlayerHooker[playerid] = INVALID_HOOKER_ID;
    }

    #if defined HOOKER_OnPlayerDisconnect
        return HOOKER_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect HOOKER_OnPlayerDisconnect
#if defined HOOKER_OnPlayerDisconnect
    forward HOOKER_OnPlayerDisconnect(playerid, reason);
#endif

forward HOOKER_MoveInFrontOfPlayer(hookernpcid, playerid);
public HOOKER_MoveInFrontOfPlayer(hookernpcid, playerid)
{
    FCNPC_GoToPlayer(hookernpcid, playerid, FCNPC_MOVE_TYPE_RUN, .min_distance = 2.0);
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_YES) != 0)
    {
        new const hookerid = g_rgiPlayerHooker[playerid];
        if (hookerid != INVALID_HOOKER_ID && g_rgeHookerTasks[hookerid] == HOOKER_TASK_FOLLOW_PLAYER | HOOKER_TASK_BLOWJOB)
        {
            KillTimer(g_rgiHookerUpdateTimer[hookerid]);
            g_rgiHookerUpdateTimer[hookerid] = 0;

            new const hookernpcid = g_rgiHookers[hookerid];
            g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_TO_FRONT_OF_PLY | HOOKER_TASK_BLOWJOB;
            Hooker_WalkToFrontOfPlayer(hookernpcid, playerid);

            TogglePlayerControllable(playerid, false);
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
    ClearAnimations(playerid);
    TogglePlayerControllable(playerid, true);

    FCNPC_StopAim(g_rgiHookers[hookerid]);
    FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
    g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_BACK_TO_SPOT;
    g_rgiHookerCustomer[hookerid] = INVALID_PLAYER_ID;
    g_rgiPlayerHooker[playerid] = INVALID_HOOKER_ID;
    g_rgiHookerUpdateTimer[hookerid] = 0;

    return 1;
}