#if defined _trucker_callbacks_
    #endinput
#endif
#define _trucker_callbacks_

static Trucker_JobEvent(playerid, eJobEvent:ev, data)
{
    #pragma unused data

    switch(ev)
    {
        case JOB_EV_JOIN:
        {
            Notification_ShowBeatingText(playerid, 5000, 0xDAA838, 100, 255, "Súbete en uno de los camiones de la central para empezar a trabajar");
        }
        case JOB_EV_LEAVE:
        {
            Player_Job(playerid) = JOB_NONE;

            if(g_rgbPlayerHasBoxInHands{playerid})
            {
                RemovePlayerAttachedObject(playerid, 0);    
            }

            if(g_rgiPlayerUsingTruck[playerid])
            {
                SetVehicleParamsForPlayer(g_rgiPlayerUsingTruck[playerid], playerid, 0, 0);

                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(g_rgiPlayerUsingTruck[playerid], engine, lights, alarm, doors, bonnet, boot, objective);
                SetVehicleParamsEx(g_rgiPlayerUsingTruck[playerid], engine, lights, alarm, doors, bonnet, 0, objective);

                Vehicle_OwnerId(g_rgiPlayerUsingTruck[playerid]) = INVALID_PLAYER_ID;

                Vehicle_Respawn(g_rgiPlayerUsingTruck[playerid]);

                g_rgbPlayerLoadingTruck{playerid} = 
                g_rgbTruckLoaded{g_rgiPlayerUsingTruck[playerid]} =
                g_rgbTruckLoadDispatched{g_rgiPlayerUsingTruck[playerid]} = 
                g_rgbPlayerHasBoxInHands{playerid} = 
                bool:(
                g_rgiPlayerUsingTruck[playerid] =
                g_rgiPlayerRemainingBoxes{playerid} = 
                g_rgiPlayerTruckerRoute{playerid} = 0
                );

                if(IsValidDynamicCP(g_rgiPlayerTruckCheckpoint[playerid]))
                {
                    DestroyDynamicCP(g_rgiPlayerTruckCheckpoint[playerid]);
                    g_rgiPlayerTruckCheckpoint[playerid] = INVALID_STREAMER_ID;
                }

                TogglePlayerAllDynamicCPs(playerid, false);
            }

            if(data == 1)
            {
                Notification_ShowBeatingText(playerid, 5000, 0xED2B2, 100, 255, "Abandonaste tu trabajo como camionero");
            }
        }
        case JOB_EV_LEAVE_VEHICLE:
        {
            Trucker_JobEvent(playerid, JOB_EV_LEAVE, cellmin);
            Notification_Show(playerid, "Abandonaste el camión por mucho tiempo. La remolcadora se lo llevó a la central y devolvió la carga al almacén.", 10000);
        }
    }

    return 1;
}

public OnGameModeInit()
{
    for(new i = sizeof(g_rgfTrucksPos) - 1; i != -1; --i)
    {
        new truckid = Vehicle_Create(499, g_rgfTrucksPos[i][0], g_rgfTrucksPos[i][1], g_rgfTrucksPos[i][2], g_rgfTrucksPos[i][3], 1, 1, 120, .static_veh = true);
        Vehicle_Type(truckid) = VEHICLE_TYPE_WORK;
        g_rgeVehicles[truckid][e_iVehicleWork] = JOB_TRUCKER;
    }

    for(new i = sizeof(g_rgeTruckerRoutes) - 1; i != -1; --i)
    {
        g_rgeTruckerRoutes[i][e_iTruckCp] = CreateDynamicCP(g_rgeTruckerRoutes[i][e_fTruckCpX], g_rgeTruckerRoutes[i][e_fTruckCpY], g_rgeTruckerRoutes[i][e_fTruckCpZ], 5.0, .streamdistance = 99999999.0);
        g_rgeTruckerRoutes[i][e_iBoxUnloadCp] = CreateDynamicCP(g_rgeTruckerRoutes[i][e_fBoxUnloadX], g_rgeTruckerRoutes[i][e_fBoxUnloadY], g_rgeTruckerRoutes[i][e_fBoxUnloadZ], 3.0, .streamdistance = 99999999.0);
    }

    Key_Alert(91.6690, -313.3107, 1.5781, 3.0, KEYNAME_WALK, 0, 0);
    g_iPickBoxCheckpoint = CreateDynamicCP(91.6690, -313.3107, 1.5781, 3.0);
    g_iTruckerCentralArea = CreateDynamicRectangle(16.7866, -217.4639, 205.3851, -346.3419);
    g_iTruckerCentralCp = CreateDynamicCP(137.0536, -277.4443, 1.5781, 5.0, .streamdistance = 99999999.0);

    Job_CreateSite(JOB_TRUCKER, 125.2116, -285.1135, 1.5781, 0, 0, .cb_data = 1);
    Job_SetCallback(JOB_TRUCKER, __addressof(Trucker_JobEvent));

    CreateDynamicMapIcon(125.2116, -285.1135, 1.5781, 51, -1, .worldid = 0, .interiorid = 0);

    #if defined J_TRK_OnGameModeInit
        return J_TRK_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit J_TRK_OnGameModeInit
#if defined J_TRK_OnGameModeInit
    forward J_TRK_OnGameModeInit();
#endif

public OnPlayerDisconnect(playerid, reason)
{
    if(Player_Job(playerid) == JOB_TRUCKER)
    {
        Job_TriggerCallback(playerid, JOB_TRUCKER, JOB_EV_LEAVE);
    }

    #if defined J_TRK_OnPlayerDisconnect
        return J_TRK_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect J_TRK_OnPlayerDisconnect
#if defined J_TRK_OnPlayerDisconnect
    forward J_TRK_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(!vehicleid)
            return 1;

        if(Vehicle_Job(vehicleid) == JOB_TRUCKER)
        {
            if(g_rgeVehicles[vehicleid][e_iVehicleOwnerId] != INVALID_PLAYER_ID)
            {
                if(g_rgeVehicles[vehicleid][e_iVehicleOwnerId] != playerid)
                {
                    Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Este camión ya tiene un conductor");
                }
                else
                {
                    if(g_rgbTruckLoaded{vehicleid})
                    {
                        TogglePlayerDynamicCP(playerid, g_rgeTruckerRoutes[g_rgiPlayerTruckerRoute{playerid}][e_iTruckCp], true);
                        Streamer_Update(playerid, STREAMER_TYPE_CP);
                        Notification_ShowBeatingText(playerid, 5000, 0xDAA838, 100, 255, "Dirígete al punto de descarga");
                    }
                }
            }
            else
            {
                strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Carga\t{DADADA}Peso\t{DADADA}Paga\n");
                new line[128];
                for(new i; i < sizeof(g_rgeTruckerRoutes); ++i)
                {
                    new pay = 1000 + floatround( VectorSize(125.2116 - g_rgeTruckerRoutes[i][e_fTruckCpX], -285.1135 - g_rgeTruckerRoutes[i][e_fTruckCpY], 1.5781 - g_rgeTruckerRoutes[i][e_fTruckCpZ]) );
                    format(line, sizeof(line), "{DADADA}%s\t{DADADA}%i caja%s\t{64A752}$%i\n", g_rgeTruckerRoutes[i][e_szRouteName], g_rgeTruckerRoutes[i][e_iBoxCount], (g_rgeTruckerRoutes[i][e_iBoxCount] > 1 ? "s" : ""), pay);
                    strcat(HYAXE_UNSAFE_HUGE_STRING, line);
                }
                Dialog_Show(playerid, "select_trucker_route", DIALOG_STYLE_TABLIST_HEADERS, "Rutas de {CB3126}camionero", HYAXE_UNSAFE_HUGE_STRING, "Seleccionar", "Cancelar");
            }

            return 1;
        }
    }

    #if defined J_TRK_OnPlayerStateChange
        return J_TRK_OnPlayerStateChange(playerid, newstate, oldstate);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange J_TRK_OnPlayerStateChange
#if defined J_TRK_OnPlayerStateChange
    forward J_TRK_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    if(checkpointid == g_iPickBoxCheckpoint)
    {
        TogglePlayerDynamicCP(playerid, checkpointid, false);
        return 1;
    }
    else if(g_rgiPlayerUsingTruck[playerid])
    { 
        if(checkpointid == g_rgiPlayerTruckCheckpoint[playerid])
        {
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
            ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, false, false, false, false, 0, false);
            RemovePlayerAttachedObject(playerid, 0);
            g_rgbPlayerHasBoxInHands{playerid} = false;

            TogglePlayerDynamicCP(playerid, g_rgiPlayerTruckCheckpoint[playerid], false);

            if(g_rgiPlayerRemainingBoxes{playerid} - 1 > 0)
            {
                SetVehicleParamsForPlayer(g_rgiPlayerUsingTruck[playerid], playerid, 0, 0);

                g_rgiPlayerRemainingBoxes{playerid}--;
                TogglePlayerDynamicCP(playerid, g_iPickBoxCheckpoint, true);
                format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "~w~Te queda%s ~y~%i caja%s~w~ por cargar.", g_rgiPlayerRemainingBoxes{playerid} > 1 ? "n" : "", g_rgiPlayerRemainingBoxes{playerid}, g_rgiPlayerRemainingBoxes{playerid} > 1 ? "s" : "");
                Notification_ShowBeatingText(playerid, 5000, 0xFFFFFF, 100, 255, HYAXE_UNSAFE_HUGE_STRING);
            }
            else
            {
                g_rgiPlayerRemainingBoxes{playerid} = g_rgeTruckerRoutes[g_rgiPlayerTruckerRoute{playerid}][e_iBoxCount];
                g_rgbPlayerLoadingTruck{playerid} = false;
                g_rgbTruckLoaded{g_rgiPlayerUsingTruck[playerid]} = true;

                new engine, lights, alarm, doors, bonnet, dummy;
                GetVehicleParamsEx(g_rgiPlayerUsingTruck[playerid], engine, lights, alarm, doors, bonnet, dummy, dummy);
                SetVehicleParamsEx(g_rgiPlayerUsingTruck[playerid], engine, lights, alarm, doors, bonnet, 0, dummy);
                SetVehicleParamsForPlayer(g_rgiPlayerUsingTruck[playerid], playerid, 0, 0);

                DestroyDynamicCP(g_rgiPlayerTruckCheckpoint[playerid]);
                g_rgiPlayerTruckCheckpoint[playerid] = INVALID_STREAMER_ID;
                Notification_ShowBeatingText(playerid, 5000, 0xDAA838, 100, 255, "Sube al camión y empieza el recorrido");
            }
        }
        else if(checkpointid == g_rgeTruckerRoutes[g_rgiPlayerTruckerRoute{playerid}][e_iTruckCp])
        {
            TogglePlayerDynamicCP(playerid, checkpointid, false);
            TogglePlayerDynamicCP(playerid, g_rgeTruckerRoutes[g_rgiPlayerTruckerRoute{playerid}][e_iBoxUnloadCp], true);
            g_rgbPlayerUnloadingTruck{playerid} = true;
            
            Notification_Show(playerid, "Empieza a descargar las cajas del camión~n~con ~r~~k~~SNEAK_ABOUT~~w~ y déjalas en el punto marcado en el mapa.", 10000);
        
            new engine, lights, alarm, doors, bonnet, objective;
            GetVehicleParamsEx(g_rgiPlayerUsingTruck[playerid], engine, lights, alarm, doors, bonnet, objective, objective);
            SetVehicleParamsEx(g_rgiPlayerUsingTruck[playerid], engine, lights, alarm, doors, bonnet, 1, objective);
            SetVehicleParamsForPlayer(g_rgiPlayerUsingTruck[playerid], playerid, 1, 0);
        }
        else if(checkpointid == g_rgeTruckerRoutes[g_rgiPlayerTruckerRoute{playerid}][e_iBoxUnloadCp])
        {
            if(g_rgbPlayerHasBoxInHands{playerid})
            {
                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
                ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, false, false, false, false, 0, false);
                RemovePlayerAttachedObject(playerid, 0);
                g_rgbPlayerHasBoxInHands{playerid} = false;

                if(g_rgiPlayerRemainingBoxes{playerid} - 1 > 0)
                {
                    SetVehicleParamsForPlayer(g_rgiPlayerUsingTruck[playerid], playerid, 1, 0);

                    g_rgiPlayerRemainingBoxes{playerid}--;
                    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "~w~Te queda%s ~y~%i caja%s~w~ por descargar", g_rgiPlayerRemainingBoxes{playerid} > 1 ? "n" : "", g_rgiPlayerRemainingBoxes{playerid}, g_rgiPlayerRemainingBoxes{playerid} > 1 ? "s" : "");
                    Notification_ShowBeatingText(playerid, 3000, 0xFFFFFF, 100, 255, HYAXE_UNSAFE_HUGE_STRING);
                }
                else
                {
                    g_rgbPlayerUnloadingTruck{playerid} = false;
                    g_rgbTruckLoaded{g_rgiPlayerUsingTruck[playerid]} = false;
                    g_rgbTruckLoadDispatched{g_rgiPlayerUsingTruck[playerid]} = true;

                    new engine, lights, alarm, doors, bonnet, dummy;
                    GetVehicleParamsEx(g_rgiPlayerUsingTruck[playerid], engine, lights, alarm, doors, bonnet, dummy, dummy);
                    SetVehicleParamsEx(g_rgiPlayerUsingTruck[playerid], engine, lights, alarm, doors, bonnet, 0, 0);
                    SetVehicleParamsForPlayer(g_rgiPlayerUsingTruck[playerid], playerid, 0, 0);

                    TogglePlayerDynamicCP(playerid, checkpointid, false);
                    TogglePlayerDynamicCP(playerid, g_iTruckerCentralCp, true);
                    Notification_ShowBeatingText(playerid, 5000, 0xFFFFFF, 100, 255, "~w~Sube al camión y vuelve a la ~y~central");
                }
            }
        }
        else if(checkpointid == g_iTruckerCentralCp)
        {
            new Float:truck_health = Vehicle_GetHealth(g_rgiPlayerUsingTruck[playerid]);

            new route = g_rgiPlayerTruckerRoute{playerid};
            new pay = 1000 + floatround( VectorSize(125.2116 - g_rgeTruckerRoutes[route][e_fTruckCpX], -285.1135 - g_rgeTruckerRoutes[route][e_fTruckCpY], 1.5781 - g_rgeTruckerRoutes[route][e_fTruckCpZ]) );
            new pay_subtracted = 0;

            if(truck_health < 900.0)
            {
                pay -= (pay_subtracted = (100000 / floatround(truck_health)));
            }
            
            Job_TriggerCallback(playerid, JOB_TRUCKER, JOB_EV_LEAVE);
            Player_GiveMoney(playerid, pay);

            if(pay_subtracted)
            {
                format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Has terminado el recorrido con éxito y te pagaron ~g~$%i~w~.~n~Debido a los ~r~daños del camión~w~, se te descontaron ~r~$%i~w~ del pago inicial.", pay, pay_subtracted);
            }
            else
            {
                format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Has terminado el recorrido con éxito y te pagaron ~g~$%i~w~.", pay);
            }

            Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 8000);
        }

        return 1;
    }

    #if defined J_TRK_OnPlayerEnterDynamicCP
        return J_TRK_OnPlayerEnterDynamicCP(playerid, checkpointid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicCP
    #undef OnPlayerEnterDynamicCP
#else
    #define _ALS_OnPlayerEnterDynamicCP
#endif
#define OnPlayerEnterDynamicCP J_TRK_OnPlayerEnterDynamicCP
#if defined J_TRK_OnPlayerEnterDynamicCP
    forward J_TRK_OnPlayerEnterDynamicCP(playerid, checkpointid);
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_WALK) != 0)
    {
        if(!g_rgbPlayerHasBoxInHands{playerid})
        {
            if(g_rgbPlayerLoadingTruck{playerid})
            {
                if(IsPlayerInRangeOfPoint(playerid, 3.0, 91.6690, -313.3107, 1.5781))
                {
                    ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, false, false, false, false, 0, false);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                    SetPlayerAttachedObject(playerid, 0, 2912, 6, 0.08, 0.145, -0.016, 151.4, 0.0, -13.0, 0.552, 0.359, 0.636);
                    Notification_ShowBeatingText(playerid, 3000, 0xFFFFFF, 100, 255, "~w~Deja la caja en el ~y~camión");

                    if(!g_rgiPlayerTruckCheckpoint[playerid])
                    {
                        new Float:x, Float:y, Float:z, Float:angle;
                        GetVehiclePos(g_rgiPlayerUsingTruck[playerid], x, y, z);
                        GetVehicleZAngle(g_rgiPlayerUsingTruck[playerid], angle);

                        new Float:part_x, Float:part_y, Float:part_z;
                        GetVehicleModelInfo(499, VEHICLE_MODEL_INFO_WHEELSREAR, part_x, part_y, part_z);
                        x += (part_x + 0.5) * floatsin(-angle + 180.0, degrees) + (part_y * floatsin(-angle, degrees));
                        y += (part_x + 0.5) * floatcos(-angle + 180.0, degrees) + (part_y * floatcos(-angle, degrees));

                        g_rgiPlayerTruckCheckpoint[playerid] = CreateDynamicCP(x, y, z, 2.0, .playerid = playerid);
                    }

                    TogglePlayerDynamicCP(playerid, g_rgiPlayerTruckCheckpoint[playerid], true);
                    g_rgbPlayerHasBoxInHands{playerid} = true;

                    SetVehicleParamsForPlayer(g_rgiPlayerUsingTruck[playerid], playerid, 1, 0);
                
                    return 1;
                }
            }
            else if(g_rgbPlayerUnloadingTruck{playerid})
            {
                new truckid = g_rgiPlayerUsingTruck[playerid];
                new Float:x, Float:y, Float:z, Float:angle;
                GetVehiclePos(truckid, x, y, z);
                GetVehicleZAngle(truckid, angle);

                new Float:px, Float:py, Float:pz;
                GetVehicleModelInfo(499, VEHICLE_MODEL_INFO_WHEELSREAR, px, py, pz);
                x += (px) * floatsin(-angle + 180.0, degrees) + (py * floatsin(-angle, degrees));
                y += (px) * floatcos(-angle + 180.0, degrees) + (py * floatcos(-angle, degrees));

                if(IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
                {
                    g_rgbPlayerHasBoxInHands{playerid} = true;

                    ApplyAnimation(playerid, "CARRY", "PUTDWN", 4.1, false, false, false, false, 0, false);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
                    SetPlayerAttachedObject(playerid, 0, 2912, 6, 0.08, 0.145, -0.016, 151.4, 0.0, -13.0, 0.552, 0.359, 0.636);
                    Notification_ShowBeatingText(playerid, 3000, 0xFFFFFF, 100, 255, "~w~Deja la caja en el ~y~almacén");

                    TogglePlayerDynamicCP(playerid, g_rgeTruckerRoutes[g_rgiPlayerTruckerRoute{playerid}][e_iBoxUnloadCp], true);
                    Streamer_Update(playerid, STREAMER_TYPE_CP);

                    SetVehicleParamsForPlayer(truckid, playerid, 0, 0);

                    return 1;
                }
            }
        }
    }

    #if defined J_TRK_OnPlayerKeyStateChange
        return J_TRK_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange J_TRK_OnPlayerKeyStateChange
#if defined J_TRK_OnPlayerKeyStateChange
    forward J_TRK_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

dialog select_trucker_route(playerid, response, listitem, const inputtext[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

    if(
        !response || 
        !(0 <= listitem < sizeof(g_rgeTruckerRoutes)) || 
        !vehicleid || 
        Vehicle_Job(vehicleid) != JOB_TRUCKER
    )
    {
        RemovePlayerFromVehicle(playerid);
        return 1;
    }

    TogglePlayerDynamicCP(playerid, g_iPickBoxCheckpoint, true);
    Streamer_Update(playerid, STREAMER_TYPE_CP);

    Notification_Show(playerid, "Empieza a cargar el camión con las cajas del punto marcado en el mapa.", 5000);

    g_rgiPlayerUsingTruck[playerid] = vehicleid;
    g_rgeVehicles[vehicleid][e_iVehicleOwnerId] = playerid;
    g_rgiPlayerTruckerRoute{playerid} = listitem;
    g_rgiPlayerRemainingBoxes{playerid} = g_rgeTruckerRoutes[listitem][e_iBoxCount];
    g_rgbPlayerLoadingTruck{playerid} = true;
    g_rgbTruckLoaded{vehicleid} = false;
    g_rgbTruckLoadDispatched{vehicleid} = false;
    
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);

    ApplyAnimation(playerid, "CARRY", "null", 4.1, false, false, false, false, 0, false);

    return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    if(areaid == g_iTruckerCentralArea)
    {
        if(Player_Job(playerid) == JOB_TRUCKER)
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            if(!vehicleid || (!g_rgbTruckLoaded{vehicleid} && !g_rgbTruckLoadDispatched{vehicleid}))
            {
                Job_TriggerCallback(playerid, JOB_TRUCKER, JOB_EV_LEAVE);
                Notification_Show(playerid, "Al salir de la central de camioneros, abandonaste el trabajo.", 8000);
                return 1;
            }
        }
    }

    #if defined J_TRK_OnPlayerLeaveDynamicArea
        return J_TRK_OnPlayerLeaveDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerLeaveDynamicArea
    #undef OnPlayerLeaveDynamicArea
#else
    #define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea J_TRK_OnPlayerLeaveDynamicArea
#if defined J_TRK_OnPlayerLeaveDynamicArea
    forward J_TRK_OnPlayerLeaveDynamicArea(playerid, areaid);
#endif

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger)
    {
        if(g_rgeVehicles[vehicleid][e_iVehicleWork] == JOB_TRUCKER && Player_Job(playerid) != JOB_TRUCKER)
        {
            TogglePlayerControllable(playerid, false);
            Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Necesitas el trabajo de camionero para subir a este vehículo");
            wait_ms(2000);
            TogglePlayerControllable(playerid, true);

            return 1;
        }
    }

    #if defined J_TRK_OnPlayerEnterVehicle
        return J_TRK_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterVehicle
    #undef OnPlayerEnterVehicle
#else
    #define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle J_TRK_OnPlayerEnterVehicle
#if defined J_TRK_OnPlayerEnterVehicle
    forward J_TRK_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
#endif
