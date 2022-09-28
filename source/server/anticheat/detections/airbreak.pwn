#if defined _detections_airbreak_
    #endinput
#endif
#define _detections_airbreak_

static
    Float:s_rgfLastSpeedZ[MAX_PLAYERS];

const __ac_ab_PlayerSync = 207;
IPacket:__ac_ab_PlayerSync(playerid, BitStream:bs)
{
    if(Player_HasImmunityForCheat(playerid, CHEAT_AIRBREAK))
        return 1;

    new 
        Float:pos_z, Float:speed_z,
        animation_id;

    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8 + 16 + 16 + 16 + (32 * 2),
        PR_FLOAT, pos_z,
        PR_IGNORE_BITS, (32 * 4) + 8 + 8 + 2 + 6 + 8 + (32 * 2),
        PR_FLOAT, speed_z,
        PR_IGNORE_BITS, (32 * 3) + 16,
        PR_INT16, animation_id
    );

    if(pos_z - Player_Data(playerid, e_fPosZ) > 1.0 && speed_z == 0.0 && s_rgfLastSpeedZ[playerid] == 0.0 && (!animation_id || (1253 <= animation_id <= 1273) || (1222 <= animation_id <= 1236) || (1062 <= animation_id <= 1065)))
    {
        if(Anticheat_Trigger(playerid, CHEAT_AIRBREAK, 1))
            return 0;
    }

    s_rgfLastSpeedZ[playerid] = speed_z;

    return 1;
}