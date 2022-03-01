#if defined _vehicles_callbacks_
    #endinput
#endif
#define _vehicles_callbacks_

public OnGameModeInit()
{
    print("[veh] Initializing iterators...");
    Iter_Init(PlayerVehicles);

    #if defined VEH_OnGameModeInit
        return VEH_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit VEH_OnGameModeInit
#if defined VEH_OnGameModeInit
    forward VEH_OnGameModeInit();
#endif

public OnPlayerDisconnect(playerid, reason)
{
    if(g_rgiSpeedometerUpdateTimer[playerid] != -1)
    {
        KillTimer(g_rgiSpeedometerUpdateTimer[playerid]);
        g_rgiSpeedometerUpdateTimer[playerid] = -1;
    }

    Player_SaveVehicles(playerid);

    foreach(new v : PlayerVehicles[playerid])
    {
        Vehicle_Destroy(v);
    }

    Iter_Clear(PlayerVehicles[playerid]);

    #if defined VEH_OnPlayerDisconnect
        return VEH_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect VEH_OnPlayerDisconnect
#if defined VEH_OnPlayerDisconnect
    forward VEH_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        Speedometer_Show(playerid);
        if(Vehicle_GetEngineState(GetPlayerVehicleID(playerid)) == VEHICLE_STATE_OFF)
        {
            Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Presiona ~k~~CONVERSATION_NO~ para encender el vehículo");
        }
    }
    else if(oldstate == PLAYER_STATE_DRIVER)
    {
        Speedometer_Hide(playerid);
    }

    #if defined VEH_OnPlayerStateChange
        return VEH_OnPlayerStateChange(playerid, newstate, oldstate);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange VEH_OnPlayerStateChange
#if defined VEH_OnPlayerStateChange
    forward VEH_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

public VEHICLE_Update(vehicleid)
{
    if(Vehicle_GetEngineState(vehicleid) == VEHICLE_STATE_ON)
    {
        if(g_rgeVehicles[vehicleid][e_fHealth] <= 375.0)
        {
            Vehicle_ToggleEngine(vehicleid, VEHICLE_STATE_OFF);
            if(IsVehicleOccupied(vehicleid))
            {
                Notification_ShowBeatingText(GetVehicleLastDriver(vehicleid), 5000, 0xED2B2B, 100, 255, "Motor averiado. Llama a un mecánico");
            }

            return 1;
        }

        g_rgeVehicles[vehicleid][e_fFuel] -= (Vehicle_GetSpeed(vehicleid) + 0.1) / VEHICLE_FUEL_DIVISOR;
        if(g_rgeVehicles[vehicleid][e_fFuel] <= 0.0)
        {
            Vehicle_ToggleEngine(vehicleid, VEHICLE_STATE_OFF);
            if(IsVehicleOccupied(vehicleid))
            {
                Notification_ShowBeatingText(GetVehicleLastDriver(vehicleid), 5000, 0xED2B2B, 100, 255, "Tanque sin gasolina");
            }

            return 1;
        }
    }

    return 1;
}

public VEHICLE_UpdateSpeedometer(playerid)
{
    Speedometer_Update(playerid);
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_NO) != 0)
    {
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            if(!vehicleid)
                return 1;

            new notif_str[40];
            
            if(g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_TOGGLE_ENGINE])
            {
                format(notif_str, sizeof(notif_str), "El vehículo ya se está %s", (Vehicle_GetEngineState(vehicleid) ? "apagando" : "encendiendo"));
                Notification_ShowBeatingText(playerid, 1000, 0xED2B2B, 100, 255, notif_str);
                return 1;
            }

            format(notif_str, sizeof(notif_str), "%s motor", (Vehicle_GetEngineState(vehicleid) == VEHICLE_STATE_ON ? "Apagando" : "Encendiendo"));
            Notification_ShowBeatingText(playerid, 1000, 0xF29624, 100, 255,  notif_str);
            g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_TOGGLE_ENGINE] = SetTimerEx("VEHICLE_ToggleEngineTimer", 1000, false, "ii", playerid, vehicleid);
        }
    }

    #if defined VEH_OnPlayerKeyStateChange
        return VEH_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange VEH_OnPlayerKeyStateChange
#if defined VEH_OnPlayerKeyStateChange
    forward VEH_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public VEHICLE_ToggleEngineTimer(playerid, vehicleid)
{
    g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_TOGGLE_ENGINE] = 0;
    
    if(g_rgeVehicles[vehicleid][e_fHealth] <= 375.0)
    {
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Motor averiado. Llama a un mecánico");
        return 1;
    }

    if(g_rgeVehicles[vehicleid][e_fFuel] <= 0.0)
    {
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Tanque sin gasolina");
        return 1;
    }

    Vehicle_ToggleEngine(vehicleid);

    if(Vehicle_GetEngineState(vehicleid))
    {
        Notification_ShowBeatingText(playerid, 3000, 0x98D952, 100, 255, "Motor encendido");
    }
    else
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Motor apagado");
    }

    return 1;
}