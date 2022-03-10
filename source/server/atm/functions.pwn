#if defined _ATM_FUNCTIONS_
    #endinput
#endif
#define _ATM_FUNCTIONS_

ATM_ShowMenu(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_USING_ATM, true);

    /*
    new string[32];

    SetExclusiveBroadcast(true);
    BroadcastToPlayer(playerid, true);

    format(string, sizeof(string), "$%s", Format_Thousand(g_rgePlayerData[playerid][e_iPlayerBankBalance]));
    TextDrawSetString(g_tdBankATM[6], string);

    format(string, sizeof(string), "Cuenta: %i", Player_AccountID(playerid));
    TextDrawSetString(g_tdBankATM[7], string);

    BroadcastToPlayer(playerid, false);
    SetExclusiveBroadcast(false);
    */
    
    for(new i = sizeof(g_tdBankATM) - 1; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdBankATM[i]);
    }

    new string[32];
    format(string, sizeof(string), "$%s", Format_Thousand(g_rgePlayerData[playerid][e_iPlayerBankBalance]));
    TextDrawSetStringForPlayer(g_tdBankATM[6], playerid, string);

    format(string, sizeof(string), "Cuenta: %i", Player_AccountID(playerid));
    TextDrawSetStringForPlayer(g_tdBankATM[7], playerid, string);

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

Bank_SetBalance(playerid, balance)
{
    g_rgePlayerData[playerid][e_iPlayerBankBalance] = balance;

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        UPDATE `BANK_ACCOUNT` SET \
            `BALANCE` = %d \
        WHERE `ACCOUNT_ID` = %i;\
    ", g_rgePlayerData[playerid][e_iPlayerBankBalance], Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    return 1;
}

Bank_AddBalance(playerid, balance, bool:show_notification = true)
{
    g_rgePlayerData[playerid][e_iPlayerBankBalance] += balance;

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        UPDATE `BANK_ACCOUNT` SET \
            `BALANCE` = %d \
        WHERE `ACCOUNT_ID` = %i;\
    ", g_rgePlayerData[playerid][e_iPlayerBankBalance], Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);

    if (show_notification)
    {
        if (balance > 0)
        {
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Sa acaban de acreditar ~g~$%s~w~ a tu cuenta bancaria.", Format_Thousand(balance));
            Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 3000, 0x64A752FF);
        }
        else
        {
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Sa han descontado ~y~$%s~w~ de tu cuenta bancaria.", Format_Thousand(balance));
            Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 3000, 0xDAA838FF);
        }
    }
    return 1;
}

Bank_RegisterTransaction(bank_account, type, amount, extra = 0)
{
    return 1;
}