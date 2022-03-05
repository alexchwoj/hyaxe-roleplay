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
    SOUND_SUCCESS_TWO = 1138
};

native HY_PlayerPlaySound(playerid, soundid, Float:x = 0.0, Float:y = 0.0, Float:z = 0.0) = PlayerPlaySound;
#if defined _ALS_PlayerPlaySound
    #undef PlayerPlaySound
#else
    #define _ALS_PlayerPlaySound
#endif
#define PlayerPlaySound HY_PlayerPlaySound