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

    // BANK ATM
    g_tdBankATM[0] = TextDrawCreate(319.000000, 158.000000, "_");
    TextDrawFont(g_tdBankATM[0], 1);
    TextDrawLetterSize(g_tdBankATM[0], 0.600000, 15.650023);
    TextDrawTextSize(g_tdBankATM[0], 292.000000, 117.500000);
    TextDrawSetOutline(g_tdBankATM[0], 1);
    TextDrawSetShadow(g_tdBankATM[0], 0);
    TextDrawAlignment(g_tdBankATM[0], 2);
    TextDrawColor(g_tdBankATM[0], -1);
    TextDrawBackgroundColor(g_tdBankATM[0], 255);
    TextDrawBoxColor(g_tdBankATM[0], 454761471);
    TextDrawUseBox(g_tdBankATM[0], 1);
    TextDrawSetProportional(g_tdBankATM[0], 1);
    TextDrawSetSelectable(g_tdBankATM[0], 0);

    g_tdBankATM[1] = TextDrawCreate(303.000000, 161.000000, "BANCO");
    TextDrawFont(g_tdBankATM[1], 3);
    TextDrawLetterSize(g_tdBankATM[1], 0.329165, 1.350000);
    TextDrawTextSize(g_tdBankATM[1], 400.000000, 17.000000);
    TextDrawSetOutline(g_tdBankATM[1], 1);
    TextDrawSetShadow(g_tdBankATM[1], 0);
    TextDrawAlignment(g_tdBankATM[1], 1);
    TextDrawColor(g_tdBankATM[1], -134744065);
    TextDrawBackgroundColor(g_tdBankATM[1], 255);
    TextDrawBoxColor(g_tdBankATM[1], 50);
    TextDrawUseBox(g_tdBankATM[1], 0);
    TextDrawSetProportional(g_tdBankATM[1], 1);
    TextDrawSetSelectable(g_tdBankATM[1], 0);

    g_tdBankATM[2] = TextDrawCreate(319.000000, 158.000000, "_");
    TextDrawFont(g_tdBankATM[2], 1);
    TextDrawLetterSize(g_tdBankATM[2], 0.600000, -0.999979);
    TextDrawTextSize(g_tdBankATM[2], 292.000000, 117.500000);
    TextDrawSetOutline(g_tdBankATM[2], 1);
    TextDrawSetShadow(g_tdBankATM[2], 0);
    TextDrawAlignment(g_tdBankATM[2], 2);
    TextDrawColor(g_tdBankATM[2], -1);
    TextDrawBackgroundColor(g_tdBankATM[2], 255);
    TextDrawBoxColor(g_tdBankATM[2], 1688687359);
    TextDrawUseBox(g_tdBankATM[2], 1);
    TextDrawSetProportional(g_tdBankATM[2], 1);
    TextDrawSetSelectable(g_tdBankATM[2], 0);

    g_tdBankATM[3] = TextDrawCreate(319.000000, 202.000000, "depositar");
    TextDrawFont(g_tdBankATM[3], 3);
    TextDrawLetterSize(g_tdBankATM[3], 0.329165, 1.350000);
    TextDrawTextSize(g_tdBankATM[3], 10.500000, 111.000000);
    TextDrawSetOutline(g_tdBankATM[3], 1);
    TextDrawSetShadow(g_tdBankATM[3], 0);
    TextDrawAlignment(g_tdBankATM[3], 2);
    TextDrawColor(g_tdBankATM[3], -134744065);
    TextDrawBackgroundColor(g_tdBankATM[3], 255);
    TextDrawBoxColor(g_tdBankATM[3], 202116351);
    TextDrawUseBox(g_tdBankATM[3], 1);
    TextDrawSetProportional(g_tdBankATM[3], 1);
    TextDrawSetSelectable(g_tdBankATM[3], 1);

    g_tdBankATM[4] = TextDrawCreate(319.000000, 226.000000, "retirar");
    TextDrawFont(g_tdBankATM[4], 3);
    TextDrawLetterSize(g_tdBankATM[4], 0.329165, 1.350000);
    TextDrawTextSize(g_tdBankATM[4], 10.500000, 111.500000);
    TextDrawSetOutline(g_tdBankATM[4], 1);
    TextDrawSetShadow(g_tdBankATM[4], 0);
    TextDrawAlignment(g_tdBankATM[4], 2);
    TextDrawColor(g_tdBankATM[4], -134744065);
    TextDrawBackgroundColor(g_tdBankATM[4], 255);
    TextDrawBoxColor(g_tdBankATM[4], 202116351);
    TextDrawUseBox(g_tdBankATM[4], 1);
    TextDrawSetProportional(g_tdBankATM[4], 1);
    TextDrawSetSelectable(g_tdBankATM[4], 1);

    g_tdBankATM[5] = TextDrawCreate(319.000000, 250.000000, "transferir");
    TextDrawFont(g_tdBankATM[5], 3);
    TextDrawLetterSize(g_tdBankATM[5], 0.329165, 1.350000);
    TextDrawTextSize(g_tdBankATM[5], 10.500000, 111.500000);
    TextDrawSetOutline(g_tdBankATM[5], 1);
    TextDrawSetShadow(g_tdBankATM[5], 0);
    TextDrawAlignment(g_tdBankATM[5], 2);
    TextDrawColor(g_tdBankATM[5], -134744065);
    TextDrawBackgroundColor(g_tdBankATM[5], 255);
    TextDrawBoxColor(g_tdBankATM[5], 202116351);
    TextDrawUseBox(g_tdBankATM[5], 1);
    TextDrawSetProportional(g_tdBankATM[5], 1);
    TextDrawSetSelectable(g_tdBankATM[5], 1);

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
    // BEATING TEXT
    p_tdBeatingText{playerid} = CreatePlayerTextDraw(playerid, 319.000000, 369.000000, !"_");
    PlayerTextDrawFont(playerid, p_tdBeatingText{playerid}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdBeatingText{playerid}, 0.266667, 1.549999);
    PlayerTextDrawTextSize(playerid, p_tdBeatingText{playerid}, 417.500000, 178.000000);
    PlayerTextDrawSetOutline(playerid, p_tdBeatingText{playerid}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdBeatingText{playerid}, 1);
    PlayerTextDrawAlignment(playerid, p_tdBeatingText{playerid}, 2);
    PlayerTextDrawColor(playerid, p_tdBeatingText{playerid}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdBeatingText{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdBeatingText{playerid}, 50);
    PlayerTextDrawUseBox(playerid, p_tdBeatingText{playerid}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdBeatingText{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdBeatingText{playerid}, 0);

    // BANK ATM
    p_tdBankATM_Balance{playerid} = CreatePlayerTextDraw(playerid, 318.000000, 174.000000, !"$100.600");
    PlayerTextDrawFont(playerid, p_tdBankATM_Balance{playerid}, 3);
    PlayerTextDrawLetterSize(playerid, p_tdBankATM_Balance{playerid}, 0.329165, 1.350000);
    PlayerTextDrawTextSize(playerid, p_tdBankATM_Balance{playerid}, 400.000000, 201.500000);
    PlayerTextDrawSetOutline(playerid, p_tdBankATM_Balance{playerid}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdBankATM_Balance{playerid}, 0);
    PlayerTextDrawAlignment(playerid, p_tdBankATM_Balance{playerid}, 2);
    PlayerTextDrawColor(playerid, p_tdBankATM_Balance{playerid}, 1688687359);
    PlayerTextDrawBackgroundColor(playerid, p_tdBankATM_Balance{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdBankATM_Balance{playerid}, 50);
    PlayerTextDrawUseBox(playerid, p_tdBankATM_Balance{playerid}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdBankATM_Balance{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdBankATM_Balance{playerid}, 0);

    p_tdBankATM_ID{playerid} = CreatePlayerTextDraw(playerid, 318.000000, 276.000000, !"ID: 1337");
    PlayerTextDrawFont(playerid, p_tdBankATM_ID{playerid}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdBankATM_ID{playerid}, 0.262499, 1.350000);
    PlayerTextDrawTextSize(playerid, p_tdBankATM_ID{playerid}, 396.000000, 105.000000);
    PlayerTextDrawSetOutline(playerid, p_tdBankATM_ID{playerid}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdBankATM_ID{playerid}, 0);
    PlayerTextDrawAlignment(playerid, p_tdBankATM_ID{playerid}, 2);
    PlayerTextDrawColor(playerid, p_tdBankATM_ID{playerid}, 909522687);
    PlayerTextDrawBackgroundColor(playerid, p_tdBankATM_ID{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdBankATM_ID{playerid}, 50);
    PlayerTextDrawUseBox(playerid, p_tdBankATM_ID{playerid}, 0);
    PlayerTextDrawSetProportional(playerid, p_tdBankATM_ID{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdBankATM_ID{playerid}, 0);

    // KEY
    p_tdKey_Text{playerid} = CreatePlayerTextDraw(playerid, 323.000000, 11.000000, !"_");
    PlayerTextDrawFont(playerid, p_tdKey_Text{playerid}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdKey_Text{playerid}, 0.233333, 1.200000);
    PlayerTextDrawTextSize(playerid, p_tdKey_Text{playerid}, 378.000000, 103.000000);
    PlayerTextDrawSetOutline(playerid, p_tdKey_Text{playerid}, 0);
    PlayerTextDrawSetShadow(playerid, p_tdKey_Text{playerid}, 0);
    PlayerTextDrawAlignment(playerid, p_tdKey_Text{playerid}, 2);
    PlayerTextDrawColor(playerid, p_tdKey_Text{playerid}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdKey_Text{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdKey_Text{playerid}, 993737727);
    PlayerTextDrawUseBox(playerid, p_tdKey_Text{playerid}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdKey_Text{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdKey_Text{playerid}, 0);

    p_tdKey_BG{playerid} = CreatePlayerTextDraw(playerid, 323.000000, 9.000000, !"_");
    PlayerTextDrawFont(playerid, p_tdKey_BG{playerid}, 1);
    PlayerTextDrawLetterSize(playerid, p_tdKey_BG{playerid}, 0.600000, -0.200000);
    PlayerTextDrawTextSize(playerid, p_tdKey_BG{playerid}, 302.000000, 103.000000);
    PlayerTextDrawSetOutline(playerid, p_tdKey_BG{playerid}, 1);
    PlayerTextDrawSetShadow(playerid, p_tdKey_BG{playerid}, 0);
    PlayerTextDrawAlignment(playerid, p_tdKey_BG{playerid}, 2);
    PlayerTextDrawColor(playerid, p_tdKey_BG{playerid}, -1);
    PlayerTextDrawBackgroundColor(playerid, p_tdKey_BG{playerid}, 255);
    PlayerTextDrawBoxColor(playerid, p_tdKey_BG{playerid}, 454761471);
    PlayerTextDrawUseBox(playerid, p_tdKey_BG{playerid}, 1);
    PlayerTextDrawSetProportional(playerid, p_tdKey_BG{playerid}, 1);
    PlayerTextDrawSetSelectable(playerid, p_tdKey_BG{playerid}, 0);

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
