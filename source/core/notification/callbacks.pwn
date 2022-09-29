#if defined _notification_callbacks_
    #endinput
#endif
#define _notification_callbacks_

static
    bool:s_rgbBeatingTextShouldHide[MAX_PLAYERS char];

public OnPlayerDisconnect(playerid, reason)
{
    for(new i = 0; i < MAX_NOTIFICATIONS; i++)
    {
        if (g_rgeNotificationData[playerid][i][e_bActive])
        {
            DestroyPlayerNotification(playerid, i);
        }
    }

    if (g_rgiTextProcessTimer[playerid])
        Timer_Kill(g_rgiTextProcessTimer[playerid]);
        
    s_rgbBeatingTextShouldHide{playerid} = false;

    #if defined NOTI_OnPlayerDisconnect
        return NOTI_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect NOTI_OnPlayerDisconnect
#if defined NOTI_OnPlayerDisconnect
    forward NOTI_OnPlayerDisconnect(playerid, reason);
#endif

forward DestroyPlayerNotification(playerid, index);
public DestroyPlayerNotification(playerid, index)
{
    g_rgeNotificationData[playerid][index][e_bActive] = false;
    PlayerTextDrawDestroy(playerid, g_rgeNotificationData[playerid][index][e_tdTextdraw][0]);
    PlayerTextDrawDestroy(playerid, g_rgeNotificationData[playerid][index][e_tdTextdraw][1]);
    PlayerTextDrawDestroy(playerid, g_rgeNotificationData[playerid][index][e_tdTextdraw][2]);
    KillTimer(g_rgeNotificationData[playerid][index][e_iFrameTimer]);
    return 1;
}

forward NotificationMoveToLeft(playerid, index, Float:pos_y, Float:max, count);
public NotificationMoveToLeft(playerid, index, Float:pos_y, Float:max, count)
{
	g_rgeNotificationData[playerid][index][e_iFrameCount] -= count;

    new Float:pct = floatdiv(g_rgeNotificationData[playerid][index][e_iFrameCount], max);
    new Float:pos_x = lerp(0.0, -100.0, easeInOutCubic(pct));

    PlayerTextDrawSetPos(playerid, g_rgeNotificationData[playerid][index][e_tdTextdraw][0], 55.000000 - pos_x, pos_y);
    PlayerTextDrawSetPos(playerid, g_rgeNotificationData[playerid][index][e_tdTextdraw][1], 100.000000 - pos_x, pos_y);
    PlayerTextDrawSetPos(playerid, g_rgeNotificationData[playerid][index][e_tdTextdraw][2], 22.000000 - pos_x, pos_y + 1.0);

    NotificationShowAll(playerid, index);
    
	if (pct <= -1.0)
	{
		g_rgeNotificationData[playerid][index][e_iFrameCount] = 0;
		DestroyPlayerNotification(playerid, index);
	}

	return 1;
}

forward NotificationWaitToLeft(playerid, index, Float:pos_y, Float:max, count);
public NotificationWaitToLeft(playerid, index, Float:pos_y, Float:max, count)
{
    KillTimer(g_rgeNotificationData[playerid][index][e_iFrameTimer]);
    g_rgeNotificationData[playerid][index][e_iFrameTimer] = SetTimerEx("NotificationMoveToLeft", 15, true, "ddffd", playerid, index, pos_y, 300.0, count);
	return 1;
}

forward NotificationMoveToRight(playerid, index, time, Float:pos_y, Float:max, count);
public NotificationMoveToRight(playerid, index, time, Float:pos_y, Float:max, count)
{
	g_rgeNotificationData[playerid][index][e_iFrameCount] += count;

    new Float:pct = floatdiv(g_rgeNotificationData[playerid][index][e_iFrameCount], max);
    new Float:pos_x = lerp(0.0, 100.0, easeOutBack(pct));

    PlayerTextDrawSetPos(playerid, g_rgeNotificationData[playerid][index][e_tdTextdraw][0], -45.000000 + pos_x, pos_y);
    PlayerTextDrawSetPos(playerid, g_rgeNotificationData[playerid][index][e_tdTextdraw][1], 0.000000 + pos_x, pos_y);
    PlayerTextDrawSetPos(playerid, g_rgeNotificationData[playerid][index][e_tdTextdraw][2], -78.000000 + pos_x, pos_y + 1.0);

    NotificationShowAll(playerid, index);
    
	if (pct >= 1.0)
	{
		g_rgeNotificationData[playerid][index][e_iFrameCount] = 0;
		KillTimer(g_rgeNotificationData[playerid][index][e_iFrameTimer]);
        g_rgeNotificationData[playerid][index][e_iFrameTimer] = SetTimerEx("NotificationWaitToLeft", time, false, "ddffd", playerid, index, pos_y, 300.0, count);
	}

	return 1;
}

public NOTIFICATION_ProcessText(playerid, time, alpha_min, alpha_max)
{
    // false = out
    // true = in
    static bool:td_phase[MAX_PLAYERS char];

    new color = PlayerTextDrawGetColor(playerid, p_tdBeatingText{playerid});
    new current_alpha = (color & 0xFF);

    if (!s_rgbBeatingTextShouldHide{playerid})
    {
        if (!td_phase{playerid} && current_alpha <= alpha_min)
        {
            td_phase{playerid} = true;
        }
        else if (current_alpha >= alpha_max)
        {
            td_phase{playerid} = false;
        }

        current_alpha += (td_phase{playerid} ? NOTIFICATION_TEXT_BEAT_DIFF : -NOTIFICATION_TEXT_BEAT_DIFF);
    }
    else
    {
        if (current_alpha <= 0)
        {
            PlayerTextDrawHide(playerid, p_tdBeatingText{playerid});

            td_phase{playerid} = 
            s_rgbBeatingTextShouldHide{playerid} = 
            bool:(g_rgiTextProcessTick[playerid] = 0);
            Timer_Kill(g_rgiTextProcessTimer[playerid]);
            return 1;
        }

        current_alpha -= NOTIFICATION_TEXT_BEAT_DIFF;
    }

    color = (color & 0xFFFFFF00) | clamp(current_alpha, 0, 255);
    PlayerTextDrawColor(playerid, p_tdBeatingText{playerid}, color);
    PlayerTextDrawBackgroundColor(playerid, p_tdBeatingText{playerid}, current_alpha);
    PlayerTextDrawShow(playerid, p_tdBeatingText{playerid});

    if (!s_rgbBeatingTextShouldHide{playerid} && time < GetTickCount() - g_rgiTextProcessTick[playerid])
    {
        s_rgbBeatingTextShouldHide{playerid} = true;
    }

    return 1;
}

public NOTIFICATION_HideStaticPerfText(playerid)
{
    PlayerTextDrawHide(playerid, p_tdBeatingText{playerid});
    g_rgiTextProcessTimer[playerid] = 0;
    return 1;
}