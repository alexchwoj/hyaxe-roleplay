#if defined _vehicles_callbacks_
    #endinput
#endif
#define _vehicles_callbacks_

static 
    s_rgiVehicleLockTick[MAX_PLAYERS];

public OnScriptInit()
{
    print("[veh] Initializing iterators...");
    Iter_Init(PlayerVehicles);
    
    #if defined VEH_OnScriptInit
        return VEH_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit VEH_OnScriptInit
#if defined VEH_OnScriptInit
    forward VEH_OnScriptInit();
#endif

public OnPlayerDisconnect(playerid, reason)
{
    if (g_rgiSpeedometerUpdateTimer[playerid])
    {
        Timer_Kill(g_rgiSpeedometerUpdateTimer[playerid]);
    }

    Player_SaveVehicles(playerid);

    foreach(new v : PlayerVehicles[playerid])
    {
        Vehicle_Destroy(v);
    }

    printf("[debug] Cleaning vehicle iterator for playerid %d", playerid);
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

    if (Vehicle_Type(vehicleid) == VEHICLE_TYPE_PERSONAL)
    {
        SendClientMessagef(g_rgeVehicles[vehicleid][e_iVehicleOwnerId], 0xED2B2BFF, "›{DADADA} Tu {ED2B2B}%s{DADADA} fue destruido. La aseguradora te dejó uno nuevo en el estacionamiento municipal.", Vehicle_GetModelName(GetVehicleModel(vehicleid)));
    }

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
    if (Vehicle_Type(vehicleid) == VEHICLE_TYPE_WORK)
    {
        if (g_rgeVehicles[vehicleid][e_iVehicleOwnerId] != INVALID_PLAYER_ID)
        {
            Job_TriggerCallback(g_rgeVehicles[vehicleid][e_iVehicleOwnerId], g_rgeVehicles[vehicleid][e_iVehicleWork], JOB_EV_LEAVE_VEHICLE);
            g_rgeVehicles[vehicleid][e_iVehicleOwnerId] = INVALID_PLAYER_ID;
        }
        
        g_rgeVehicles[vehicleid][e_fHealth] = 1000.0;
        g_rgeVehicles[vehicleid][e_bLocked] = false;
    }
    else if (Vehicle_Type(vehicleid) == VEHICLE_TYPE_PERSONAL)
    {
        new pos = random(sizeof(g_rgfParkingSlots));
        SetVehiclePos(vehicleid, g_rgfParkingSlots[pos][0], g_rgfParkingSlots[pos][1], g_rgfParkingSlots[pos][2]);
        SetVehicleZAngle(vehicleid, g_rgfParkingSlots[pos][3]);
        Vehicle_Locked(vehicleid) = true;
    }

    g_rgeVehicles[vehicleid][e_bSpawned] = true;
    SetVehicleHealth(vehicleid, g_rgeVehicles[vehicleid][e_fHealth]);
    SetVehicleParamsEx(vehicleid, 0, 0, 0, Vehicle_Locked(vehicleid), 0, 0, 0);
    UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, 0);

    for (new i; i < 14; ++i)
    {
        if (g_rgeVehicles[vehicleid][e_iComponents][i])
        {
            AddVehicleComponent(vehicleid, g_rgeVehicles[vehicleid][e_iComponents][i]);
        }
    }
    
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
    if (newstate == PLAYER_STATE_DRIVER)
    {
        if (Bit_Get(Player_Config(playerid), CONFIG_DISPLAY_SPEEDOMETER))
            Speedometer_Show(playerid);
        
        if (Vehicle_GetEngineState(GetPlayerVehicleID(playerid)) == VEHICLE_STATE_OFF)
        {
            Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Presiona Y para encender el vehículo");
            SetPlayerArmedWeapon(playerid, 0);
        }
    }
    else if (oldstate == PLAYER_STATE_DRIVER)
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
    if (Vehicle_GetEngineState(vehicleid) == VEHICLE_STATE_ON)
    {
        if (g_rgeVehicles[vehicleid][e_fHealth] <= 375.0)
        {
            Vehicle_ToggleEngine(vehicleid, VEHICLE_STATE_OFF);
            if (IsVehicleOccupied(vehicleid))
            {
                Notification_ShowBeatingText(GetVehicleLastDriver(vehicleid), 5000, 0xED2B2B, 100, 255, "Motor averiado. Llama a un mecánico");
            }

            return 1;
        }

        g_rgeVehicles[vehicleid][e_fFuel] = fclamp((g_rgeVehicles[vehicleid][e_fFuel] - ((Vehicle_GetSpeed(vehicleid) + 0.1) / VEHICLE_FUEL_DIVISOR)), 0.0, Vehicle_GetModelMaxFuel(GetVehicleModel(vehicleid)));

        if (g_rgeVehicles[vehicleid][e_fFuel] <= 0.0)
        {
            Vehicle_ToggleEngine(vehicleid, VEHICLE_STATE_OFF);
            if (IsVehicleOccupied(vehicleid))
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
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER && (newkeys & KEY_YES) != 0 && !(newkeys & KEY_HANDBRAKE))
    {
        Vehicle_PlayerStartEngine(playerid);
    }
    else if ((newkeys & KEY_YES) != 0 && !(newkeys & KEY_SPRINT))
    {
        if (GetTickCount() - s_rgiVehicleLockTick[playerid] > 500)
        {
            new vehicleid = INVALID_VEHICLE_ID;
            new const in_vehicle = IsPlayerInAnyVehicle(playerid);
            
            if (Bit_Get(Player_Config(playerid), CONFIG_ANDROID_MODE) && !in_vehicle)
                vehicleid = GetPlayerNearestVehicle(playerid);
            else
                vehicleid = (in_vehicle ? GetPlayerVehicleID(playerid) : GetPlayerCameraTargetVehicle(playerid));
                
            if (IsValidVehicle(vehicleid))
            {
                if (Vehicle_OwnerId(vehicleid) == playerid || (Vehicle_Type(vehicleid) == VEHICLE_TYPE_ADMIN && Player_AdminLevel(playerid) >= RANK_LEVEL_HELPER))
                {
                    Vehicle_ToggleLock(vehicleid);
                    SetPlayerChatBubble(playerid, (g_rgeVehicles[vehicleid][e_bLocked] ? "* Bloqueó su vehículo" : "* Desbloqueó su vehículo"), 0xB39B6BFF, 15.0, 5000);
                    
                    if (Speedometer_Shown(playerid))
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

                    s_rgiVehicleLockTick[playerid] = GetTickCount();

                    return 1;
                }
            }
        }
    }
    else if ((newkeys & (KEY_HANDBRAKE | KEY_NO)) == KEY_HANDBRAKE | KEY_NO)
    {
        if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            Vehicle_PlayerEnableLights(playerid);
            return 1;
        }
    }
    else if ((newkeys & KEY_LOOK_BEHIND) != 0)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if (IsValidVehicle(vehicleid))
        {
            // Vehicle windows
            new windows[4], player_seat;

            player_seat = GetPlayerVehicleSeat(playerid);
            if (player_seat < 0 || player_seat > 3)
                player_seat = 3;

            // Vehicle name
            new header[64];
            format(
                header, sizeof(header), "{CB3126}%s{E6E6E6} (%s)",
                g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_szModelName],
                (player_seat ? "Pasajero" : "Conductor")
            );

            GetVehicleParamsCarWindows(vehicleid, windows[0], windows[1], windows[2], windows[3]);

            // Vehicle panel
            if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                    Ventana\t%s\n\
                    Motor\t%s\n\
                    Luces\t%s\n\
                    Ver celular\t\
                ",
                    (windows[player_seat] ? "{CB3126}Cerrada" : "{64A752}Abierta"),
                    (Vehicle_GetEngineState(vehicleid) ? "{64A752}Encendido" : "{CB3126}Apagado"),
                    (Vehicle_GetLightsStatus(vehicleid) ? "{64A752}Encendidas" : "{CB3126}Apagadas")
                );
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
            {
                format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                    Ventana\t%s\
                ",
                    (windows[player_seat] ? "{CB3126}Cerrada" : "{64A752}Abierta")
                );
            }

            Dialog_ShowCallback(playerid, using public _hydg@vehicle_panel<iiiis>, DIALOG_STYLE_TABLIST, header, HYAXE_UNSAFE_HUGE_STRING, !"Seleccionar", !"Cerrar");
            PlayerPlaySound(playerid, SOUND_BUTTON);
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

dialog vehicle_panel(playerid, dialogid, response, listitem, const inputtext[])
{
    if (response)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if (!IsValidVehicle(vehicleid))
            return 1;

        switch (listitem)
        {
            case 0:
            {
                new windows[4], player_seat;

                player_seat = GetPlayerVehicleSeat(playerid);
                if (player_seat < 0 || player_seat > 3)
                    player_seat = 3;

                GetVehicleParamsCarWindows(vehicleid, windows[0], windows[1], windows[2], windows[3]);

                windows[ player_seat ] = (windows[ player_seat ] ? 0 : 1);
                SetVehicleParamsCarWindows(vehicleid, windows[0], windows[1], windows[2], windows[3]);
                PlayerPlaySound(playerid, SOUND_CAR_DOORS);
            }
            case 1:
            {
                Vehicle_PlayerStartEngine(playerid);
                PlayerPlaySound(playerid, SOUND_CAR_DOORS);
            }
            case 2:
            {
                Vehicle_PlayerEnableLights(playerid);
                PlayerPlaySound(playerid, SOUND_CAR_DOORS);
            }
            case 3:
            {
                if (!Inventory_GetItemCount(playerid, ITEM_PHONE))
		            return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes un teléfono celular");

                PhoneMenu_Main(playerid);
            }
        }
    }

    return 1;
}

public VEHICLE_ToggleEngineTimer(playerid, vehicleid)
{
    g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_TOGGLE_ENGINE] = 0;
    
    if (g_rgeVehicles[vehicleid][e_fHealth] <= 375.0)
    {
        if (Speedometer_Shown(playerid))
        {
            PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{2}, 0xA83225FF);
            PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{2});
        }

        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Motor averiado.");
        return 1;
    }

    if (g_rgeVehicles[vehicleid][e_fFuel] <= 0.0)
    {
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Tanque sin gasolina");
        return 1;
    }

    Vehicle_ToggleEngine(vehicleid);

    if (Vehicle_GetEngineState(vehicleid))
    {
        Notification_ShowBeatingText(playerid, 3000, 0x98D952, 100, 255, "Motor encendido");
        if (Speedometer_Shown(playerid))
        {
            PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{2}, 0x64A752FF);
            PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{2});
        }
    }
    else
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Motor apagado");
        if (Speedometer_Shown(playerid))
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
    printf("[dbg:veh] VEHICLE_LoadFromDatabase(playerid = %d)", playerid);

    new row_count;
    cache_get_row_count(row_count);

    printf("[dbg:veh] Player has %d vehicles", row_count);

    for (new i = 0; i < row_count; ++i)
    {
        printf("[dbg:veh] Loading vehicle %d", i);

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

        printf("[dbg:veh] model = %d", model);
        printf("[dbg:veh] colorone = %d", colorone);
        printf("[dbg:veh] colortwo = %d", colortwo);
        printf("[dbg:veh] pos_x = %f", x);
        printf("[dbg:veh] pos_y = %f", y);
        printf("[dbg:veh] pos_z = %f", z);
        printf("[dbg:veh] angle = %f", angle);

        new vehicleid = Vehicle_Create(model, x, y, z, angle, colorone, colortwo, -1);
        if (vehicleid == INVALID_VEHICLE_ID)
        {
            printf("[vehicles] Failed to create vehicle of playerid %i (model: %i)", playerid, model);
            continue;
        }

        printf("[dbg:veh] vehicle created with id %d", vehicleid);

        cache_get_value_name_int(i, "VEHICLE_ID", g_rgeVehicles[vehicleid][e_iVehicleDbId]);
        g_rgeVehicles[vehicleid][e_iVehicleOwnerId] = playerid;
        Vehicle_Type(vehicleid) = VEHICLE_TYPE_PERSONAL;

        printf("[dbg:veh] vehicle dbid = %d", g_rgeVehicles[vehicleid][e_iVehicleDbId]);
        
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
        for (new j; j < 14; ++j)
        {
            if (g_rgeVehicles[vehicleid][e_iComponents][j] != 0)
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
        if (engine)
        {
            g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_UPDATE] = SetTimerEx("VEHICLE_Update", 1000, true, "i", vehicleid);
        }

        Iter_Add(PlayerVehicles[playerid], vehicleid);

        // Load trunk
        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            SELECT * FROM `VEHICLE_TRUNK` WHERE `VEHICLE_ID` = %i;\
        ", g_rgeVehicles[vehicleid][e_iVehicleDbId]);
        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "TRUNK_LoadFromDatabase", "i", vehicleid);
    }

    return 1;
}

public OnPlayerAuthenticate(playerid)
{
    printf("[dbg:veh] Loading vehicles for player %d", playerid);

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
    if (!ispassenger)
    {
        new last_driver = GetVehicleLastDriver(vehicleid);
        if (GetPlayerVehicleID(last_driver) == vehicleid && GetPlayerState(last_driver) == PLAYER_STATE_DRIVER)
        {
            if (GetTickCount() - g_rgePlayerTempData[playerid][e_iPlayerCarJackTick] > 60000)
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

            if (g_rgePlayerTempData[playerid][e_iPlayerCarJackAmount] >= 5)
            {
                Anticheat_Trigger(playerid, CHEAT_CARJACK);
                return 0;
            }

            Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "No puedes robar vehículos");

            inline const Due()
            {
                TogglePlayerControllable(playerid, true);
            }
            Timer_CreateCallback(using inline Due, 2000, 1);

            return 0;
        }
    }

    SetPlayerArmedWeapon(playerid, 0);

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

public OnPlayerPauseStateChange(playerid, pausestate)
{
    if (pausestate)
    {
        if (g_rgiSpeedometerUpdateTimer[playerid])
        {
            Timer_Kill(g_rgiSpeedometerUpdateTimer[playerid]);
        }
    }
    else
    {
        if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            Speedometer_Update(playerid);
            g_rgiSpeedometerUpdateTimer[playerid] = SetTimerEx("Speedometer_Update", 1000, true, "i", playerid);
        }
    }

    #if defined VEH_OnPlayerPauseStateChange
        return VEH_OnPlayerPauseStateChange(playerid, pausestate);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerPauseStateChange
    #undef OnPlayerPauseStateChange
#else
    #define _ALS_OnPlayerPauseStateChange
#endif
#define OnPlayerPauseStateChange VEH_OnPlayerPauseStateChange
#if defined VEH_OnPlayerPauseStateChange
    forward VEH_OnPlayerPauseStateChange(playerid, pausestate);
#endif
