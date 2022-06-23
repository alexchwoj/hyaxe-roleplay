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

public OnVehicleDeath(vehicleid, killerid)
{
    g_rgeVehicles[vehicleid][e_bSpawned] = false;
    g_rgeVehicles[vehicleid][e_fHealth] = 1000.0;
    g_rgeVehicles[vehicleid][e_fFuel] = g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_fMaxFuel];

    #if defined VEH_OnVehicleDeath
        return VEH_OnVehicleDeath(vehicleid, killerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnVehicleDeath
    #undef OnVehicleDeath
#else
    #define _ALS_OnVehicleDeath
#endif
#define OnVehicleDeath VEH_OnVehicleDeath
#if defined VEH_OnVehicleDeath
    forward VEH_OnVehicleDeath(vehicleid, killerid);
#endif

public OnVehicleSpawn(vehicleid)
{
    if(g_rgeVehicles[vehicleid][e_iVehicleType] == VEHICLE_TYPE_WORK && g_rgeVehicles[vehicleid][e_iVehicleOwnerId] != INVALID_PLAYER_ID)
    {
        Job_TriggerCallback(g_rgeVehicles[vehicleid][e_iVehicleOwnerId], g_rgeVehicles[vehicleid][e_iVehicleWork], JOB_EV_LEAVE_VEHICLE);
        g_rgeVehicles[vehicleid][e_iVehicleOwnerId] = INVALID_PLAYER_ID;
        g_rgeVehicles[vehicleid][e_fHealth] = 1000.0;
        g_rgeVehicles[vehicleid][e_bLocked] = false;
    }

    g_rgeVehicles[vehicleid][e_bSpawned] = true;
    SetVehicleHealth(vehicleid, g_rgeVehicles[vehicleid][e_fHealth]);
    SetVehicleParamsEx(vehicleid, 0, 0, 0, Vehicle_Locked(vehicleid), 0, 0, 0);

    #if defined VEH_OnVehicleSpawn
        return VEH_OnVehicleSpawn(vehicleid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnVehicleSpawn
    #undef OnVehicleSpawn
#else
    #define _ALS_OnVehicleSpawn
#endif
#define OnVehicleSpawn VEH_OnVehicleSpawn
#if defined VEH_OnVehicleSpawn
    forward VEH_OnVehicleSpawn(vehicleid);
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
        Notification_HideBeatingText(playerid);
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

        g_rgeVehicles[vehicleid][e_fFuel] = fclamp((g_rgeVehicles[vehicleid][e_fFuel] - ((Vehicle_GetSpeed(vehicleid) + 0.1) / VEHICLE_FUEL_DIVISOR)), 0.0, Vehicle_GetModelMaxFuel(GetVehicleModel(vehicleid)));

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

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_NO) != 0 && !(newkeys & KEY_HANDBRAKE))
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

            if(Speedometer_Shown(playerid))
            {
                PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{2}, 0xE69F2EFF);
                PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{2});
            }

            format(notif_str, sizeof(notif_str), "%s motor", (Vehicle_GetEngineState(vehicleid) == VEHICLE_STATE_ON ? "Apagando" : "Encendiendo"));
            Notification_ShowBeatingText(playerid, 1000, 0xF29624, 100, 255,  notif_str);
            g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_TOGGLE_ENGINE] = SetTimerEx("VEHICLE_ToggleEngineTimer", 1000, false, "ii", playerid, vehicleid);
        }
    }
    else if((newkeys & KEY_YES) != 0)
    {
        new vehicleid = (IsPlayerInAnyVehicle(playerid) ? GetPlayerVehicleID(playerid) : GetPlayerCameraTargetVehicle(playerid));
        if(vehicleid != INVALID_VEHICLE_ID)
        {
            if(g_rgeVehicles[vehicleid][e_iVehicleOwnerId] == playerid || Vehicle_Type(vehicleid) == VEHICLE_TYPE_ADMIN)
            {
                Vehicle_ToggleLock(vehicleid);
                SetPlayerChatBubble(playerid, (g_rgeVehicles[vehicleid][e_bLocked] ? "* Bloqueó su vehículo" : "* Desbloqueó su vehículo"), 0xB39B6BFF, 15.0, 5000);
                
                if(Speedometer_Shown(playerid))
                {
                    PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{0}, (g_rgeVehicles[vehicleid][e_bLocked] ? 0xA83225FF : 0x64A752FF));
                    PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{0});
                }

                new message[55];
                format(message, sizeof(message), "* %s %sbloqueó su vehículo", Player_RPName(playerid), (g_rgeVehicles[vehicleid][e_bLocked] ? "" : "des"));
                Chat_SendMessageToRange(playerid, 0xB39B6BFF, 15.0, message);

                new Float:x, Float:y, Float:z, vw = GetPlayerVirtualWorld(playerid), int = GetPlayerInterior(playerid);
                GetVehiclePos(vehicleid, x, y, z);

                Sound_PlayInRange(SOUND_CAR_DOORS, 10.0, x, y, z, vw, int);

                return 1;
            }
        }
    }
    else if((newkeys & (KEY_HANDBRAKE | KEY_NO)) == KEY_HANDBRAKE | KEY_NO)
    {
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            if(vehicleid)
            {
                new lights = Vehicle_ToggleLights(vehicleid);
                if(Speedometer_Shown(playerid))
                {
                    PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{3}, (lights ? 0x64A752FF : 0x2F2F2FFF));
                    PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{3});
                }
            }

            return 1;
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
        if(Speedometer_Shown(playerid))
        {
            PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{2}, 0xA83225FF);
            PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{2});
        }

        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Motor averiado.");
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
        if(Speedometer_Shown(playerid))
        {
            PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{2}, 0x64A752FF);
            PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{2});
        }
    }
    else
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Motor apagado");
        if(Speedometer_Shown(playerid))
        {
            PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{2}, 0x2F2F2FFF);
            PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{2});
        }
    }

    return 1;
}

forward VEHICLE_LoadFromDatabase(playerid);
public VEHICLE_LoadFromDatabase(playerid)
{
    new row_count;
    cache_get_row_count(row_count);

    for(new i = 0; i < row_count; ++i)
    {
        new
            model, colorone, colortwo,
            Float:x, Float:y, Float:z, Float:angle,
            panels, doors, lights, tires,
            components[70],
            p;
        
        cache_get_value_name_int(i, "MODEL", model);
        cache_get_value_name_int(i, "COLOR_ONE", colorone);
        cache_get_value_name_int(i, "COLOR_TWO", colortwo);
        cache_get_value_name_float(i, "POS_X", x);
        cache_get_value_name_float(i, "POS_Y", y);
        cache_get_value_name_float(i, "POS_Z", z);
        cache_get_value_name_float(i, "ANGLE", angle);

        new vehicleid = Vehicle_Create(model, x, y, z, angle, colorone, colortwo, -1);
        
        cache_get_value_name_int(i, "VEHICLE_ID", g_rgeVehicles[vehicleid][e_iVehicleDbId]);
        g_rgeVehicles[vehicleid][e_iVehicleOwnerId] = playerid;

        cache_get_value_name_float(i, "HEALTH", g_rgeVehicles[vehicleid][e_fHealth]);
        cache_get_value_name_float(i, "FUEL", g_rgeVehicles[vehicleid][e_fFuel]);
        cache_get_value_name_int(i, "PANELS_STATUS", panels);
        cache_get_value_name_int(i, "DOORS_STATUS", doors);
        cache_get_value_name_int(i, "LIGHTS_STATUS", lights);
        cache_get_value_name_int(i, "TIRES_STATUS", tires);
        cache_get_value_name_int(i, "PAINTJOB", g_rgeVehicles[vehicleid][e_iPaintjob]);
        cache_get_value_name_int(i, "INTERIOR", g_rgeVehicles[vehicleid][e_iVehInterior]);
        cache_get_value_name_int(i, "VW", g_rgeVehicles[vehicleid][e_iVehWorld]);
        cache_get_value_name(i, "COMPONENTS", components);
        cache_get_value_name_int(i, "PARAMS", p);

        SetVehicleHealth(vehicleid, g_rgeVehicles[vehicleid][e_fHealth]);
        UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
        ChangeVehiclePaintjob(vehicleid, g_rgeVehicles[vehicleid][e_iPaintjob]);
        LinkVehicleToInterior(vehicleid, g_rgeVehicles[vehicleid][e_iVehInterior]);
        SetVehicleVirtualWorld(vehicleid, g_rgeVehicles[vehicleid][e_iVehWorld]);

        sscanf(components, "p<,>a<i>[14]", g_rgeVehicles[vehicleid][e_iComponents]);
        for(new j; j < 14; ++j)
        {
            if(g_rgeVehicles[vehicleid][e_iComponents][j] != 0)
            {
                AddVehicleComponent(vehicleid, g_rgeVehicles[vehicleid][e_iComponents][j]);
            }
        }

        new 
            engine = (p & 1),
            lights_p = (p >> 1) & 1,
            alarm = (p >> 2) & 1,
            doors_p = (p >> 3) & 1,
            bonnet = (p >> 4) & 1,
            boot = (p >> 5) & 1,
            objective = (p >> 6) & 1;

        DEBUG_PRINT("params: %b", p);
        DEBUG_PRINT("engine = %i", engine);
        DEBUG_PRINT("lights = %i", lights_p);
        DEBUG_PRINT("alarm = %i", alarm);
        DEBUG_PRINT("doors = %i", doors_p);
        DEBUG_PRINT("bonnet = %i", bonnet);
        DEBUG_PRINT("boot = %i", boot);
        DEBUG_PRINT("objective = %i", objective);

        SetVehicleParamsEx(vehicleid, engine, lights_p, alarm, doors_p, bonnet, boot, objective);

        g_rgeVehicles[vehicleid][e_bLocked] = !!doors_p;

        // Engine is ON, start updating the vehicle
        if(engine)
        {
            g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_UPDATE] = SetTimerEx("VEHICLE_Update", 1000, true, "i", vehicleid);
        }

        Iter_Add(PlayerVehicles[playerid], vehicleid);
    }

    return 1;
}

public OnPlayerAuthenticate(playerid)
{
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        SELECT * FROM `PLAYER_VEHICLES` WHERE `OWNER_ID` = %i;\
    ", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "VEHICLE_LoadFromDatabase", "i", playerid);

    #if defined VEH_OnPlayerAuthenticate
        return VEH_OnPlayerAuthenticate(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerAuthenticate
    #undef OnPlayerAuthenticate
#else
    #define _ALS_OnPlayerAuthenticate
#endif
#define OnPlayerAuthenticate VEH_OnPlayerAuthenticate
#if defined VEH_OnPlayerAuthenticate
    forward VEH_OnPlayerAuthenticate(playerid);
#endif

// - Prevent car jacking
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger)
    {
        new last_driver = GetVehicleLastDriver(vehicleid);
        if(GetPlayerVehicleID(last_driver) == vehicleid && GetPlayerState(last_driver) == PLAYER_STATE_DRIVER)
        {
            if(GetTickDiff(GetTickCount(), g_rgePlayerTempData[playerid][e_iPlayerCarJackTick]) > 60000)
            {
                g_rgePlayerTempData[playerid][e_iPlayerCarJackAmount] = 0;
            }

            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            SetPlayerPos(playerid, x, y, z);
            ClearAnimations(playerid, 1);
            TogglePlayerControllable(playerid, false);

            g_rgePlayerTempData[playerid][e_iPlayerCarJackTick] = GetTickCount();
            g_rgePlayerTempData[playerid][e_iPlayerCarJackAmount]++;

            if(g_rgePlayerTempData[playerid][e_iPlayerCarJackAmount] >= 5)
            {
                Anticheat_Trigger(playerid, CHEAT_CARJACK);
                return 0;
            }

            Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "No puedes robar vehículos");
            task_yield(0);
            wait_ms(2000);

            TogglePlayerControllable(playerid, true);

            return 0;
        }
    }

    #if defined VEH_OnPlayerEnterVehicle
        return VEH_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterVehicle
    #undef OnPlayerEnterVehicle
#else
    #define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle VEH_OnPlayerEnterVehicle
#if defined VEH_OnPlayerEnterVehicle
    forward VEH_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
#endif
