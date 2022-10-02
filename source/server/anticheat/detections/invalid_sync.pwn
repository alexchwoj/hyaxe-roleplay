#if defined _detections_invalid_sync_
    #endinput
#endif
#define _detections_invalid_sync_

const __ac_inv_sync_PlayerSync = 207;
IPacket:__ac_inv_sync_PlayerSync(playerid, BitStream:bs)
{
    if (Player_HasImmunityForCheat(playerid, CHEAT_INVALID_SYNC))
        return 1;

    new
        Float:pos_x, Float:pos_y, Float:pos_z,
        Float:quaternion_x, Float:quaternion_y, Float:quaternion_z, Float:quaternion_w,
        animation_id;
    
    BS_ReadValue(bs,
        PR_IGNORE_BITS, 8 + 16 + 16 + 16,
        PR_FLOAT, pos_x, 
        PR_FLOAT, pos_y,
        PR_FLOAT, pos_z,
        PR_FLOAT, quaternion_x,
        PR_FLOAT, quaternion_y,
        PR_FLOAT, quaternion_z,
        PR_FLOAT, quaternion_w,
        PR_IGNORE_BITS, 8 + 8 + 2 + 6 + 8 + (32 * 6) + 16,
        PR_INT16, animation_id
    );

    // Crashers
    if (Data_CheckValidity(pos_x) || Data_CheckValidity(pos_y) || Data_CheckValidity(pos_z))
	{
		Anticheat_Trigger(playerid, CHEAT_INVALID_SYNC, 0);
        return 0;
	}

	if (Data_CheckOutputLimit(pos_x, 20000.0) || Data_CheckOutputLimit(pos_y, 20000.0) || Data_CheckOutputLimit(pos_z, 20000.0))
	{
        Anticheat_Trigger(playerid, CHEAT_INVALID_SYNC, 1);
        return 0;
	}

	if (Data_CheckValidity(quaternion_x) || Data_CheckValidity(quaternion_y) || Data_CheckValidity(quaternion_z) || Data_CheckValidity(quaternion_w))
	{
        Anticheat_Trigger(playerid, CHEAT_INVALID_SYNC, 2);
        return 0;
	}

    // Invert walk and wheel walk
    // source: https://gitlab.com/RcKoid/mod-s0beit-overlight/-/blob/master/src/cheat_samp.cpp#L940
    //printf("data[PR_animationId] = %d", data[PR_animationId]);
    if (animation_id == 1231)
    {
        if (quaternion_y != 0.0 || quaternion_z != 0.0)
        {
            //printf("quaternion_y = %f, quaternion_z = %f, data[PR_animationId] = %d", quaternion_y, quaternion_z, data[PR_animationId]);
            Anticheat_Trigger(playerid, CHEAT_INVALID_SYNC, 4);
            return 0;
        }
    }

    return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
    printf("[func] OnVehicleRespray(playerid = %i, vehicleid = %i (model: %i), color1 = %i, color2 = %i)", playerid, vehicleid, GetVehicleModel(vehicleid), color1, color2);
    Anticheat_Trigger(playerid, CHEAT_INVALID_BANNED_SYNC, 0);
    return 0;
}
