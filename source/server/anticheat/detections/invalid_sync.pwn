#if defined _detections_invalid_sync_
    #endinput
#endif
#define _detections_invalid_sync_

const __ac_inv_sync_PlayerSync = 207;
IPacket:__ac_inv_sync_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_INVALID_SYNC))
        return 1;

    new data[PR_OnFootSync];
    BS_IgnoreBits(bs, 8);
    BS_ReadOnFootSync(bs, data);

    // Crashers
    if (Data_CheckValidity(data[PR_position][0]) || Data_CheckValidity(data[PR_position][1]) || Data_CheckValidity(data[PR_position][2]))
	{
		Anticheat_Trigger(playerid, CHEAT_INVALID_SYNC, 0);
        return 0;
	}

	if (Data_CheckOutputLimit(data[PR_position][0], 20000.0) || Data_CheckOutputLimit(data[PR_position][1], 20000.0) || Data_CheckOutputLimit(data[PR_position][2], 20000.0))
	{
        Anticheat_Trigger(playerid, CHEAT_INVALID_SYNC, 1);
        return 0;
	}

	if (Data_CheckValidity(data[PR_quaternion][0]) || Data_CheckValidity(data[PR_quaternion][1]) || Data_CheckValidity(data[PR_quaternion][2]) || Data_CheckValidity(data[PR_quaternion][3]))
	{
        Anticheat_Trigger(playerid, CHEAT_INVALID_SYNC, 2);
        return 0;
	}

    // Invert walk and wheel walk
    // source: https://gitlab.com/RcKoid/mod-s0beit-overlight/-/blob/master/src/cheat_samp.cpp#L940
    if (data[PR_animationId] < 1007 || data[PR_animationId] > 1060)
    {
        if (data[PR_quaternion][1] != 0.0 || data[PR_quaternion][2] != 0.0)
        {
            //printf("data[PR_quaternion][1] = %f, data[PR_quaternion][2] = %f, data[PR_animationId] = %d", data[PR_quaternion][1], data[PR_quaternion][2], data[PR_animationId]);
            Anticheat_Trigger(playerid, CHEAT_INVALID_SYNC, 4);
            return 0;
        }
    }
    return 1;
}