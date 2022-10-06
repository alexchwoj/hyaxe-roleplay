#if defined _detections_repaircar_
    #endinput
#endif
#define _detections_repaircar_

const __ac_rc_VehicleSync = 200;
IPacket:__ac_rc_VehicleSync(playerid, BitStream:bs)
{
    new vehicleid, Float:vehicle_health;
    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8,
        PR_UINT16, vehicleid,
        PR_IGNORE_BITS, 368,
        PR_FLOAT, vehicle_health
    );

    if (!g_rgeVehicles[vehicleid][e_bValid])
        return 0;
        
    if (vehicle_health < 375.0)
    {
        vehicle_health = 375.0;
        Vehicle_SetHealth(vehicleid, 375.0);
        BS_SetWriteOffset(bs, 8 + 16 + 368);
        BS_WriteValue(bs, PR_FLOAT, 375.0);
    }

    if (Player_HasImmunityForCheat(playerid, CHEAT_REPAIR_CAR))
        return 1;

    if (g_rgeVehicles[vehicleid][e_bValid] && Vehicle_GetHealth(vehicleid) < vehicle_health)
    {
        Anticheat_Trigger(playerid, CHEAT_REPAIR_CAR);
        return 0;
    }

    g_rgeVehicles[vehicleid][e_fHealth] = vehicle_health;

    return 1;
}