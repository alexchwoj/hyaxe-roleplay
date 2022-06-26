#if defined _KEY_CALLBACKS_
    #endinput
#endif
#define _KEY_CALLBACKS_

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(g_rgeKeyData[playerid][e_iKeyTimer]);
    g_rgeKeyData[playerid] = g_rgeKeyData[MAX_PLAYERS];

    #if defined KEY_OnPlayerDisconnect
        return KEY_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect KEY_OnPlayerDisconnect
#if defined KEY_OnPlayerDisconnect
    forward KEY_OnPlayerDisconnect(playerid, reason);
#endif


forward KEY_HideAlert(playerid);
public KEY_HideAlert(playerid)
{
    KillTimer(g_rgeKeyData[playerid][e_iKeyTimer]);
    PlayerTextDrawHide(playerid, p_tdKey_BG{playerid});
    PlayerTextDrawHide(playerid, p_tdKey_Text{playerid});
    g_rgeKeyData[playerid][e_bKeyActivated] = false;
    g_rgeKeyData[playerid][e_bKeyGoingUp] = false;
    return 1;
}

forward KEY_MoveToTop(playerid, Float:max, count);
public KEY_MoveToTop(playerid, Float:max, count)
{
    g_rgeKeyData[playerid][e_iKeyFrameCount] -= count;

    new Float:pct = floatdiv(g_rgeKeyData[playerid][e_iKeyFrameCount], max);
    new Float:pos_y = lerp(0.0, -17.0, easeInOutCubic(pct));

    PlayerTextDrawSetPos(playerid, p_tdKey_BG{playerid}, 323.000000, 6.000000 - pos_y);
    PlayerTextDrawSetPos(playerid, p_tdKey_Text{playerid}, 323.000000, 8.000000 - pos_y);

    Key_ShowAll(playerid);
    
	if (pct <= -1.0)
	{
		g_rgeKeyData[playerid][e_iKeyFrameCount] = 0;
        KEY_HideAlert(playerid);
	}

	return 1;
}

forward KEY_WaitToTop(playerid, Float:max, count);
public KEY_WaitToTop(playerid, Float:max, count)
{
    g_rgeKeyData[playerid][e_bKeyGoingUp] = true;
    g_rgeKeyData[playerid][e_iKeyTimer] = SetTimerEx("KEY_MoveToTop", 10, true, "ifd", playerid, max, count);
    return 1;
}

forward KEY_MoveToBottom(playerid, Float:max, count);
public KEY_MoveToBottom(playerid, Float:max, count)
{
    g_rgeKeyData[playerid][e_iKeyFrameCount] += count;

    new Float:pct = floatdiv(g_rgeKeyData[playerid][e_iKeyFrameCount], max);
    new Float:pos_y = lerp(0.0, 17.0, easeOutBack(pct));

    PlayerTextDrawSetPos(playerid, p_tdKey_BG{playerid}, 323.000000, -11.000000 + pos_y);
    PlayerTextDrawSetPos(playerid, p_tdKey_Text{playerid}, 323.000000, -9.000000 + pos_y);

    Key_ShowAll(playerid);
    
	if (pct >= 1.0)
	{
		g_rgeKeyData[playerid][e_iKeyFrameCount] = 0;
		KillTimer(g_rgeKeyData[playerid][e_iKeyTimer]);

        g_rgeKeyData[playerid][e_iKeyTimer] = SetTimerEx("KEY_WaitToTop", 3000, false, "idf", playerid, max, count);
	}

	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    if(Streamer_HasArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4B4559)))
    {
        if (g_rgeKeyData[playerid][e_bKeyActivated])
        {
            if ((Performance_IsFine(playerid) && !Bit_Get(Player_Config(playerid), CONFIG_PERFORMANCE_MODE)) && !g_rgeKeyData[playerid][e_bKeyGoingUp])
            {
                g_rgeKeyData[playerid][e_iKeyFrameCount] = 0;
                KillTimer(g_rgeKeyData[playerid][e_iKeyTimer]);
                g_rgeKeyData[playerid][e_iKeyTimer] = SetTimerEx("KEY_MoveToTop", 10, true, "ifd", playerid, 300.0, 4);
            }
            else KEY_HideAlert(playerid);
        }
    }

    #if defined KEY_OnPlayerLeaveDynamicArea
        return KEY_OnPlayerLeaveDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerLeaveDynamicArea
    #undef OnPlayerLeaveDynamicArea
#else
    #define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea KEY_OnPlayerLeaveDynamicArea
#if defined KEY_OnPlayerLeaveDynamicArea
    forward KEY_OnPlayerLeaveDynamicArea(playerid, areaid);
#endif


public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if (Streamer_HasArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4B4559)))
    {
        new info[3];
        Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4B4559), info);

        new string[64];
        format(string, sizeof(string), "PULSA ~y~\"~k~~%s~\"", (info[1] == KEY_TYPE_FOOT ? g_rgszKeyFootCode[ info[0] ] : g_rgszKeyVehicleCode[ info[0] ]));

        PlayerTextDrawSetString(playerid, p_tdKey_Text{playerid}, string);

        if (!g_rgeKeyData[playerid][e_bKeyActivated])
        {
            g_rgeKeyData[playerid][e_bKeyActivated] = true;

            if (Performance_IsFine(playerid) && !Bit_Get(Player_Config(playerid), CONFIG_PERFORMANCE_MODE))
            {
                g_rgeKeyData[playerid][e_iKeyTimer] = SetTimerEx("KEY_MoveToBottom", 10, true, "ifd", playerid, 300.0, 4);
            }
            else
            {
                PlayerTextDrawSetPos(playerid, p_tdKey_BG{playerid}, 323.000000, 6.000000);
                PlayerTextDrawSetPos(playerid, p_tdKey_Text{playerid}, 323.000000, 8.000000);
                Key_ShowAll(playerid);

                g_rgeKeyData[playerid][e_iKeyTimer] = SetTimerEx("KEY_HideAlert", 3000, false, "i", playerid);
            }
        }
        else Key_ShowAll(playerid);
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

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new areas = GetPlayerNumberDynamicAreas(playerid);
    if(areas > 0)
    {
        new area_arr[1][] = { { } };
        new Var:v = amx_alloc(areas);
        amx_to_ref(v, area_arr);

        GetPlayerDynamicAreas(playerid, area_arr[0], areas);

        for(new i; i < areas; ++i)
        {
            if(Streamer_HasArrayData(STREAMER_TYPE_AREA, area_arr[0][i], E_STREAMER_CUSTOM(0x4B4559)))
            {
                new info[3];
                Streamer_GetArrayData(STREAMER_TYPE_AREA, area_arr[0][i], E_STREAMER_CUSTOM(0x4B4559), info);

                if(info[2] == -1)
                    break;

                if((newkeys & Key_KeyNameToKeyBit(info[0])) != 0)
                {
                    if(info[1] == KEY_TYPE_VEHICLE && !IsPlayerInAnyVehicle(playerid))
                        break;

                    new callback = info[2];
                    __emit {                // callback(playerid)
                        push.s playerid     // playerid
                        push.c 4
                        lctrl 6
                        add.c 0x24
                        lctrl 8
                        push.pri
                        load.s.pri callback
                        sctrl 6
                    }
                }

                break;
            }
        }

        amx_free(v);
        amx_delete(v);
    }

    #if defined KEY_OnPlayerKeyStateChange
        return KEY_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange KEY_OnPlayerKeyStateChange
#if defined KEY_OnPlayerKeyStateChange
    forward KEY_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
