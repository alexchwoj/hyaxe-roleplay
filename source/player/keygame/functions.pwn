#if defined _keygame_functions_
    #endinput
#endif
#define _keygame_functions_

Player_StartKeyGame(playerid, cb, Float:key_percentage_up = 9.9, Float:decrease_sec = 2.5)
{
    Bit_Set(Player_Flags(playerid), PFLAG_IN_KEYGAME, true);

    g_rgeKeyGameData[playerid][e_iKgCurrentKey] = random(sizeof(g_rgiRandomKeys));

    TextDrawTextSize(g_tdKeyGame[1], 298.500, KEYGAME_BAR_MIN_Y);
    PlayerTextDrawSetString(playerid, p_tdKeyGame{playerid}, g_rgszKeyNames[g_rgeKeyGameData[playerid][e_iKgCurrentKey]]);
    PlayerTextDrawShow(playerid, p_tdKeyGame{playerid});

    for(new i = sizeof(g_tdKeyGame) - 1; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdKeyGame[i]);
    }

    g_rgeKeyGameData[playerid][e_fKgCurrentSize] = KEYGAME_BAR_MIN_Y;
    g_rgeKeyGameData[playerid][e_pKgCallback] = cb;
    g_rgeKeyGameData[playerid][e_iKgLastKeyAppearance] = GetTickCount();
    g_rgeKeyGameData[playerid][e_fKgDecreaseSec] = decrease_sec;
    g_rgeKeyGameData[playerid][e_fKgPercentagePerKey] = key_percentage_up;
    g_rgeKeyGameData[playerid][e_bKgKeyRed] = false;
    g_rgeKeyGameData[playerid][e_iKgKeyRedTick] = 0;

    g_rgeKeyGameData[playerid][e_iKgTimers][KG_TIMER_DECREASE_BAR] = 0;
    g_rgeKeyGameData[playerid][e_iKgTimers][KG_TIMER_PROCESS_KEY]  = SetTimerEx("KEYGAME_ProcessKey", 100, true, "i", playerid);

    return 1;
}

Player_StopKeyGame(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_IN_KEYGAME, false);

    KillTimer(g_rgeKeyGameData[playerid][e_iKgTimers][KG_TIMER_DECREASE_BAR]);
    KillTimer(g_rgeKeyGameData[playerid][e_iKgTimers][KG_TIMER_PROCESS_KEY]);

    for(new i = sizeof(g_tdKeyGame) - 1; i != -1; --i)
    {
        TextDrawHideForPlayer(playerid, g_tdKeyGame[i]);
    }

    PlayerTextDrawHide(playerid, p_tdKeyGame{playerid});

    g_rgeKeyGameData[playerid] = g_rgeKeyGameData[MAX_PLAYERS];

    return 1;
}