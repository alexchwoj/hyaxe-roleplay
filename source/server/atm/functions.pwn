#if defined _ATM_FUNCTIONS_
    #endinput
#endif
#define _ATM_FUNCTIONS_

ATM_ShowMenu(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_ATM, true);

    new string[32];

    format(string, sizeof(string), "$%d", g_rgePlayerData[playerid][e_iPlayerBankBalance]);
    PlayerTextDrawSetString(playerid, p_tdBankATM_Balance{playerid}, string);

    format(string, sizeof(string), "ID: %i", Player_AccountID(playerid));
    PlayerTextDrawSetString(playerid, p_tdBankATM_ID{playerid}, string);

    for(new i = sizeof(g_tdBankATM) - 1; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdBankATM[i]);
    }

    PlayerTextDrawShow(playerid, p_tdBankATM_Balance{playerid});
    PlayerTextDrawShow(playerid, p_tdBankATM_ID{playerid});

    SelectTextDraw(playerid, 0x64A752FF);
    return 1;
}

ATM_HideMenu(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_ATM, false);

    for(new i = sizeof(g_tdBankATM) - 1; i != -1; --i)
    {
        TextDrawHideForPlayer(playerid, g_tdBankATM[i]);
    }

    PlayerTextDrawHide(playerid, p_tdBankATM_Balance{playerid});
    PlayerTextDrawHide(playerid, p_tdBankATM_ID{playerid});
    return 1;
}