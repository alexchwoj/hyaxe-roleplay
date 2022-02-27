#if defined _notification_callbacks_
    #endinput
#endif
#define _notification_callbacks_

public OnPlayerConnect(playerid)
{
    for(new i = 0; i < MAX_NOTIFICATIONS; i++)
    {
        NOTIFICATION_DATA[playerid][i][notificationActive] = false;
        PlayerTextDrawDestroy(playerid, NOTIFICATION_DATA[playerid][i][notificationTextdraw][0]);
        PlayerTextDrawDestroy(playerid, NOTIFICATION_DATA[playerid][i][notificationTextdraw][1]);
        PlayerTextDrawDestroy(playerid, NOTIFICATION_DATA[playerid][i][notificationTextdraw][2]);
    }

    #if defined NOTI_OnPlayerConnect
        return NOTI_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect NOTI_OnPlayerConnect
#if defined NOTI_OnPlayerConnect
    forward NOTI_OnPlayerConnect(playerid);
#endif

forward DestroyPlayerNotification(playerid, index);
public DestroyPlayerNotification(playerid, index)
{
    NOTIFICATION_DATA[playerid][index][notificationActive] = false;
    NOTIFICATION_DATA[playerid][index][notificationText] = EOS;
    PlayerTextDrawDestroy(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0]);
    PlayerTextDrawDestroy(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1]);
    PlayerTextDrawDestroy(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2]);
    KillTimer(NOTIFICATION_DATA[playerid][index][notificationFrameTimer]);
    return 1;
}

forward NotificationMoveToRight(playerid, index, seconds, Float:pos_y, Float:max, count);
public NotificationMoveToRight(playerid, index, seconds, Float:pos_y, Float:max, count)
{
	NOTIFICATION_DATA[playerid][index][notificationFrameCount] += count;

    new Float:pct = floatdiv(NOTIFICATION_DATA[playerid][index][notificationFrameCount], max);
    new Float:pos_x = lerp(0.0, 100.0, easeOutBack(pct));

    PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], (55.000000 - 100.0) + pos_x, pos_y);
    PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], (100.000000 - 100.0) + pos_x, pos_y);
    PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], (22.000000 - 100.0) + pos_x, pos_y + 1.0);

    NotificationShowAll(playerid, index);
    
	if (pct >= 1.0)
	{
		NOTIFICATION_DATA[playerid][index][notificationFrameCount] = 0;
		KillTimer(NOTIFICATION_DATA[playerid][index][notificationFrameTimer]);
		//SetTimerEx("WaitToLeft", 1000, false, "dffffd", playerid, 120.0, 150.0, -90.0, max, count);
	}

	return 1;
}