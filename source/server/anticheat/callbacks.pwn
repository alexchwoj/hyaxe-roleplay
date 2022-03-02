#if defined _anticheat_callbacks_
    #endinput
#endif
#define _anticheat_callbacks_

/*
const ac__veh_VEHICLE_SYNC = 200;
IPacket:ac__veh_VEHICLE_SYNC(playerid, BitStream:bs)
{
    BS_IgnoreBits(bs, 8);

    new vehicleid;
    BS_ReadUint16(bs, vehicleid);

    BS_IgnoreBits(bs, 368);

    new Float:veh_health;
    BS_ReadFloat(bs, veh_health);
    
    g_rgeVehicles[vehicleid][e_fHealth] = veh_health;
    return 1;
}
*/