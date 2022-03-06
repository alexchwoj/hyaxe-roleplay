#if defined _KEY_CALLBACKS_
    #endinput
#endif
#define _KEY_CALLBACKS_


public OnPlayerEnterDynamicArea(playerid, areaid)
{
    new info[4];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, info);
    if (info[0] == 0x4B4559)
    {
        if (GetPlayerVirtualWorld(playerid) == info[1] && GetPlayerInterior(playerid) == info[2])
        {
            SendClientMessage(playerid, -1, Key_GetName(info[3]));
        }
    }

    #if defined KEY_OnPlayerEnterDynamicArea
        return KEY_OnPlayerEnterDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicArea
    #undef OnPlayerEnterDynamicArea
#else
    #define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea KEY_OnPlayerEnterDynamicArea
#if defined KEY_OnPlayerEnterDynamicArea
    forward KEY_OnPlayerEnterDynamicArea(playerid, areaid);
#endif
