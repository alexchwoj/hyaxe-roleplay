#if defined _detections_fly_
    #endinput
#endif
#define _detections_fly_

const __ac_fly_PlayerSync = 207;
IPacket:__ac_fly_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_FLY))
        return 1;

    new 
        special_action,
        surfing_vehicle_id,
        Float:position_z,
        animation_id,
        weapon_id;
    
    BS_ReadValue(bs, 
        PR_IGNORE_BITS, 8 + 16 + 16 + 16 + (32 * 2),
        PR_FLOAT, position_z,
        PR_IGNORE_BITS, (32 * 4) + 8 + 8 + 2,
        PR_BITS, weapon_id, 6,
        PR_UINT8, special_action,
        PR_IGNORE_BITS, (32 * 6),
        PR_UINT16, surfing_vehicle_id,
        PR_INT16, animation_id
    );
    
    if(special_action == SPECIAL_ACTION_USEJETPACK && !Player_AdminLevel(playerid))
    {
        Anticheat_Trigger(playerid, CHEAT_FLY);
        return 0;
    }

    if(surfing_vehicle_id != 0 || position_z < 1.0)
        return 1;
    
    if((958 <= animation_id <= 959) && weapon_id != WEAPON_PARACHUTE)
    {
        Anticheat_Trigger(playerid, CHEAT_FLY);
        return 0;
    }

    if(157 <= animation_id <= 162)
    {
        Anticheat_Trigger(playerid, CHEAT_FLY);
        return 0;
    }

    new Float:dummy;
    if(((1538 <= animation_id <= 1544) || animation_id == 1250) && !CA_IsPlayerInWater(playerid, dummy, dummy))
    {
        Anticheat_Trigger(playerid, CHEAT_FLY);
        return 0;
    }

    return 1;
}