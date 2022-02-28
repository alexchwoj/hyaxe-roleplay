#if defined _vehicles_functions_
    #endinput
#endif
#define _vehicles_functions_

Vehicle_Create(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, addsiren = 0)
{
    new vehicleid =  CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay, addsiren);
    if(vehicleid != INVALID_VEHICLE_ID)
    {
        g_rgeVehicles[vehicleid][e_bValid] = true;
        g_rgeVehicles[vehicleid][e_fPosX] = x;
        g_rgeVehicles[vehicleid][e_fPosY] = y;
        g_rgeVehicles[vehicleid][e_fPosZ] = z;
        g_rgeVehicles[vehicleid][e_fPosAngle] = rotation;
        g_rgeVehicles[vehicleid][e_iColorOne] = color1;
        g_rgeVehicles[vehicleid][e_iColorTwo] = color2;
        g_rgeVehicles[vehicleid][e_fFuel] = g_rgeVehicleModelData[vehicletype - 400][e_fMaxFuel];
        g_rgeVehicles[vehicleid][e_fHealth] = 1000.0;

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

Vehicle_SetInterior(vehicleid, interior)
{
    g_rgeVehicles[vehicleid][e_iVehInterior] = interior;
    return LinkVehicleToInterior(vehicleid, interior);
}

Vehicle_SetVirtualWorld(vehicleid, vw)
{
    g_rgeVehicles[vehicleid][e_iVehWorld] = vw;
    return SetVehicleVirtualWorld(vehicleid, vw);
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

Speedometer_Show(playerid)
{
    if(g_rgiSpeedometerUpdateTimer[playerid])
       return 0;

    for(new i = sizeof(g_tdSpeedometer) - 1; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdSpeedometer[i]);
    }

    Speedometer_Update(playerid);
    g_rgiSpeedometerUpdateTimer[playerid] = SetTimerEx("VEHICLE_UpdateSpeedometer", 1000, true, "i", playerid);

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

    KillTimer(g_rgiSpeedometerUpdateTimer[playerid]);
    g_rgiSpeedometerUpdateTimer[playerid] = 0;

    return 1;
}

Speedometer_Update(playerid)
{
    const SPEED_MAX_SLASHES = 33;
    const SPEED_MAX_FLOORS = 35;

    new vehicleid = GetPlayerVehicleID(playerid);
    if(vehicleid == INVALID_VEHICLE_ID)
        return 0;

    new Float:kmh = Vehicle_GetSpeed(vehicleid);

    TextDrawSetStringForPlayer(g_tdSpeedometer[4], playerid, "%i", floatround(kmh));

    new veh_max_speed = g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_iMaxSpeed];
    new max_speed_percentage = floatround(floatdiv(kmh, veh_max_speed) * 100.0);    
    new slashes = clamp(((max_speed_percentage * SPEED_MAX_SLASHES) / 100), 0, SPEED_MAX_SLASHES);

    new td_string[SPEED_MAX_SLASHES + SPEED_MAX_FLOORS + 3], i;

    for(; i < slashes; ++i)
    {
        td_string[i] = '/';
    }

    strcat(td_string, "~n~");
    i += 3;

    new gas_percentage = floatround((g_rgeVehicles[vehicleid][e_fFuel] / Vehicle_GetModelMaxFuel(GetVehicleModel(vehicleid))) * 100.0);
    new floors = clamp(((gas_percentage * SPEED_MAX_FLOORS) / 100), 0, SPEED_MAX_FLOORS);

    for(new j; j < floors; ++j)
    {
        td_string[i++] = '-';
    }

    TextDrawSetStringForPlayer(g_tdSpeedometer[1], playerid, td_string);

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
    LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
    SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

    PutPlayerInVehicle(playerid, vehicleid, 0);

    SendClientMessagef(playerid, 0xDADADAFF, "Se creó un {ED2B2B}%s {DADADA}(modelo {ED2B2B}%d{DADADA}) {DADADA}en tu posición.", Vehicle_GetModelName(modelid), modelid);

    return 1;
}