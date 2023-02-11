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
                    SetPlayerChatBubbleForPlayer(playerid, hookernpcid, "Salí, pobretón", 0xDADADAFF, 10.0, 5000);
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
                    SetPlayerChatBubbleForPlayer(playerid, hookernpcid, "Salí, pobretón", 0xDADADAFF, 10.0, 5000);
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

static HookerVehicle_OnKeyPress(playerid, hookerid)
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

    new const vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid)
        return 1;

    new Float:x, Float:y, Float:z;
    GetVehicleVelocity(vehicleid, x, y, z);
    if (x + y + z != 0.0)
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "El vehículo no puede estar en movimiento");
        return 1;
    }

    new const hookernpcid = g_rgiHookers[hookerid];

    if (!Hooker_CanGetInVehicle(GetVehicleModel(vehicleid)))
    {
        SetPlayerChatBubbleForPlayer(playerid, hookernpcid, "No voy a subirme en esa cagada.", 0xDADADAFF, 10.0, 5000);
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No puedes subir prostitutas en este vehículo");
        return 1;
    }
    
    foreach (new i : VehiclePassenger[vehicleid])
    {
        if (GetPlayerVehicleSeat(i) == 1)
        {
            Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Ya hay un pasajero de copiloto");
            return 1;
        }
    }
    
    g_rgiHookerCustomer[hookerid] = playerid;
    g_rgiPlayerHooker[playerid] = hookerid;
    g_rgeHookerTasks[hookerid] = HOOKER_TASK_APPROACH_VEHICLE;

    GetVehiclePos(vehicleid, x, y, z);
    g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HKR_CheckForVehicleAvailability", 500, true, "iifff", hookerid, vehicleid, x, y, z);

    new Float:px, Float:py, Float:pz, Float:ang;
    GetVehicleZAngle(vehicleid, ang);

    // Right front seat pos
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, px, py, pz);
    x += (px + 0.5) * floatsin(-ang + 90.0, degrees) + (py * floatsin(-ang, degrees));
    y += (px + 0.5) * floatcos(-ang + 90.0, degrees) + (py * floatcos(-ang, degrees));

    FCNPC_ResetAnimation(hookernpcid);
    FCNPC_GoTo(hookernpcid, x, y, z, FCNPC_MOVE_TYPE_WALK);
    return 1;
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
        Key_Alert(g_rgfHookerPos[i][0], g_rgfHookerPos[i][1], g_rgfHookerPos[i][2], 5.0, KEYNAME_CROUCH, 0, 0, KEY_TYPE_VEHICLE, g_rgiHookers[i], __addressof(HookerVehicle_OnKeyPress), i);
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

                    if (!IsPlayerInRangeOfPoint(npcid, 50.0, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]))
                    {
                        g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_TeleportToSpot", 20000, false, "i", hookerid);
                    }
                }
                Timer_CreateCallback(using inline Due, 5500, 1);
            }
            case HOOKER_TASK_GO_BACK_TO_SPOT:
            {
                g_rgeHookerTasks[hookerid] = HOOKER_TASK_IDLE;
                FCNPC_SetAngle(npcid, g_rgfHookerPos[hookerid][3]);
                FCNPC_SetAnimationByName(npcid, "PED:FACGUM", 4.1, true, false, false, false, 0);
            }
            case HOOKER_TASK_BLOWJOB:
            {
                Player_GiveMoney(playerid, -200);
                
                FCNPC_SetAngleToPlayer(npcid, playerid); // just in case
                FCNPC_ApplyAnimation(npcid, "BLOWJOBZ", "BJ_STAND_START_W", 4.1, 0, 0, 0, 1, 0);
                g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_StartBlowing", 2000, false, "ii", hookerid, playerid);

                ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_START_P", 4.1, 0, 0, 0, 1, 0);
            }
            case HOOKER_TASK_APPROACH_VEHICLE:
            {
                FCNPC_SetAngleToPlayer(npcid, playerid);

                inline const Response(response, listitem, string:inputtext[])
                {
                    #pragma unused listitem, inputtext

                    if (!response)
                    {
                        g_rgiHookerCustomer[hookerid] = INVALID_PLAYER_ID;
                        g_rgiPlayerHooker[playerid] = INVALID_HOOKER_ID;
                        g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_BACK_TO_SPOT;

                        FCNPC_StopAim(npcid);
                        FCNPC_GoTo(npcid, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2], FCNPC_MOVE_TYPE_WALK);

                        return 1;
                    }
                    
                    if (Player_Money(playerid) < 300)
                    {
                        SetPlayerChatBubbleForPlayer(playerid, npcid, "Salí, pobretón", 0xDADADAFF, 10.0, 5000);
                        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes dinero suficiente");

                        g_rgiHookerCustomer[hookerid] = INVALID_PLAYER_ID;
                        g_rgiPlayerHooker[playerid] = INVALID_HOOKER_ID;
                        g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_BACK_TO_SPOT;

                        FCNPC_StopAim(npcid);
                        FCNPC_GoTo(npcid, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2], FCNPC_MOVE_TYPE_WALK);

                        return 1;
                    }

                    FCNPC_EnterVehicle(npcid, GetPlayerVehicleID(playerid), 1);
                }
                Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_MSGBOX, "{CB3126}Prostituta", "{DADADA}Hablaste con la prostituta y te ofrecio servicios sexuales por {64A752}300${DADADA}.", "Veni mamucha", "Todas putas");
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
        if (hookerid != INVALID_HOOKER_ID)
        {
            if (g_rgeHookerTasks[hookerid] == HOOKER_TASK_FOLLOW_PLAYER | HOOKER_TASK_BLOWJOB)
            {
                KillTimer(g_rgiHookerUpdateTimer[hookerid]);
                g_rgiHookerUpdateTimer[hookerid] = 0;

                new const hookernpcid = g_rgiHookers[hookerid];
                g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_TO_FRONT_OF_PLY | HOOKER_TASK_BLOWJOB;
                Hooker_WalkToFrontOfPlayer(hookernpcid, playerid);

                TogglePlayerControllable(playerid, false);
            }
            else if (g_rgeHookerTasks[hookerid] == HOOKER_TASK_WAIT_FOR_CUSTOMER | HOOKER_TASK_BLOWJOB_VEHICLE)
            {
                Player_GiveMoney(playerid, -300);

                new const hookernpcid = g_rgiHookers[hookerid];
                g_rgeHookerTasks[hookerid] = HOOKER_TASK_BLOWJOB_VEHICLE;

                TogglePlayerControllable(playerid, false);
                FCNPC_ApplyAnimation(hookernpcid, "BLOWJOBZ", "BJ_CAR_START_W", 4.1, 0, 0, 0, 1, 0);
                g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_StartBlowingInVehicle", 2000, false, "ii", hookerid, playerid);

                ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_START_P", 4.1, 0, 0, 0, 1, 0);
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

    if (!IsPlayerInRangeOfPoint(g_rgiHookers[hookerid], 50.0, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]))
    {
        g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_TeleportToSpot", 20000, false, "i", hookerid);
    }
    else
        g_rgiHookerUpdateTimer[hookerid] = 0;

    return 1;
}

forward HKR_CheckForVehicleAvailability(hookerid, vehicleid, Float:x, Float:y, Float:z);
public HKR_CheckForVehicleAvailability(hookerid, vehicleid, Float:x, Float:y, Float:z)
{
    if (GetPlayerVehicleID(g_rgiHookerCustomer[hookerid]) == vehicleid)
    {
        new Float:new_x, Float:new_y, Float:new_z;
        GetVehiclePos(vehicleid, new_x, new_y, new_z);
        if (floatabs(x - new_x) < 0.2 || floatabs(y - new_y) < 0.2 || floatabs(z - new_z) < 0.1)
        {
            return 1;
        }
    }

    if (g_rgiHookerUpdateTimer[hookerid])
    {
        KillTimer(g_rgiHookerUpdateTimer[hookerid]);
        g_rgiHookerUpdateTimer[hookerid] = 0;
    }

    Notification_ShowBeatingText(g_rgiHookerCustomer[hookerid], 3000, 0xED2B2B, 100, 255, "La prostituta se fue porque moviste el vehículo");

    g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_BACK_TO_SPOT;
    FCNPC_Stop(g_rgiHookers[hookerid]);
    FCNPC_StopAim(g_rgiHookers[hookerid]);
    FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2], FCNPC_MOVE_TYPE_WALK);

    g_rgiPlayerHooker[g_rgiHookerCustomer[hookerid]] = INVALID_HOOKER_ID;
    g_rgiHookerCustomer[hookerid] = INVALID_PLAYER_ID;

    return 1;
}

public FCNPC_OnVehicleEntryComplete(npcid, vehicleid, seatid)
{
    new const hookerid = Hooker_FindIdxFromPlayerId(npcid);
    if (hookerid != INVALID_HOOKER_ID)
    {
        g_rgeHookerTasks[hookerid] = HOOKER_TASK_WAIT_FOR_CUSTOMER | HOOKER_TASK_BLOWJOB_VEHICLE;
        KillTimer(g_rgiHookerUpdateTimer[hookerid]);
        g_rgiHookerUpdateTimer[hookerid] = 0;

        Notification_Show(g_rgiHookerCustomer[hookerid], "Lleva a la prostituta a un lugar alejado y presiona ~r~Y~w~ para llevar a cabo sus servicios. Si te bajas del vehículo, la prostituta se irá.", 5000);
    }

    #if defined HK_FCNPC_OnVehicleEntryComp
        return HK_FCNPC_OnVehicleEntryComp(npcid, vehicleid, seatid);
    #else
        return 1;
    #endif
}

#if defined _ALS_FCNPC_OnVehicleEntryComp
    #undef FCNPC_OnVehicleEntryComplete
#else
    #define _ALS_FCNPC_OnVehicleEntryComp
#endif
#define FCNPC_OnVehicleEntryComplete HK_FCNPC_OnVehicleEntryComp
#if defined HK_FCNPC_OnVehicleEntryComp
    forward HK_FCNPC_OnVehicleEntryComp(npcid, vehicleid, seatid);
#endif

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if (oldstate == PLAYER_STATE_DRIVER)
    {
        new const hookerid = g_rgiPlayerHooker[playerid];
        if (hookerid != INVALID_HOOKER_ID)
        {
            FCNPC_ExitVehicle(g_rgiHookers[hookerid]);
            FCNPC_StopAim(g_rgiHookers[hookerid]);
            FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
            g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_BACK_TO_SPOT;
            g_rgiHookerCustomer[hookerid] = INVALID_PLAYER_ID;
            g_rgiPlayerHooker[playerid] = INVALID_HOOKER_ID;

            if (!IsPlayerInRangeOfPoint(g_rgiHookers[hookerid], 50.0, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]))
            {
                g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_TeleportToSpot", 20000, false, "i", hookerid);
            }

            Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "La prostituta se fue porque te bajaste del vehículo");
        }
    }
    else if (newstate == PLAYER_STATE_DRIVER)
    {
        new const hookerid = g_rgiPlayerHooker[playerid];
        if (hookerid != INVALID_HOOKER_ID)
        {
            FCNPC_StopAim(g_rgiHookers[hookerid]);
            FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
            g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_BACK_TO_SPOT;
            g_rgiHookerCustomer[hookerid] = INVALID_PLAYER_ID;
            g_rgiPlayerHooker[playerid] = INVALID_HOOKER_ID;

            if (!IsPlayerInRangeOfPoint(g_rgiHookers[hookerid], 50.0, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]))
            {
                g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_TeleportToSpot", 20000, false, "i", hookerid);
            }

            Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "La prostituta se fue porque te subiste a un vehículo");
        }
    }

    #if defined HOOKER_OnPlayerStateChange
        return HOOKER_OnPlayerStateChange(playerid, newstate, oldstate);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange HOOKER_OnPlayerStateChange
#if defined HOOKER_OnPlayerStateChange
    forward HOOKER_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

forward HOOKER_StartBlowingInVehicle(hookerid, playerid);
public HOOKER_StartBlowingInVehicle(hookerid, playerid)
{
    FCNPC_ApplyAnimation(g_rgiHookers[hookerid], "BLOWJOBZ", "BJ_CAR_LOOP_W", 4.1, 1, 0, 0, 1, 0);
    ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_LOOP_P", 4.1, 1, 0, 0, 1, 0);
    g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_FinishBlowingInVehicle", Random(15000, 30000), false, "ii", hookerid, playerid);
    return 1;
}

forward HOOKER_FinishBlowingInVehicle(hookerid, playerid);
public HOOKER_FinishBlowingInVehicle(hookerid, playerid)
{
    FCNPC_ApplyAnimation(g_rgiHookers[hookerid], "BLOWJOBZ", "BJ_CAR_END_W", 4.1, 0, 0, 0, 1, 0);
    ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_END_P", 4.1, 0, 0, 0, 1, 0);
    g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_FinishBlowingVehAnim", 4000, false, "ii", hookerid, playerid);
    return 1;
}

forward HOOKER_FinishBlowingVehAnim(hookerid, playerid);
public HOOKER_FinishBlowingVehAnim(hookerid, playerid)
{
    TogglePlayerControllable(playerid, true);

    FCNPC_ExitVehicle(g_rgiHookers[hookerid]);
    FCNPC_StopAim(g_rgiHookers[hookerid]);
    g_rgeHookerTasks[hookerid] = HOOKER_TASK_GO_BACK_TO_SPOT;
    g_rgiHookerCustomer[hookerid] = INVALID_PLAYER_ID;
    g_rgiPlayerHooker[playerid] = INVALID_HOOKER_ID;

    if (!IsPlayerInRangeOfPoint(g_rgiHookers[hookerid], 50.0, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]))
    {
        g_rgiHookerUpdateTimer[hookerid] = SetTimerEx("HOOKER_TeleportToSpot", 20000, false, "i", hookerid);
    }
    else
        g_rgiHookerUpdateTimer[hookerid] = 0;

    return 1;
}

public FCNPC_OnVehicleExitComplete(npcid, vehicleid)
{
    new const hookerid = Hooker_FindIdxFromPlayerId(npcid);
    if (hookerid != INVALID_HOOKER_ID)
    {
        if (g_rgeHookerTasks[hookerid] == HOOKER_TASK_GO_BACK_TO_SPOT)
        {
            FCNPC_GoTo(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2], .mode = FCNPC_MOVE_MODE_COLANDREAS, .pathfinding = FCNPC_MOVE_PATHFINDING_RAYCAST);
        }
    }

    #if defined HK_FCNPC_OnVehicleExitComp
        return HK_FCNPC_OnVehicleExitComp(npcid, vehicleid);
    #else
        return 1;
    #endif
}

#if defined _ALS_FCNPC_OnVehicleExitComp
    #undef FCNPC_OnVehicleExitComplete
#else
    #define _ALS_FCNPC_OnVehicleExitComp
#endif
#define FCNPC_OnVehicleExitComplete HK_FCNPC_OnVehicleExitComp
#if defined HK_FCNPC_OnVehicleExitComp
    forward HK_FCNPC_OnVehicleExitComp(npcid, vehicleid);
#endif

forward HOOKER_TeleportToSpot(hookerid);
public HOOKER_TeleportToSpot(hookerid)
{
    new const npcid = g_rgiHookers[hookerid];
    FCNPC_Stop(npcid);
    FCNPC_ClearAnimations(npcid);
    FCNPC_SetPosition(npcid, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
    FCNPC_StopAim(npcid);
    FCNPC_SetAngle(npcid, g_rgfHookerPos[hookerid][3]);
    FCNPC_SetAnimationByName(npcid, "PED:FACGUM", 4.1, true, false, false, false, 0);

    g_rgeHookerTasks[hookerid] = HOOKER_TASK_IDLE;
    g_rgiHookerUpdateTimer[hookerid] = 0;

    return 1;
}