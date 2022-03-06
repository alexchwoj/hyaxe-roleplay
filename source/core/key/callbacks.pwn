#if defined _KEY_CALLBACKS_
    #endinput
#endif
#define _KEY_CALLBACKS_

public OnPlayerDisconnect(playerid, reason)
{
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
    g_rgeKeyData[playerid][e_bKeyActived] = false;
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
    new info[4];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, info);
    if (info[0] == 0x4B4559)
    {
        if (g_rgeKeyData[playerid][e_bKeyActived])
        {
            if (Perfomance_IsFine(playerid) && !g_rgeKeyData[playerid][e_bKeyGoingUp])
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
    new info[4];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, info);
    if (info[0] == 0x4B4559)
    {
        if (GetPlayerVirtualWorld(playerid) == info[1] && GetPlayerInterior(playerid) == info[2])
        {
            new string[64];
            format(string, sizeof(string), "PULSA ~y~\"%s\"", Key_GetName(info[3]));
            PlayerTextDrawSetString(playerid, p_tdKey_Text{playerid}, string);

            if (!g_rgeKeyData[playerid][e_bKeyActived])
            {
                g_rgeKeyData[playerid][e_bKeyActived] = true;

                if (Perfomance_IsFine(playerid))
                {
                    g_rgeKeyData[playerid][e_iKeyTimer] = SetTimerEx("KEY_MoveToBottom", 10, true, "ifd", playerid, 300.0, 4);
                }
                else
                {
                    PlayerTextDrawSetPos(playerid, p_tdKey_BG{playerid}, 323.000000, 11.000000);
                    PlayerTextDrawSetPos(playerid, p_tdKey_Text{playerid}, 323.000000, 9.000000);
                    Key_ShowAll(playerid);

                    g_rgeKeyData[playerid][e_iKeyTimer] = SetTimerEx("KEY_HideAlert", 3000, false, "i", playerid);
                }
            }
            else Key_ShowAll(playerid);
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

