#if defined _notification_functions_
    #endinput
#endif
#define _notification_functions_


static GetFreeNotificationSlot(playerid)
{
    for(new i; i < MAX_NOTIFICATIONS; ++i)
	{
		if (!NOTIFICATION_DATA[playerid][i][notificationActive])
		    return i;
	}
    return MAX_NOTIFICATIONS + 1;
}

static NotificationShowAll(playerid, index)
{
    PlayerTextDrawShow(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0]);
    PlayerTextDrawShow(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1]);
    PlayerTextDrawShow(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2]);
    return 1;
}

static CreateNotificationTD(playerid, index, const text[], color)
{
    NOTIFICATION_DATA[playerid][index][notificationTextdraw][0] = CreatePlayerTextDraw(playerid, 55.000000, 135.000000, !"_");
    PlayerTextDrawFont(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 1);
    PlayerTextDrawLetterSize(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 0.574999, 4.399980);
    PlayerTextDrawTextSize(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 298.500000, 75.000000);
    PlayerTextDrawSetOutline(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 1);
    PlayerTextDrawSetShadow(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 0);
    PlayerTextDrawAlignment(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 2);
    PlayerTextDrawColor(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], -1);
    PlayerTextDrawBackgroundColor(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 255);
    PlayerTextDrawBoxColor(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], color);
    PlayerTextDrawUseBox(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 1);
    PlayerTextDrawSetProportional(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 1);
    PlayerTextDrawSetSelectable(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 0);

    NOTIFICATION_DATA[playerid][index][notificationTextdraw][1] = CreatePlayerTextDraw(playerid, 100.000000, 135.000000, !"_");
    PlayerTextDrawFont(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 1);
    PlayerTextDrawLetterSize(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 0.975000, 4.399980);
    PlayerTextDrawTextSize(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 281.500000, 159.500000);
    PlayerTextDrawSetOutline(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 1);
    PlayerTextDrawSetShadow(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 0);
    PlayerTextDrawAlignment(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 2);
    PlayerTextDrawColor(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], -1);
    PlayerTextDrawBackgroundColor(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 255);
    PlayerTextDrawBoxColor(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 454761471);
    PlayerTextDrawUseBox(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 1);
    PlayerTextDrawSetProportional(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 1);
    PlayerTextDrawSetSelectable(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 0);

    NOTIFICATION_DATA[playerid][index][notificationTextdraw][2] = CreatePlayerTextDraw(playerid, 22.000000, 136.000000, text);
    PlayerTextDrawFont(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 1);
    PlayerTextDrawLetterSize(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 0.174999, 1.049999);
    PlayerTextDrawTextSize(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 0);
    PlayerTextDrawSetShadow(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 0);
    PlayerTextDrawAlignment(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 1);
    PlayerTextDrawColor(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], -134744065);
    PlayerTextDrawBackgroundColor(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 255);
    PlayerTextDrawBoxColor(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 50);
    PlayerTextDrawUseBox(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 0);
    PlayerTextDrawSetProportional(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 1);
    PlayerTextDrawSetSelectable(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 0);

    return 1;
}

Notification_Show(playerid, const text[], seconds, color = 0xCB3126FF)
{
    new index = GetFreeNotificationSlot(playerid);
    if (index > MAX_NOTIFICATIONS)
        return 0;

    NOTIFICATION_DATA[playerid][index][notificationActive] = true;
    strcat(NOTIFICATION_DATA[playerid][index][notificationText], text);

    NOTIFICATION_DATA[playerid][index][notificationSeconds] = seconds;

    NOTIFICATION_DATA[playerid][index][notificationFrameCount] = 0;
    KillTimer(NOTIFICATION_DATA[playerid][index][notificationFrameTimer]);

    new count;
    for (new i = 0, len = strlen(NOTIFICATION_DATA[playerid][index][notificationText]); i <= len; i++)
	{
        if (count >= 50 && NOTIFICATION_DATA[playerid][index][notificationText][i] == ' ')
        {
            strins(NOTIFICATION_DATA[playerid][index][notificationText], "~n~", i + 1);
            count = 0;
        }
        count ++;
    }

    CreateNotificationTD(playerid, index, NOTIFICATION_DATA[playerid][index][notificationText], color);

    new lines = GetTextDrawLineCount(NOTIFICATION_DATA[playerid][index][notificationText]);
    NOTIFICATION_DATA[playerid][index][notificationHeight] += (lines * 1.0) + 0.3;
    
    PlayerTextDrawLetterSize(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 0.975000, NOTIFICATION_DATA[playerid][index][notificationHeight]);
    PlayerTextDrawLetterSize(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 0.975000, NOTIFICATION_DATA[playerid][index][notificationHeight]);

    if (index)
    {
        new Float:pos_x, Float:pos_y;
        PlayerTextDrawGetPos(playerid, NOTIFICATION_DATA[playerid][index - 1][notificationTextdraw][0], pos_x, pos_y);
        #pragma unused pos_x

        lines = GetTextDrawLineCount(NOTIFICATION_DATA[playerid][index - 1][notificationText]);
        if (!lines) pos_y += 10.0;

        pos_y += (lines * 10.0) + 10.0;

        PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 55.000000, pos_y);
        PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 100.000000, pos_y);
        PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 22.000000, pos_y + 1.0);
    }

    /*if (GetPlayerPing(playerid) <= 300 || NetStats_PacketLossPercent(playerid) <= 4.5)
    {

    }
    else
    {
        _NotificationShowAll(playerid, index);
        NOTIFICATION_DATA[playerid][index][notificationFrameTimer] = SetTimerEx("DestroyPlayerNotification", 1000 * seconds, false, "ii", playerid, index);
    }*/

    NotificationShowAll(playerid, index);
    NOTIFICATION_DATA[playerid][index][notificationFrameTimer] = SetTimerEx("DestroyPlayerNotification", 1000 * seconds, false, "ii", playerid, index);
    return 1;
}

CMD:notification(playerid, params[])
{
    Notification_Show(playerid, "Fusce et odio sagittis, tincidunt justo eget, posuere neque. Donec tempor dolor id velit viverra pellentesque. Suspendisse dictum augue ac sapien consectetur pellentesque.", 10);
    return 1;
}

CMD:notification2(playerid, params[])
{
    Notification_Show(playerid, "Fusce et odio sagittis, tincidunt justo eget, posuere neque. Donec tempor dolor id velit viverra pellentesque. Suspendisse dictum augue ac sapien consectetur pellentesque. Aenean vestibulum varius consequat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nullam nec semper lectus, ut semper odio. Etiam eget dapibus dolor.", 10);
    return 1;
}

CMD:notification3(playerid, params[])
{
    Notification_Show(playerid, "Bienvenido a hyaxe roleplay.", 10);
    return 1;
}