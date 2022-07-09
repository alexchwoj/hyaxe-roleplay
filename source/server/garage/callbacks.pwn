#if defined _garage_callbacks_
    #endinput
#endif
#define _garage_callbacks_

static Garage_OnPress(playerid, repairid)
{
    if(Player_Money(playerid) < 250)
    {
        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes dinero para reparar tu vehículo");
        return 1;
    }

    Player_GiveMoney(playerid, -250);

    Sound_PlayInRange(12201, 10.0, g_rgeRepairPositions[repairid][e_fRepairPosX], g_rgeRepairPositions[repairid][e_fRepairPosY], g_rgeRepairPositions[repairid][e_fRepairPosZ], 0, 0);
    
    new vehicleid = GetPlayerVehicleID(playerid);
    Vehicle_ToggleEngine(vehicleid, VEHICLE_STATE_OFF);
    Vehicle_Repairing(vehicleid) = true;

    Notification_ShowBeatingText(playerid, 5000, 0xF29624, 100, 255, "Reparando vehículo...");
    g_rgiRepairSoundTimer[playerid] = SetTimerEx("GARAGE_VehicleRepairPlaySound", 1000, true, "i", playerid);
    g_rgiRepairFinishTimer[playerid] = SetTimerEx("GARAGE_FinishRepairCar", 5000, false, "ii", playerid, vehicleid);

    return 1;
}

public OnGameModeInit()
{
    for(new i; i < sizeof(g_rgeRepairPositions); ++i)
    {
        CreateDynamic3DTextLabel("{CB3126}Reparación de vehículos\n{DADADA}Costo: {98D952}250${DADADA}", 0xFFFFFFFF, g_rgeRepairPositions[i][e_fRepairPosX], g_rgeRepairPositions[i][e_fRepairPosY], g_rgeRepairPositions[i][e_fRepairPosZ], 10.0, .testlos = 1);
        Key_Alert(g_rgeRepairPositions[i][e_fRepairPosX], g_rgeRepairPositions[i][e_fRepairPosY], g_rgeRepairPositions[i][e_fRepairPosZ], 1.5, KEYNAME_YES, 0, 0, KEY_TYPE_VEHICLE, .callback_on_press = __addressof(Garage_OnPress), .cb_data = i);
    }

    #if defined GARAGE_OnGameModeInit
        return GARAGE_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit GARAGE_OnGameModeInit
#if defined GARAGE_OnGameModeInit
    forward GARAGE_OnGameModeInit();
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