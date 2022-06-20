#if defined _detections_speedhack_
    #endinput
#endif
#define _detections_speedhack_

const __ac_sh_PlayerSync = 207;
IPacket:__ac_sh_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_SPEEDHACK))
        return 1;
    
    new data[PR_OnFootSync];
    BS_IgnoreBits(bs, 8);
    BS_ReadOnFootSync(bs, data);

    new const bool:is_speeding_high = (floatabs(data[PR_velocity][0]) > 0.31 || floatabs(data[PR_velocity][1]) > 0.31);
    new const bool:is_moving = (1222 <= data[PR_animationId] <= 1287);
    
    if(is_speeding_high && is_moving && data[PR_surfingVehicleId] == INVALID_VEHICLE_ID)
    {
        Anticheat_Trigger(playerid, CHEAT_SPEEDHACK);
        return 0;
    }

    return 1;
}