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