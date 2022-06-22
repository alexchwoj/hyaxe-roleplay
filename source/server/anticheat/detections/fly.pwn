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
    
    if(data[PR_specialAction] == SPECIAL_ACTION_USEJETPACK)
    {
        Anticheat_Trigger(playerid, CHEAT_FLY);
        return 0;
    }

    if(data[PR_surfingVehicleId] != 0 || data[PR_position][2] < 1.0)
        return 1;
    
    if((958 <= data[PR_animationId] <= 959) && data[PR_weaponId] != WEAPON_PARACHUTE)
    {
        Anticheat_Trigger(playerid, CHEAT_FLY);
        return 0;
    }

    if(157 <= data[PR_animationId] <= 162)
    {
        Anticheat_Trigger(playerid, CHEAT_FLY);
        return 0;
    }

    new Float:dummy;
    if(((1538 <= data[PR_animationId] <= 1544) || data[PR_animationId] == 1250) && !CA_IsPlayerInWater(playerid, dummy, dummy))
    {
        Anticheat_Trigger(playerid, CHEAT_FLY);
        return 0;
    }

    return 1;
}