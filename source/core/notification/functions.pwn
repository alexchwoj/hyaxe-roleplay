#if defined _notification_functions_
    #endinput
#endif
#define _notification_functions_

Float:easeInOutCubic(Float:t)
{
    return t < 0.5 ? 4.0 * t * t * t : 1.0 + (--t) * (2.0 * (--t)) * (2.0 * t);
}

Float:easeOutBack(Float:t)
{
    return 1.0 + (--t) * t * (2.70158 * t + 1.70158);
}

static GetFreeNotificationSlot(playerid)
{
    for(new i; i < MAX_NOTIFICATIONS; ++i)
	{
		if (!NOTIFICATION_DATA[playerid][i][notificationActive])
		    return i;
	}
    return MAX_NOTIFICATIONS + 1;
}

NotificationShowAll(playerid, index)
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

Notification_Show(playerid, const text[], time, color = 0xCB3126FF)
{
    new index = GetFreeNotificationSlot(playerid);
    if (index > MAX_NOTIFICATIONS)
        return 0;

    NOTIFICATION_DATA[playerid][index][notificationActive] = true;
    NOTIFICATION_DATA[playerid][index][notificationFrameCount] = 0;
    NOTIFICATION_DATA[playerid][index][notificationHeight] = 0.0;
    KillTimer(NOTIFICATION_DATA[playerid][index][notificationFrameTimer]);

    new fixed_text[512];
    strcat(fixed_text, text);
    Str_FixEncoding_Ref(fixed_text);

    SplitTextDrawString(fixed_text, 155.0, 0.174999, 1, 0, true);
    CreateNotificationTD(playerid, index, fixed_text, color);

    new line_count = GetTextDrawLineCount(fixed_text);
    NOTIFICATION_DATA[playerid][index][notificationHeight] += float(line_count) + 0.3;
    
    PlayerTextDrawLetterSize(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 0.975000, NOTIFICATION_DATA[playerid][index][notificationHeight]);
    PlayerTextDrawLetterSize(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 0.975000, NOTIFICATION_DATA[playerid][index][notificationHeight]);

    new Float:pos_y = 135.000000;
    if (index)
    {
        new Float:pos_x;
        PlayerTextDrawGetPos(playerid, NOTIFICATION_DATA[playerid][index - 1][notificationTextdraw][0], pos_x, pos_y);
        #pragma unused pos_x

        PlayerTextDrawGetString(playerid, NOTIFICATION_DATA[playerid][index - 1][notificationTextdraw][2], fixed_text);
        line_count = GetTextDrawLineCount(fixed_text);
        pos_y += (line_count * 10.0) + 10.0;

        PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][0], 55.000000, pos_y);
        PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][1], 100.000000, pos_y);
        PlayerTextDrawSetPos(playerid, NOTIFICATION_DATA[playerid][index][notificationTextdraw][2], 22.000000, pos_y + 1.0);
    }

    if (!Bit_Get(Player_Config(playerid), CONFIG_PERFORMANCE_MODE) && Performance_IsFine(playerid))
    {
        NOTIFICATION_DATA[playerid][index][notificationFrameTimer] = SetTimerEx("NotificationMoveToRight", 10, true, "dddffd", playerid, index, time, pos_y, 300.0, 5);
    }
    else
    {
        NotificationShowAll(playerid, index);
        NOTIFICATION_DATA[playerid][index][notificationFrameTimer] = SetTimerEx("DestroyPlayerNotification", time, false, "ii", playerid, index);
    }
    return 1;
}

Notification_ShowBeatingText(playerid, time, color, alpha_min, alpha_max, const text[])
{
    new string[128];
    strcat(string, text);
    Str_FixEncoding_Ref(string);

    for(new i = strlen(string) - 1; i != -1; --i)
    {
        if(string[i] == ' ')
            string[i] = '_';
    }

    if(IsPlayerTextDrawVisible(playerid, p_tdBeatingText{playerid}))
    {
        new td_string[128];
        PlayerTextDrawGetString(playerid, p_tdBeatingText{playerid}, td_string);

        if(!strcmp(td_string, string))
        {
            return 0;
        }
    }

    if(g_rgiTextProcessTimer[playerid])
    {
        KillTimer(g_rgiTextProcessTimer[playerid]);
    }

    new td_color = (color << 8) ^ alpha_max;
    PlayerTextDrawColor(playerid, p_tdBeatingText{playerid}, td_color);
    PlayerTextDrawBackgroundColor(playerid, p_tdBeatingText{playerid}, alpha_max);
    PlayerTextDrawSetString(playerid, p_tdBeatingText{playerid}, string);
    PlayerTextDrawShow(playerid, p_tdBeatingText{playerid});

    g_rgiTextProcessTick[playerid] = GetTickCount();
    g_rgiTextProcessTimer[playerid] = SetTimerEx("NOTIFICATION_ProcessText", 10, true, "iiiii", playerid, time, alpha_min, alpha_max, false);

    return 1;
}

Notification_HideBeatingText(playerid)
{
    if(!g_rgiTextProcessTick[playerid])
        return 0;

    KillTimer(g_rgiTextProcessTimer[playerid]);
    g_rgiTextProcessTick[playerid] = 0;
    PlayerTextDrawHide(playerid, p_tdBeatingText{playerid});

    return 1;
}
