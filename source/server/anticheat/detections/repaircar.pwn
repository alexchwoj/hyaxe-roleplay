#if defined _detections_repaircar_
    #endinput
#endif
#define _detections_repaircar_

const __ac_rc_VehicleSync = 200;
IPacket:__ac_rc_VehicleSync(playerid, BitStream:bs)
{
    if(Player_HasImmunityForCheat(playerid, CHEAT_REPAIR_CAR))
        return 1;

    new vehicleid, Float:vehicle_health;
    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8,
        PR_UINT16, vehicleid,
        PR_IGNORE_BITS, 368,
        PR_FLOAT, vehicle_health
    );

    if(Vehicle_GetHealth(vehicleid) < vehicle_health)
    {
        Anticheat_Trigger(playerid, CHEAT_REPAIR_CAR);
        return 0;
    }

    g_rgeVehicles[vehicleid][e_fHealth] = vehicle_health;

    return 1;
}