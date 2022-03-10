#if defined _ATM_CALLBACKS_
    #endinput
#endif
#define _ATM_CALLBACKS_

public OnPlayerCancelTDSelection(playerid)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_USING_ATM))
        ATM_HideMenu(playerid);    

    #if defined ATM_OnPlayerCancelTDSelection
        return ATM_OnPlayerCancelTDSelection(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerCancelTDSelection
    #undef OnPlayerCancelTDSelection
#else
    #define _ALS_OnPlayerCancelTDSelection
#endif
#define OnPlayerCancelTDSelection ATM_OnPlayerCancelTDSelection
#if defined ATM_OnPlayerCancelTDSelection
    forward ATM_OnPlayerCancelTDSelection(playerid);
#endif


public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_USING_ATM))
    {
        // Deposit
        if (clickedid == g_tdBankATM[3])
        {
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                {DADADA}Dinero actual: {64A752}$%s{DADADA}\n\
                Ingrese una cantidad para depositar:\
            ", Format_Thousand( Player_Money(playerid) ));
            Dialog_Show(playerid, "bank_deposit", DIALOG_STYLE_INPUT, "{64A752}Banco{DADADA} - Depositar", HYAXE_UNSAFE_HUGE_STRING, "Depositar", "Cancelar");
        }
        // Withdraw
        else if (clickedid == g_tdBankATM[4])
        {
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                {DADADA}Balance actual: {64A752}$%s{DADADA}\n\
                Ingrese una cantidad para retirar:\
            ", Format_Thousand(g_rgePlayerData[playerid][e_iPlayerBankBalance]));
            Dialog_Show(playerid, "bank_withdraw", DIALOG_STYLE_INPUT, "{64A752}Banco{DADADA} - Retirar", HYAXE_UNSAFE_HUGE_STRING, "Retirar", "Cancelar");
        }
        // Transfer
        else if (clickedid == g_tdBankATM[5])
        {
            Dialog_Show(playerid, "bank_transfer", DIALOG_STYLE_INPUT, "{64A752}Banco{DADADA} - Transferir", "{DADADA}Ingrese la cuenta bancaria a transferir:", "Siguiente", "Cancelar");
        }

        PlayerPlaySound(playerid, SOUND_BUTTON);
    }

    #if defined ATM_OnPlayerClickTextDraw
        return ATM_OnPlayerClickTextDraw(playerid, Text:clickedid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw ATM_OnPlayerClickTextDraw
#if defined ATM_OnPlayerClickTextDraw
    forward ATM_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif


forward ATM_LoadFromDatabase(playerid);
public ATM_LoadFromDatabase(playerid)
{
    new row_count;
    cache_get_row_count(row_count);

    if (row_count)
        cache_get_value_name_int(0, !"BALANCE", g_rgePlayerData[playerid][e_iPlayerBankBalance]);

    return 1;
}

public OnPlayerAuthenticate(playerid)
{
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        SELECT * FROM `BANK_ACCOUNT` WHERE `ACCOUNT_ID` = %i;\
    ", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "ATM_LoadFromDatabase", "i", playerid);

    #if defined ATM_OnPlayerAuthenticate
        return ATM_OnPlayerAuthenticate(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerAuthenticate
    #undef OnPlayerAuthenticate
#else
    #define _ALS_OnPlayerAuthenticate
#endif
#define OnPlayerAuthenticate ATM_OnPlayerAuthenticate
#if defined ATM_OnPlayerAuthenticate
    forward ATM_OnPlayerAuthenticate(playerid);
#endif


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_YES) != 0)
    {
        if (GetPlayerNumberDynamicAreas(playerid) > 0)
        {
            new areas[1];
            GetPlayerDynamicAreas(playerid, areas);

            new info[3];
            Streamer_GetArrayData(STREAMER_TYPE_AREA, areas[0], E_STREAMER_EXTRA_ID, info);
            if (info[0] == 0x41544D)
            {
                if (GetPlayerVirtualWorld(playerid) == g_rgeATMBank[ info[1] ][e_iAtmWorld] && GetPlayerInterior(playerid) == g_rgeATMBank[ info[1] ][e_iAtmInterior])
                {
                    ATM_ShowMenu(playerid);
                }
            }
        }
    }

    #if defined ATM_OnPlayerKeyStateChange
        return ATM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange ATM_OnPlayerKeyStateChange
#if defined ATM_OnPlayerKeyStateChange
    forward ATM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


public OnGameModeInit()
{
    for(new i; i < sizeof(g_rgeATMBank); ++i)
    {
        g_rgeATMBank[i][e_iAtmObject] = CreateDynamicObject(19324,
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], g_rgeATMBank[i][e_fAtmPosZ],
            g_rgeATMBank[i][e_fAtmRotX], g_rgeATMBank[i][e_fAtmRotY], g_rgeATMBank[i][e_fAtmRotZ],
            g_rgeATMBank[i][e_iAtmWorld], g_rgeATMBank[i][e_iAtmInterior],
            .streamdistance = 100.0, .drawdistance = 100.0
        );

        g_rgeATMBank[i][e_fAtmHealth] = 1000.0;
        CreateDynamicMapIcon(
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], g_rgeATMBank[i][e_fAtmPosZ],
            52, -1, g_rgeATMBank[i][e_iAtmWorld], g_rgeATMBank[i][e_iAtmInterior]
        );
    
        g_rgeATMBank[i][e_iAtmLabel] = CreateDynamic3DTextLabel(
            "Cajero automático", 0xF7F7F7AA,
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], g_rgeATMBank[i][e_fAtmPosZ] + 2.0, 5.0,
            .testlos = true, .worldid = g_rgeATMBank[i][e_iAtmWorld], .interiorid = g_rgeATMBank[i][e_iAtmInterior]
        );

        new info[2];
        info[0] = 0x41544D; // ATM
        info[1] = i; // ATM ID

        g_rgeATMBank[i][e_iAtmArea] = CreateDynamicCircle(
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], 1.2,
            .worldid = g_rgeATMBank[i][e_iAtmWorld], .interiorid = g_rgeATMBank[i][e_iAtmInterior]
        );
        Streamer_SetArrayData(STREAMER_TYPE_AREA, g_rgeATMBank[i][e_iAtmArea], E_STREAMER_EXTRA_ID, info);
    
        Key_Alert(
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], 1.2,
            KEYNAME_YES, g_rgeATMBank[i][e_iAtmWorld], g_rgeATMBank[i][e_iAtmInterior]
        );
    }

    #if defined ATM_OnGameModeInit
        return ATM_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGamemodeInit
    #undef OnGamemodeInit
#else
    #define _ALS_OnGamemodeInit
#endif
#define OnGamemodeInit ATM_OnGamemodeInit
#if defined ATM_OnGamemodeInit
    forward ATM_OnGamemodeInit();
#endif


dialog bank_deposit(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        new amount;
        if (sscanf(inputtext, "d", amount))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Introduce un valor numérico.");
            return 1;
        }

        if (amount <= 0 || amount > 500000)
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Introduce un monto mayor a 0 y menor a 500.000.");
            return 1;
        }

        if (amount > Player_Money(playerid))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
            return 1;
        }

        Player_GiveMoney(playerid, -amount);
        Bank_AddBalance(playerid, amount);
        PlayerPlaySound(playerid, SOUND_SUCCESS);

        ATM_ShowMenu(playerid);
    }
    else PlayerPlaySound(playerid, SOUND_BUTTON);

    return 1;
}

dialog bank_withdraw(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        new amount;
        if (sscanf(inputtext, "d", amount))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Introduce un valor numérico.");
            return 1;
        }

        if (amount <= 0 || amount > 500000)
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Introduce un monto mayor a 0 y menor a 500.000.");
            return 1;
        }

        if (amount > g_rgePlayerData[playerid][e_iPlayerBankBalance])
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente en el banco.");
            return 1;
        }

        Player_GiveMoney(playerid, amount);
        Bank_AddBalance(playerid, -amount);
        PlayerPlaySound(playerid, SOUND_SUCCESS);

        ATM_ShowMenu(playerid);
    }
    else PlayerPlaySound(playerid, SOUND_BUTTON);

    return 1;
}