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

    if((1061 <= animation_id <= 1067) || (1195 <= animation_id <= 1198))
        return 1;
    
    if(pos_z - Player_Data(playerid, e_fPosZ) > 1.0 && speed_z == 0.0 && s_rgfLastSpeedZ[playerid] == 0.0 && (!animation_id || (1253 <= animation_id <= 1273) || (1222 <= animation_id <= 1236)))
    {
        printf("animation_id = %i", animation_id);
        if(Anticheat_Trigger(playerid, CHEAT_AIRBREAK, 1))
            return 0;
    }

    s_rgfLastSpeedZ[playerid] = speed_z;

    return 1;
}

static
    Float:s_rgfLastVehZSpeed[MAX_VEHICLES],
    Float:s_rgfLastVehPosX[MAX_VEHICLES],
    Float:s_rgfLastVehPosY[MAX_VEHICLES],
    Float:s_rgfLastVehPosZ[MAX_VEHICLES];

const __ac_ab_VehicleSync = 200;
IPacket:__ac_ab_VehicleSync(playerid, BitStream:bs)
{
    if(Player_HasImmunityForCheat(playerid, CHEAT_AIRBREAK))
        return 1;

    new data[PR_InCarSync];

    BS_IgnoreBits(bs, 8);
    BS_ReadInCarSync(bs, data);

    /*
    printf("data = {");
    printf("    vehicleId = %i,", data[PR_vehicleId]);
    printf("    lrKey = %i,", data[PR_lrKey]);
    printf("    udKey = %i,", data[PR_udKey]);
    printf("    keys = %i,", data[PR_keys]);
    printf("    quaternion = { %f, %f, %f, %f },", data[PR_quaternion][0],data[PR_quaternion][1], data[PR_quaternion][2], data[PR_quaternion][3]);
    printf("    position = { %f, %f, %f },", data[PR_position][0], data[PR_position][1], data[PR_position][2]);
    printf("    velocity = { %f, %f, %f },", data[PR_velocity][0], data[PR_velocity][1], data[PR_velocity][2]);
    printf("    vehicleHealth = %f,", data[PR_vehicleHealth]);
    printf("    playerHealth = %i,", data[PR_playerHealth]);
    printf("    armour = %i,", data[PR_armour]);
    printf("    additionalKey = %i,", data[PR_additionalKey]);
    printf("    weaponId = %i,", data[PR_weaponId]);
    printf("    sirenState = %i,", data[PR_sirenState]);
    printf("    landingGearState = %i,", data[PR_landingGearState]);
    printf("    trailerId = %i,", data[PR_trailerId]);
    printf("    trainSpeed = %f", data[PR_trainSpeed]);
    printf("}");
    */

    return 1;
}
