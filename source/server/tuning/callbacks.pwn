#if defined _tuning_callbacks_
    #endinput
#endif
#define _tuning_callbacks_

static Tuning_OnPress(playerid, repairid)
{
    #pragma unused repairid
    Tuning_Open(playerid);
    return 1;
}

public OnGameModeInit()
{
    new area_id = CreateDynamicCube(
        -122.50, -1207.50, 0.0,
        -53.50, -1138.50, 10.0,
        .worldid = 0, .interiorid = 0
    );
    Streamer_SetIntData(STREAMER_TYPE_AREA, area_id, E_STREAMER_CUSTOM(0x4d4558), 0); // MEC

    for(new i; i < sizeof(g_rgeRepairPositions); ++i)
    {
        CreateDynamic3DTextLabel("{CB3126}Taller mecánico\n{DADADA}Modifique su vehículo aquí", 0xFFFFFFFF, g_rgeRepairPositions[i][e_fRepairPosX], g_rgeRepairPositions[i][e_fRepairPosY], g_rgeRepairPositions[i][e_fRepairPosZ], 10.0, .testlos = 1);
        Key_Alert(g_rgeRepairPositions[i][e_fRepairPosX], g_rgeRepairPositions[i][e_fRepairPosY], g_rgeRepairPositions[i][e_fRepairPosZ], 1.5, KEYNAME_YES, 0, 0, KEY_TYPE_VEHICLE, .callback_on_press = __addressof(Tuning_OnPress), .cb_data = i);
    }

    #if defined TUN_OnGameModeInit
        return TUN_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit TUN_OnGameModeInit
#if defined TUN_OnGameModeInit
    forward TUN_OnGameModeInit();
#endif

public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if (Streamer_HasArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4d4558)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        Notification_Show(playerid, "Has entrado al taller mecánico, las colisiones de tu vehículo se han desactivado.", 3000, 0xDAA838FF);
        DisableRemoteVehicleCollisions(playerid, true);
    }

    #if defined TUN_OnPlayerEnterDynamicArea
        return TUN_OnPlayerEnterDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicArea
    #undef OnPlayerEnterDynamicArea
#else
    #define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea TUN_OnPlayerEnterDynamicArea
#if defined TUN_OnPlayerEnterDynamicArea
    forward TUN_OnPlayerEnterDynamicArea(playerid, areaid);
#endif

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    if (Streamer_HasArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4d4558)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        Notification_Show(playerid, "Has salido del taller mecánico, las colisiones de tu vehículo se han activado de nuevo.", 3000, 0xDAA838FF);
        DisableRemoteVehicleCollisions(playerid, false);
    }

    #if defined TUN_OnPlayerLeaveDynamicArea
        return TUN_OnPlayerLeaveDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerLeaveDynamicArea
    #undef OnPlayerLeaveDynamicArea
#else
    #define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea TUN_OnPlayerLeaveDynamicArea
#if defined TUN_OnPlayerLeaveDynamicArea
    forward TUN_OnPlayerLeaveDynamicArea(playerid, areaid);
#endif

public GARAGE_VehicleRepairPlaySound(playerid)
{
    static const random_sounds[] = {
        1133,
        1134,
        1140,
        1148
    };

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    Sound_PlayInRange(random_sounds[random(sizeof(random_sounds))], 10.0, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

    return 1;
}

public GARAGE_FinishRepairCar(playerid, vehicleid)
{
    Vehicle_Repair(vehicleid);
    Vehicle_Repairing(vehicleid) = false;
    Notification_ShowBeatingText(playerid, 3000, 0x98D952, 100, 255, "Vehículo reparado");
    Timer_Kill(g_rgiRepairSoundTimer[playerid]);
    g_rgiRepairFinishTimer[playerid] = 0;

    return 1;
}