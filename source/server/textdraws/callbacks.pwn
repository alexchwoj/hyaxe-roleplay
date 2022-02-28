#if defined _textdraws_callbacks_
    #endinput
#endif
#define _textdraws_callbacks_

public OnGameModeInit()
{
    // SNEEDOMETER
    g_tdSpeedometer[0] = TextDrawCreate(463.000000, 415.000000, "/////////////////////////////////~n~-----------------------------------");
    TextDrawFont(g_tdSpeedometer[0], 1);
    TextDrawLetterSize(g_tdSpeedometer[0], 0.284166, 1.500000);
    TextDrawTextSize(g_tdSpeedometer[0], 402.000000, 17.000000);
    TextDrawSetOutline(g_tdSpeedometer[0], 1);
    TextDrawSetShadow(g_tdSpeedometer[0], 0);
    TextDrawAlignment(g_tdSpeedometer[0], 1);
    TextDrawColor(g_tdSpeedometer[0], 1296911871);
    TextDrawBackgroundColor(g_tdSpeedometer[0], 1296911871);
    TextDrawBoxColor(g_tdSpeedometer[0], 50);
    TextDrawUseBox(g_tdSpeedometer[0], 0);
    TextDrawSetProportional(g_tdSpeedometer[0], 1);
    TextDrawSetSelectable(g_tdSpeedometer[0], 0);

    g_tdSpeedometer[1] = TextDrawCreate(463.000000, 415.000000, "////////////~n~------------");
    TextDrawFont(g_tdSpeedometer[1], 1);
    TextDrawLetterSize(g_tdSpeedometer[1], 0.284166, 1.500000);
    TextDrawTextSize(g_tdSpeedometer[1], 402.000000, 17.000000);
    TextDrawSetOutline(g_tdSpeedometer[1], 1);
    TextDrawSetShadow(g_tdSpeedometer[1], 0);
    TextDrawAlignment(g_tdSpeedometer[1], 1);
    TextDrawColor(g_tdSpeedometer[1], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[1], -1);
    TextDrawBoxColor(g_tdSpeedometer[1], 50);
    TextDrawUseBox(g_tdSpeedometer[1], 0);
    TextDrawSetProportional(g_tdSpeedometer[1], 1);
    TextDrawSetSelectable(g_tdSpeedometer[1], 0);

    g_tdSpeedometer[2] = TextDrawCreate(614.000000, 412.000000, "////");
    TextDrawFont(g_tdSpeedometer[2], 1);
    TextDrawLetterSize(g_tdSpeedometer[2], 0.284000, 2.849997);
    TextDrawTextSize(g_tdSpeedometer[2], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdSpeedometer[2], 1);
    TextDrawSetShadow(g_tdSpeedometer[2], 0);
    TextDrawAlignment(g_tdSpeedometer[2], 1);
    TextDrawColor(g_tdSpeedometer[2], -16776961);
    TextDrawBackgroundColor(g_tdSpeedometer[2], -16776961);
    TextDrawBoxColor(g_tdSpeedometer[2], 50);
    TextDrawUseBox(g_tdSpeedometer[2], 0);
    TextDrawSetProportional(g_tdSpeedometer[2], 1);
    TextDrawSetSelectable(g_tdSpeedometer[2], 0);

    g_tdSpeedometer[3] = TextDrawCreate(593.000000, 379.000000, "/");
    TextDrawFont(g_tdSpeedometer[3], 1);
    TextDrawLetterSize(g_tdSpeedometer[3], 0.284166, 3.500000);
    TextDrawTextSize(g_tdSpeedometer[3], 402.000000, 17.000000);
    TextDrawSetOutline(g_tdSpeedometer[3], 1);
    TextDrawSetShadow(g_tdSpeedometer[3], 0);
    TextDrawAlignment(g_tdSpeedometer[3], 1);
    TextDrawColor(g_tdSpeedometer[3], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[3], -1);
    TextDrawBoxColor(g_tdSpeedometer[3], 50);
    TextDrawUseBox(g_tdSpeedometer[3], 0);
    TextDrawSetProportional(g_tdSpeedometer[3], 1);
    TextDrawSetSelectable(g_tdSpeedometer[3], 0);

    g_tdSpeedometer[4] = TextDrawCreate(515.000000, 379.000000, "23");
    TextDrawFont(g_tdSpeedometer[4], 3);
    TextDrawLetterSize(g_tdSpeedometer[4], 0.500832, 3.500000);
    TextDrawTextSize(g_tdSpeedometer[4], 402.000000, 17.000000);
    TextDrawSetOutline(g_tdSpeedometer[4], 0);
    TextDrawSetShadow(g_tdSpeedometer[4], 0);
    TextDrawAlignment(g_tdSpeedometer[4], 1);
    TextDrawColor(g_tdSpeedometer[4], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[4], -1);
    TextDrawBoxColor(g_tdSpeedometer[4], 50);
    TextDrawUseBox(g_tdSpeedometer[4], 0);
    TextDrawSetProportional(g_tdSpeedometer[4], 1);
    TextDrawSetSelectable(g_tdSpeedometer[4], 0);

    g_tdSpeedometer[5] = TextDrawCreate(603.000000, 381.000000, "KM/H");
    TextDrawFont(g_tdSpeedometer[5], 2);
    TextDrawLetterSize(g_tdSpeedometer[5], 0.250833, 1.500000);
    TextDrawTextSize(g_tdSpeedometer[5], 402.000000, 17.000000);
    TextDrawSetOutline(g_tdSpeedometer[5], 0);
    TextDrawSetShadow(g_tdSpeedometer[5], 0);
    TextDrawAlignment(g_tdSpeedometer[5], 1);
    TextDrawColor(g_tdSpeedometer[5], -1);
    TextDrawBackgroundColor(g_tdSpeedometer[5], -1);
    TextDrawBoxColor(g_tdSpeedometer[5], 50);
    TextDrawUseBox(g_tdSpeedometer[5], 0);
    TextDrawSetProportional(g_tdSpeedometer[5], 1);
    TextDrawSetSelectable(g_tdSpeedometer[5], 0);

    #if defined TD_OnGameModeInit
        return TD_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit TD_OnGameModeInit
#if defined TD_OnGameModeInit
    forward TD_OnGameModeInit();
#endif

public OnPlayerConnect(playerid)
{
    p_tdBeatingText{playerid} = CreatePlayerTextDraw(playerid, 324.000000, 410.000000, "_");
    PlayerTextDrawFont(playerid, p_tdBeatingText{playerid}, 2);
    PlayerTextDrawLetterSize(playerid, p_tdBeatingText{playerid}, 0.158333, 1.350000);
    PlayerTextDrawTextSize(playerid, p_tdBeatingText{playerid}, 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, p_tdBeatingText{playerid}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdBeatingText{playerid}, 1);
    PlayerTextDrawAlignment(playerid, p_tdBeatingText{playerid}, 2);
    PlayerTextDrawColor(playerid, p_tdBeatingText{playerid}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdBeatingText{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdBeatingText{playerid}, 50);
    PlayerTextDrawUseBox(playerid, p_tdBeatingText{playerid}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdBeatingText{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdBeatingText{playerid}, 0);

    #if defined TD_OnPlayerConnect
        return TD_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect TD_OnPlayerConnect
#if defined TD_OnPlayerConnect
    forward TD_OnPlayerConnect(playerid);
#endif
