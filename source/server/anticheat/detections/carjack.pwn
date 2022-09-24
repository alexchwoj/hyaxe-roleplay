#if defined _detections_carjack_
    #endinput
#endif
#define _detections_carjack_

const __ac_cj_VehicleSync = 200;
IPacket:__ac_cj_VehicleSync(playerid, BitStream:bs)
{
    if(Player_HasImmunityForCheat(playerid, CHEAT_CARJACK))
        return 1;

    new
        vehicleid;

    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8,
        PR_UINT16, vehicleid
    );

    new last_driver = GetVehicleLastDriver(vehicleid);
    if(last_driver != playerid && GetPlayerState(last_driver) == PLAYER_STATE_DRIVER)
    {
        Anticheat_Trigger(playerid, CHEAT_CARJACK);
        return 0;
    }

    return 1;
}