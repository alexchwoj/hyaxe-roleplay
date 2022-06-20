#if defined _vehicles_functions_
    #endinput
#endif
#define _vehicles_functions_

Vehicle_Create(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, addsiren = 0, bool:static_veh = false)
{
    new vehicleid = (static_veh ? AddStaticVehicleEx(vehicletype, x, y, z, rotation, color1, color2, respawn_delay, addsiren) : CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay, addsiren));
    if(vehicleid != INVALID_VEHICLE_ID)
    {
        g_rgeVehicles[vehicleid][e_bValid] =
        g_rgeVehicles[vehicleid][e_bSpawned] = true;
        g_rgeVehicles[vehicleid][e_iVehicleOwnerId] = INVALID_PLAYER_ID;
        g_rgeVehicles[vehicleid][e_fPosX] = x;
        g_rgeVehicles[vehicleid][e_fPosY] = y;
        g_rgeVehicles[vehicleid][e_fPosZ] = z;
        g_rgeVehicles[vehicleid][e_fPosAngle] = rotation;
        g_rgeVehicles[vehicleid][e_iColorOne] = color1;
        g_rgeVehicles[vehicleid][e_iColorTwo] = color2;
        g_rgeVehicles[vehicleid][e_fFuel] = g_rgeVehicleModelData[vehicletype - 400][e_fMaxFuel];
        g_rgeVehicles[vehicleid][e_fHealth] = 1000.0;
        g_rgeVehicles[vehicleid][e_iSellIndex] = -1;

        SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
    }

    return vehicleid;
}

Vehicle_Destroy(vehicleid)
{
    if(!DestroyVehicle(vehicleid))
        return 0;

    Vehicle_StopUpdating(vehicleid);
    g_rgeVehicles[vehicleid][e_bValid] = false;
    g_rgeVehicles[vehicleid][e_iVehicleOwnerId] = INVALID_PLAYER_ID;
    g_rgeVehicles[vehicleid][e_iVehicleDbId] = 0;

    return 1;
}

Vehicle_StopUpdating(vehicleid)
{
    if(!g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_UPDATE])
        return 0;

    KillTimer(g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_UPDATE]);
    g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_UPDATE] = 0;

    return 1;
}

Vehicle_GetEngineState(vehicleid)
{
    new engine, param;
    GetVehicleParamsEx(vehicleid, engine, param, param, param, param, param, param);
    return engine;
}

Float:Vehicle_GetSpeed(vehicleid)
{
    new Float:vx, Float:vy, Float:vz;
    GetVehicleVelocity(vehicleid, vx, vy, vz);
    return VectorSize(vx, vy, vz) * 180.0;
}

Vehicle_ToggleEngine(vehicleid, engstate = VEHICLE_STATE_DEFAULT)
{
    if(Vehicle_GetEngineState(vehicleid) == engstate)
        return 1;

    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, (engstate == VEHICLE_STATE_DEFAULT ? (_:!engine) : engstate), lights, alarm, doors, bonnet, boot, objective);
    
    if(Vehicle_GetEngineState(vehicleid) == VEHICLE_STATE_ON)
    {
        g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_UPDATE] = SetTimerEx("VEHICLE_Update", 1000, true, "i", vehicleid);
    }
    else if(g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_UPDATE])
    {
        Vehicle_StopUpdating(vehicleid);
    }

    return 1;
}

Vehicle_ToggleLock(vehicleid)
{
    g_rgeVehicles[vehicleid][e_bLocked] = !g_rgeVehicles[vehicleid][e_bLocked];
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, g_rgeVehicles[vehicleid][e_bLocked], bonnet, boot, objective);

    return 1;
}

Vehicle_ToggleLights(vehicleid, status = VEHICLE_STATE_DEFAULT)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    lights = (status != VEHICLE_STATE_DEFAULT ? status : _:!lights);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    return lights;
}

Vehicle_GetLightsStatus(vehicleid)
{
    new dummy, lights;
    GetVehicleParamsEx(vehicleid, dummy, lights, dummy, dummy, dummy, dummy, dummy);
    return lights;
}

Vehicle_SetHealth(vehicleid, Float:health)
{
    if(SetVehicleHealth(vehicleid, health))
    {
        g_rgeVehicles[vehicleid][e_fHealth] = health;

        if(IsVehicleOccupied(vehicleid))
        {
            new playerid = GetVehicleLastDriver(vehicleid);
            Player_SetImmunityForCheat(playerid, CHEAT_REPAIR_CAR, 1000 + GetPlayerPing(playerid));
        }

        return 1;
    }

    return 0;
}

Vehicle_Repair(vehicleid)
{
    if(RepairVehicle(vehicleid))
    {
        g_rgeVehicles[vehicleid][e_fHealth] = 1000.0;

        if(IsVehicleOccupied(vehicleid))
        {
            new playerid = GetVehicleLastDriver(vehicleid);
            Player_SetImmunityForCheat(playerid, CHEAT_REPAIR_CAR, 1000 + GetPlayerPing(playerid));
        }

        return 1;
    }

    return 0;
}

Vehicle_Respawn(vehicleid)
{
    g_rgeVehicles[vehicleid][e_bSpawned] = false;
    return SetVehicleToRespawn(vehicleid);
}

bool:Vehicle_HasAnyDoorRemoved(vehicleid)
{
    new panels, doors, lights, tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    return (doors & 0b00000100000001000000010000000100) != 0;
}

Speedometer_Show(playerid)
{
    if(g_rgiSpeedometerUpdateTimer[playerid])
       return 0;

    if(!IsPlayerInAnyVehicle(playerid))
        return 0;
    
    for(new i = sizeof(g_tdSpeedometer) - 1; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdSpeedometer[i]);
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{0}, (g_rgeVehicles[vehicleid][e_bLocked] ? 0xA83225FF : 0x64A752FF));
    PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{0});
    PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{1});
    if(Vehicle_GetHealth(vehicleid) <= 375.0 || !Vehicle_Fuel(vehicleid))
    {
        PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{2}, 0xA83225FF);
    }
    else
    {
        PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{2}, (Vehicle_GetEngineState(vehicleid) ? 0x64A752FF : 0x2F2F2FFF));
    }
    PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{2});
    PlayerTextDrawBoxColor(playerid, p_tdSpeedometer[playerid]{3}, (Vehicle_GetLightsStatus(vehicleid) ? 0x64A752FF : 0x2F2F2FFF));
    PlayerTextDrawShow(playerid, p_tdSpeedometer[playerid]{3});

    Speedometer_Update(playerid);
    g_rgiSpeedometerUpdateTimer[playerid] = SetTimerEx("Speedometer_Update", 1000, true, "i", playerid);

    return 1;
}

Speedometer_Hide(playerid)
{
    if(!g_rgiSpeedometerUpdateTimer[playerid])
        return 0;

    for(new i = sizeof(g_tdSpeedometer) - 1; i != -1; --i)
    {
        TextDrawHideForPlayer(playerid, g_tdSpeedometer[i]);
    }

    PlayerTextDrawHide(playerid, p_tdSpeedometer[playerid]{0});
    PlayerTextDrawHide(playerid, p_tdSpeedometer[playerid]{1});
    PlayerTextDrawHide(playerid, p_tdSpeedometer[playerid]{2});
    PlayerTextDrawHide(playerid, p_tdSpeedometer[playerid]{3});

    KillTimer(g_rgiSpeedometerUpdateTimer[playerid]);
    g_rgiSpeedometerUpdateTimer[playerid] = 0;

    return 1;
}

public Speedometer_Update(playerid)
{
    if(!IsPlayerInAnyVehicle(playerid))
    {
        if(g_rgiSpeedometerUpdateTimer[playerid])
        {
            KillTimer(g_rgiSpeedometerUpdateTimer[playerid]);
        }

        return 1;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    new modelid = GetVehicleModel(vehicleid) - 400;
    new Float:kmh = Vehicle_GetSpeed(vehicleid);

    TextDrawSetStringForPlayer(g_tdSpeedometer[8], playerid, "%i", floatround(kmh));
    TextDrawSetStringForPlayer(g_tdSpeedometer[4], playerid, "GAS~n~%i", floatround(Vehicle_Fuel(vehicleid)));

    const Float:GREEN_BAR_MIN = -0.370;
    const Float:GREEN_BAR_MAX = -5.570;

    new Float:new_y;

    // Update speed progress bar
    new Float:veh_max_speed = float(g_rgeVehicleModelData[modelid][e_iMaxSpeed]);
    new Float:max_speed_percentage = fclamp(kmh / veh_max_speed, 0.0, 1.0);
    new_y = lerp(GREEN_BAR_MIN, GREEN_BAR_MAX, max_speed_percentage);
    TextDrawLetterSize(g_tdSpeedometer[7], 0.600, new_y);
    TextDrawShowForPlayer(playerid, g_tdSpeedometer[7]);

    // Update gas progress bar
    new Float:max_fuel_percentage = Vehicle_Fuel(vehicleid) / g_rgeVehicleModelData[modelid][e_fMaxFuel];
    new_y = lerp(GREEN_BAR_MIN, GREEN_BAR_MAX, max_fuel_percentage);
    TextDrawLetterSize(g_tdSpeedometer[3], 0.600, new_y);
    new color = InterpolateColourLinear(0xA83225FF, 0x64A752FF, max_fuel_percentage);
    TextDrawBoxColor(g_tdSpeedometer[3], color);
    TextDrawShowForPlayer(playerid, g_tdSpeedometer[3]);

    return 1;
}

Player_RegisterVehicle(playerid, vehicleid)
{
    g_rgeVehicles[vehicleid][e_iVehicleOwnerId] = playerid;

    new panels, doors, lights, tires;
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

    new params, engine, lights_p, alarm, doors_p, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights_p, alarm, doors_p, bonnet, boot, objective);
    params = engine | (lights_p << 1) | (alarm << 2) | (doors_p << 3) | (bonnet << 4) | (boot << 5) | (objective << 6);

    new components[70];
    format(components, sizeof(components), "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
        g_rgeVehicles[vehicleid][e_iComponents][0],
        g_rgeVehicles[vehicleid][e_iComponents][1],
        g_rgeVehicles[vehicleid][e_iComponents][2],
        g_rgeVehicles[vehicleid][e_iComponents][3],
        g_rgeVehicles[vehicleid][e_iComponents][4],
        g_rgeVehicles[vehicleid][e_iComponents][5],
        g_rgeVehicles[vehicleid][e_iComponents][6],
        g_rgeVehicles[vehicleid][e_iComponents][7],
        g_rgeVehicles[vehicleid][e_iComponents][8],
        g_rgeVehicles[vehicleid][e_iComponents][9],
        g_rgeVehicles[vehicleid][e_iComponents][10],
        g_rgeVehicles[vehicleid][e_iComponents][11],
        g_rgeVehicles[vehicleid][e_iComponents][12],
        g_rgeVehicles[vehicleid][e_iComponents][13]
    );

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        INSERT INTO `PLAYER_VEHICLES` \
            (OWNER_ID, MODEL, HEALTH, FUEL, PANELS_STATUS, DOORS_STATUS, LIGHTS_STATUS, TIRES_STATUS, COLOR_ONE, COLOR_TWO, PAINTJOB, POS_X, POS_Y, POS_Z, ANGLE, INTERIOR, VW, COMPONENTS, PARAMS) \
        VALUES \
            (%d, %d, %f, %f, %d, %d, %d, %d, %d, %d, %d, %f, %f, %f, %f, %d, %d, '%s', %d);\
    ",
        Player_AccountID(playerid),
        GetVehicleModel(vehicleid),
        g_rgeVehicles[vehicleid][e_fHealth], g_rgeVehicles[vehicleid][e_fFuel], panels, doors, lights, tires,
        g_rgeVehicles[vehicleid][e_iColorOne], g_rgeVehicles[vehicleid][e_iColorTwo], g_rgeVehicles[vehicleid][e_iPaintjob],
        g_rgeVehicles[vehicleid][e_fPosX], g_rgeVehicles[vehicleid][e_fPosY], g_rgeVehicles[vehicleid][e_fPosZ], g_rgeVehicles[vehicleid][e_fPosAngle],
        g_rgeVehicles[vehicleid][e_iVehInterior] ,g_rgeVehicles[vehicleid][e_iVehWorld],
        components, params
    );

    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    return 1;
}

Player_SaveVehicles(playerid)
{
    DEBUG_PRINT("[veh] Saving player %i vehicles", playerid);
    
    if(!Iter_Count(PlayerVehicles[playerid]))
        return 0;
    
    HYAXE_UNSAFE_HUGE_STRING[0] = '\0';
    
    new query[800];
    foreach(new vehicleid : PlayerVehicles[playerid])
    {
        if(!g_rgeVehicles[vehicleid][e_bValid])
            continue;

        new panels, doors, lights, tires;
        GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

        GetVehiclePos(vehicleid, g_rgeVehicles[vehicleid][e_fPosX], g_rgeVehicles[vehicleid][e_fPosY], g_rgeVehicles[vehicleid][e_fPosZ]);
        GetVehicleZAngle(vehicleid, g_rgeVehicles[vehicleid][e_fPosAngle]);

        new engine, lights_p, alarm, doors_p, bonnet, boot, objective;
        GetVehicleParamsEx(vehicleid, engine, lights_p, alarm, doors_p, bonnet, boot, objective);
        new params = engine | (lights_p << 1) | (alarm << 2) | (doors_p << 3) | (bonnet << 4) | (boot << 5) | (objective << 6);

        new components[70];
        format(components, sizeof(components), "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
            g_rgeVehicles[vehicleid][e_iComponents][0],
            g_rgeVehicles[vehicleid][e_iComponents][1],
            g_rgeVehicles[vehicleid][e_iComponents][2],
            g_rgeVehicles[vehicleid][e_iComponents][3],
            g_rgeVehicles[vehicleid][e_iComponents][4],
            g_rgeVehicles[vehicleid][e_iComponents][5],
            g_rgeVehicles[vehicleid][e_iComponents][6],
            g_rgeVehicles[vehicleid][e_iComponents][7],
            g_rgeVehicles[vehicleid][e_iComponents][8],
            g_rgeVehicles[vehicleid][e_iComponents][9],
            g_rgeVehicles[vehicleid][e_iComponents][10],
            g_rgeVehicles[vehicleid][e_iComponents][11],
            g_rgeVehicles[vehicleid][e_iComponents][12],
            g_rgeVehicles[vehicleid][e_iComponents][13]
        );

        mysql_format(g_hDatabase, query, sizeof(query), "\
            UPDATE `PLAYER_VEHICLES` SET \
                HEALTH = %.2f, \
                FUEL = %f, \
                PANELS_STATUS = %d, \
                DOORS_STATUS = %d, \
                LIGHTS_STATUS = %d, \
                TIRES_STATUS = %d, \
                COLOR_ONE = %d, \
                COLOR_TWO = %d, \
                PAINTJOB = %d, \
                POS_X = %f, \
                POS_Y = %f, \
                POS_Z = %f, \
                ANGLE = %f, \
                INTERIOR = %d, \
                VW = %d, \
                COMPONENTS = '%s', \
                PARAMS = %d \
            WHERE `VEHICLE_ID` = %d; \
        ",
            g_rgeVehicles[vehicleid][e_fHealth],
            g_rgeVehicles[vehicleid][e_fFuel],
            panels, doors, lights, tires,
            g_rgeVehicles[vehicleid][e_iColorOne], g_rgeVehicles[vehicleid][e_iColorTwo], g_rgeVehicles[vehicleid][e_iPaintjob],
            g_rgeVehicles[vehicleid][e_fPosX], g_rgeVehicles[vehicleid][e_fPosY], g_rgeVehicles[vehicleid][e_fPosZ], g_rgeVehicles[vehicleid][e_fPosAngle],
            g_rgeVehicles[vehicleid][e_iVehInterior], g_rgeVehicles[vehicleid][e_iVehWorld],
            components,
            params,
            g_rgeVehicles[vehicleid][e_iVehicleDbId]
        );

        strcat(HYAXE_UNSAFE_HUGE_STRING, query);
    }

    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    return 1;
}

command veh(playerid, const params[], "Crea un vehículo")
{
    new modelid, color1, color2;
    if(sscanf(params, "k<vehicle>D(-1)D(-1)", modelid, color1, color2) || modelid == -1)
    {
        return SendClientMessage(playerid, 0xDADADAFF, "USO: /{ED2B2B}veh {DADADA}<modelo> {969696}[color 1] [color 2]");
    }

    new Float:x, Float:y, Float:z, Float:ang;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, ang);

    new vehicleid = Vehicle_Create(modelid, x, y, z, ang, color1, color2, 0);
    Vehicle_SetInterior(vehicleid, GetPlayerInterior(playerid));
    Vehicle_SetVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

    PutPlayerInVehicle(playerid, vehicleid, 0);

    SendClientMessagef(playerid, 0xED2B2BFF, "› {DADADA}Se creó un {ED2B2B}%s {DADADA}(modelo {ED2B2B}%d{DADADA}) {DADADA}en tu posición.", Vehicle_GetModelName(modelid), modelid);

    return 1;
}
flags:veh(CMD_FLAG<RANK_LEVEL_MODERATOR>)


command rvehp(playerid, const params[], "Registra un vehículo en la cuenta de un jugador")
{
    new vehicleid, destination;

    if(sscanf(params, "ir", vehicleid, destination) || !IsValidVehicle(vehicleid))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/rvehp {DADADA}<id del vehículo> <id del destinatario>");
        return 1;
    }

    if(Player_RegisterVehicle(destination, vehicleid))
    {
        SendClientMessagef(playerid, 0xED2B2BFF, "› {DADADA}Se registró un {ED2B2B}%s {DADADA}en la cuenta de {ED2B2B}%s{DADADA}.", Vehicle_GetModelName(GetVehicleModel(vehicleid)), Player_RPName(destination));
    }

    return 1;
}
flags:rvehp(CMD_FLAG<RANK_LEVEL_ADMINISTRATOR>)

command set_veh_health(playerid, const params[], "Cambia la vida de un vehículo")
{
    extract params -> new vehicleid = 0, Float:health = 1000.0; else {
        return SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/repairveh {969696}[id del vehículo = 0 | 0 = (actual)] {969696}[vida = 1000.0]");
    }

    if(!vehicleid)
        vehicleid = GetPlayerVehicleID(playerid);

    if(!IsValidVehicle(vehicleid))
        return SendClientMessage(playerid, 0xED2B2BFF, "› {DADADA}Vehículo inválido.");

    health = fclamp(health, 0.0, 1000.0);
    if(health == 1000.0)
    {
        Vehicle_Repair(vehicleid);
    }
    else
    {
        Vehicle_SetHealth(vehicleid, health);
    }

    SendClientMessagef(playerid, 0xED2B2BFF, "› {DADADA}La vida del vehículo {ED2B2B}%i{DADADA} ahora es de {ED2B2B}%.1f{DADADA}.", vehicleid, health);

    return 1;
}
alias:set_veh_health("setvehhealth", "svh", "rv", "repairveh", "repairvehicle")
flags:set_veh_health(CMD_FLAG<RANK_LEVEL_MODERATOR>)