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
            // bg: 11.000000 text: 9.000000
            new string[64];
            format(string, sizeof(string), "PULSA ~y~\"%s\"", Key_GetName(info[3]));
            PlayerTextDrawSetString(playerid, p_tdKey_Text{playerid}, string);
            Key_ShowAll(playerid);
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
