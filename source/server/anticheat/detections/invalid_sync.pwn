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
    /*if (Data_CheckValidity(data[PR_position][0]) || Data_CheckValidity(data[PR_position][1]) || Data_CheckValidity(data[PR_position][2]))
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
	}*/

    // Invert walk and wheel walk
    if (data[PR_quaternion][1] != 0.0 || data[PR_quaternion][2] != 0.0)
    {
        Anticheat_Trigger(playerid, CHEAT_INVALID_SYNC, 4);
        return 0;
    }
    return 1;
}