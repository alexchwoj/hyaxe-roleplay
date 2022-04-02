#if defined _utils_sounds_
    #endinput
#endif
#define _utils_sounds_

enum _:eServerSounds
{
    SOUND_NEXT = 14405,
    SOUND_BACK = 14404,
    SOUND_ERROR = 1085,
    SOUND_BUTTON = 17803,
    SOUND_TRUMPET = 31205,
    SOUND_SENT = 40404,
    SOUND_SUCCESS = 1150,
    SOUND_SUCCESS_ONE = 1137,
    SOUND_SUCCESS_TWO = 1138,
    SOUND_CAR_DOORS = 24600,
    SOUND_EAT = 32200,
    SOUND_PUKE = 32201,
    SOUND_DRESSING = 20800
};

new
    g_rgeDressingSounds[] = {20800, 5602, 5601, 5600},
    g_rgeDropSounds[] = {17805, 4603}
;

native HY_PlayerPlaySound(playerid, soundid, Float:x = 0.0, Float:y = 0.0, Float:z = 0.0) = PlayerPlaySound;
#if defined _ALS_PlayerPlaySound
    #undef PlayerPlaySound
#else
    #define _ALS_PlayerPlaySound
#endif
#define PlayerPlaySound HY_PlayerPlaySound

Sound_PlayInRange(soundid, Float:range, Float:x, Float:y, Float:z, worldid = -1, interiorid = -1)
{
    foreach(new i : Player)
    {
        if(worldid != -1)
        {
            if(GetPlayerVirtualWorld(i) != worldid)
                continue;
        }

        if(interiorid != -1)
        {
            if(GetPlayerInterior(i) != interiorid)
                continue;
        }

        if(!IsPlayerInRangeOfPoint(i, range, x, y, z))
            continue;

        PlayerPlaySound(i, soundid, x, y, z);
    }

    return 1;
}
