#if defined _detections_invisible_
    #endinput
#endif
#define _detections_invisible_

const __ac_invi_PlayerSync = 207;
IPacket:__ac_invi_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_FLY))
        return 1;

    new data[PR_OnFootSync];
    BS_IgnoreBits(bs, 8);
    BS_ReadOnFootSync(bs, data);

    // source: https://github.com/Stickey21/Stealth-Remastered/blob/f8a49894bbc42ef200286709d6dfe73379871cd3/Stealth%20Remastered/SAMP/RakNet/RakClient.cpp#L181
    if (data[PR_surfingVehicleId] != 0 || data[PR_surfingVehicleId] != INVALID_VEHICLE_ID)
    {
        if ((floatabs(data[PR_surfingOffsets][0]) >= 50.0) || (floatabs(data[PR_surfingOffsets][1]) >= 50.0) || (floatabs(data[PR_surfingOffsets][2]) >= 50.0) || (floatabs(data[PR_surfingOffsets][2]) <= -35.0))
        {
            data[PR_surfingOffsets][0] = 0.0;
            data[PR_surfingOffsets][1] = 0.0;
            data[PR_surfingOffsets][2] = 0.0;

            BS_SetWriteOffset(bs, 8);
            BS_WriteOnFootSync(bs, data);
        }
    }
    return 1;
}