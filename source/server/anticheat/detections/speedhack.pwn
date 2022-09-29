#if defined _detections_speedhack_
    #endinput
#endif
#define _detections_speedhack_

const __ac_sh_PlayerSync = 207;
IPacket:__ac_sh_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_SPEEDHACK))
        return 1;
    
    new 
        Float:velocity_x, Float:velocity_y,
        surfing_vehicle_id, animation_id;

    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8 + 16 + 16 + 16 + (32 * 7) + 8 + 8 + 2 + 6 + 8,
        PR_FLOAT, velocity_x,
        PR_FLOAT, velocity_y,
        PR_IGNORE_BITS, (32 * 4),
        PR_UINT16, surfing_vehicle_id,
        PR_INT16, animation_id
    );

    //new const bool:is_speeding_high = (floatabs(velocity_x) > 0.31 || floatabs(velocity_y) > 0.31);
    //new const bool:is_moving = (1222 <= animation_id <= 1287);
    
    if((floatabs(velocity_x) > 0.31 || floatabs(velocity_y) > 0.31) && (1222 <= animation_id <= 1287) && surfing_vehicle_id == INVALID_VEHICLE_ID)
    {
        Anticheat_Trigger(playerid, CHEAT_SPEEDHACK);
        return 0;
    }

    return 1;
}