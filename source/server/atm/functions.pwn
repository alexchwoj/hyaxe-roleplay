#if defined _ATM_FUNCTIONS_
    #endinput
#endif
#define _ATM_FUNCTIONS_

ATM_ShowMenu(playerid)
{
<<<<<<< HEAD
    Bit_Set(Player_Flags(playerid), PFLAG_ATM, true);
=======
    Bit_Set(Player_Flags(playerid), PFLAG_USING_ATM, true);
>>>>>>> ccd731feda1667bc6568a0412a3bc3ad463fe32e

    new string[32];

    format(string, sizeof(string), "$%d", g_rgePlayerData[playerid][e_iPlayerBankBalance]);
    TextDrawSetString(g_tdBankATM[6], string);

    format(string, sizeof(string), "ID: %i", Player_AccountID(playerid));
    TextDrawSetString(g_tdBankATM[7], string);

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