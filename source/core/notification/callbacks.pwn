#if defined _notification_callbacks_
    #endinput
#endif
#define _notification_callbacks_

public OnPlayerDisconnect(playerid, reason)
{
    for(new i = 0; i < MAX_NOTIFICATIONS; i++)
    {
        if(NOTIFICATION_DATA[playerid][i][notificationActive])
        {
            DestroyPlayerNotification(playerid, i);
        }
    }

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
    NOTIFICATION_DATA[playerid][index][notificationActive] = false;
    PlayerTextDrawDestroy(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0]);
    PlayerTextDrawDestroy(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1]);
    PlayerTextDrawDestroy(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2]);
    KillTimer(NOTIFICATION_DATA[playerid][index][notificationFrameTimer]);
    return 1;
}

forward NotificationMoveToLeft(playerid, index, Float:pos_y, Float:max, count);
public NotificationMoveToLeft(playerid, index, Float:pos_y, Float:max, count)
{
	NOTIFICATION_DATA[playerid][index][notificationFrameCount] -= count;

    new Float:pct = floatdiv(NOTIFICATION_DATA[playerid][index][notificationFrameCount], max);
    new Float:pos_x = lerp(0.0, -100.0, easeInOutCubic(pct));

    PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 55.000000 - pos_x, pos_y);
    PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 100.000000 - pos_x, pos_y);
    PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 22.000000 - pos_x, pos_y + 1.0);

    NotificationShowAll(playerid, index);
    
	if (pct <= -1.0)
	{
		NOTIFICATION_DATA[playerid][index][notificationFrameCount] = 0;
		DestroyPlayerNotification(playerid, index);
	}

	return 1;
}

forward NotificationWaitToLeft(playerid, index, Float:pos_y, Float:max, count);
public NotificationWaitToLeft(playerid, index, Float:pos_y, Float:max, count)
{
    KillTimer(NOTIFICATION_DATA[playerid][index][notificationFrameTimer]);
    NOTIFICATION_DATA[playerid][index][notificationFrameTimer] = SetTimerEx("NotificationMoveToLeft", 10, true, "ddffd", playerid, index, pos_y, 300.0, 5);
	return 1;
}

forward NotificationMoveToRight(playerid, index, seconds, Float:pos_y, Float:max, count);
public NotificationMoveToRight(playerid, index, seconds, Float:pos_y, Float:max, count)
{
	NOTIFICATION_DATA[playerid][index][notificationFrameCount] += count;

    new Float:pct = floatdiv(NOTIFICATION_DATA[playerid][index][notificationFrameCount], max);
    new Float:pos_x = lerp(0.0, 100.0, easeOutBack(pct));

    PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], -45.000000 + pos_x, pos_y);
    PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 0.000000 + pos_x, pos_y);
    PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], -78.000000 + pos_x, pos_y + 1.0);

    NotificationShowAll(playerid, index);
    
	if (pct >= 1.0)
	{
		NOTIFICATION_DATA[playerid][index][notificationFrameCount] = 0;
		KillTimer(NOTIFICATION_DATA[playerid][index][notificationFrameTimer]);
        NOTIFICATION_DATA[playerid][index][notificationFrameTimer] = SetTimerEx("NotificationWaitToLeft", 1000 * seconds, false, "ddffd", playerid, index, pos_y, 300.0, 5);
	}

	return 1;
}