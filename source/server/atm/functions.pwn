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

    TextDrawSetStringForPlayer(g_tdBankATM[6], playerid, "$%s", Format_Thousand(g_rgePlayerData[playerid][e_iPlayerBankBalance]));
    TextDrawSetStringForPlayer(g_tdBankATM[7], playerid, "Cuenta: %i", Player_AccountID(playerid));

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

ATM_Destroy(atm_id)
{
    Streamer_SetIntData(STREAMER_TYPE_OBJECT, g_rgeATMBank[atm_id][e_iAtmObject], E_STREAMER_MODEL_ID, 2943);
    g_rgeATMBank[atm_id][e_fAtmHealth] = 0.0;

    Streamer_UpdateInStreamRange(
        g_rgeATMBank[atm_id][e_fAtmPosX], g_rgeATMBank[atm_id][e_fAtmPosY], g_rgeATMBank[atm_id][e_fAtmPosZ], 
        g_rgeATMBank[atm_id][e_iAtmWorld], g_rgeATMBank[atm_id][e_iAtmInterior], 
        STREAMER_TYPE_OBJECT, 100.0
    );

    inline const RepairATM()
    {
        ATM_Repair(atm_id);
    }
    Timer_CreateCallback(using inline RepairATM, 300000, 1);
    return 1;
}

ATM_Repair(atm_id)
{
    Streamer_SetIntData(STREAMER_TYPE_OBJECT, g_rgeATMBank[atm_id][e_iAtmObject], E_STREAMER_MODEL_ID, 19324);
    g_rgeATMBank[atm_id][e_fAtmHealth] = 1000.0;

    Streamer_UpdateInStreamRange(
        g_rgeATMBank[atm_id][e_fAtmPosX], g_rgeATMBank[atm_id][e_fAtmPosY], g_rgeATMBank[atm_id][e_fAtmPosZ], 
        g_rgeATMBank[atm_id][e_iAtmWorld], g_rgeATMBank[atm_id][e_iAtmInterior], 
        STREAMER_TYPE_OBJECT, 100.0
    );

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
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        INSERT INTO `BANK_TRANSACTIONS` \
            (ACCOUNT_ID, TRANSACTION_TYPE, AMOUNT, EXTRA) \
        VALUES \
            (%d, %d, %d, %d);\
    ",
        bank_account, type, amount, extra
    );

    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    return 1;
}

Player_DestroyNearestATM(playerid, Float:x, Float:y, Float:z)
{
    for(new i; i < sizeof(g_rgeATMBank); ++i)
    {
        if ( GetDistanceBetweenPoints3D(
            x, y, z,
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], g_rgeATMBank[i][e_fAtmPosZ]
        ) <= 5.0)
        {   
            new money = Random(30000, (Player_VIP(playerid) >= 2 ? 31000 : 30800) );
            Player_GiveMoney(playerid, money);

            Notification_Show(playerid, va_return("Robaste un cajero y recibiste ~g~$%i~w~. Huye antes de que venga la policía.", money), 8000);

            Police_AddChargesToPlayer(playerid, 3);

            new city[45], zone[45];
            GetPointZone(g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], city, zone);
            Police_SendMessage(POLICE_RANK_OFFICER, 0x3A86FFFF, va_return("[Policía] ›{DADADA} %s ha destrozado a un cajero en %s, %s.", Player_RPName(playerid), zone, city));
            
            for(new j; j < Random(5, 10); ++j)
            {
                DroppedItem_Create(
                    ITEM_MONEY, 1, Random(25, 90),
                    g_rgeATMBank[i][e_fAtmPosX] + RandomFloat(-2.0, 2.0),
                    g_rgeATMBank[i][e_fAtmPosY] + RandomFloat(-2.0, 2.0),
                    g_rgeATMBank[i][e_fAtmPosZ], 0, 0, .timeout = 300 + random(300)
                );
            }

            ATM_Destroy(i);
            break;
        }
    }
    return 1;
}