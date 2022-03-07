#if defined _ATM_FUNCTIONS_
    #endinput
#endif
#define _ATM_FUNCTIONS_

ATM_ShowMenu(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_USING_ATM, true);

    TextDrawSetStringForPlayer(g_tdBankATM[6], playerid, "$%d", g_rgePlayerData[playerid][e_iPlayerBankBalance]);
    TextDrawSetStringForPlayer(g_tdBankATM[7], playerid, "ID: %i", Player_AccountID(playerid));

    for(new i = sizeof(g_tdBankATM) - 1; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdBankATM[i]);
    }

    SelectTextDraw(playerid, 0x64A752FF);
    return 1;
}

ATM_HideMenu(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_USING_ATM, false);

    for(new i = sizeof(g_tdBankATM) - 1; i != -1; --i)
    {
        TextDrawHideForPlayer(playerid, g_tdBankATM[i]);
    }

    return 1;
}