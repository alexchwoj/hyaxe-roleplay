#if defined _detections_fly_
    #endinput
#endif
#define _detections_fly_

const __ac_fly_PlayerSync = 207;
IPacket:__ac_fly_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_FLY))
        return 1;

    new data[PR_OnFootSync];
    BS_IgnoreBits(bs, 8);
    BS_ReadOnFootSync(bs, data);
    
    if(data[PR_surfingVehicleId] != 0 || data[PR_position][2] < 1.0)
        return 1;

    new
        Float:x = data[PR_position][0],
        Float:y = data[PR_position][1],
        Float:z = data[PR_position][2];

    new const bool:is_falling = ((1128 <= data[PR_animationId] <= 1134) || ((958 <= data[PR_animationId] <= 962) && data[PR_weaponId] == WEAPON_PARACHUTE));
    
    // Since the distance is minimal we don't need to check for jumping
    new object = CA_RayCastLine(x, y, z, x, y, z - 3.0, x, x, x);
    if(!is_falling && !object)
    {
        Anticheat_Trigger(playerid, CHEAT_FLY);
        return 0;
    }

    return 1;
}