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
            Dialog_ShowCallback(playerid, using public _hydg@bank_deposit<iiiis>, DIALOG_STYLE_INPUT, "{64A752}Banco{DADADA} - Depositar", HYAXE_UNSAFE_HUGE_STRING, "Depositar", "Cancelar");
        }
        // Withdraw
        else if (clickedid == g_tdBankATM[4])
        {
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                {DADADA}Balance actual: {64A752}$%s{DADADA}\n\
                Ingrese una cantidad para retirar:\
            ", Format_Thousand(g_rgePlayerData[playerid][e_iPlayerBankBalance]));
            Dialog_ShowCallback(playerid, using public _hydg@bank_withdraw<iiiis>, DIALOG_STYLE_INPUT, "{64A752}Banco{DADADA} - Retirar", HYAXE_UNSAFE_HUGE_STRING, "Retirar", "Cancelar");
        }
        // Transfer
        else if (clickedid == g_tdBankATM[5])
        {
            Dialog_ShowCallback(playerid, using public _hydg@bank_transfer<iiiis>, DIALOG_STYLE_INPUT, "{64A752}Banco{DADADA} - Transferir", "{DADADA}Ingrese la cuenta bancaria a transferir:", "Siguiente", "Cancelar");
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


static ATM_OnPress(playerid)
{
    ATM_ShowMenu(playerid);
    return 1;
}

public OnScriptInit()
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
    
        Key_Alert(
            g_rgeATMBank[i][e_fAtmPosX], g_rgeATMBank[i][e_fAtmPosY], g_rgeATMBank[i][e_fAtmPosZ], 1.2,
            KEYNAME_YES, g_rgeATMBank[i][e_iAtmWorld], g_rgeATMBank[i][e_iAtmInterior],
            .callback_on_press = __addressof(ATM_OnPress), .cb_data = i
        );
    }

    #if defined ATM_OnScriptInit
        return ATM_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit ATM_OnScriptInit
#if defined ATM_OnScriptInit
    forward ATM_OnScriptInit();
#endif

forward ATM_OnFoundBankAccount(playerid, bank_account);
public ATM_OnFoundBankAccount(playerid, bank_account)
{
    new row_count;
    cache_get_row_count(row_count);

    if (row_count)
    {
        new name[MAX_PLAYER_NAME];
        cache_get_value_name(0, !"NAME", name);

        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            {DADADA}Balance actual: {64A752}$%s{DADADA}\n\
            {DADADA}Destinatario: {64A752}%s (%d){DADADA}\n\
            Ingrese una cantidad para transferir:\
        ",
            Format_Thousand(g_rgePlayerData[playerid][e_iPlayerBankBalance]),
            name,
            bank_account
        );

        g_rgePlayerTempData[playerid][e_iPlayerBankDest] = bank_account;

        Dialog_ShowCallback(playerid, using public _hydg@bank_transfer_amount<iiiis>, DIALOG_STYLE_INPUT, "{64A752}Banco{DADADA} - Transferir", HYAXE_UNSAFE_HUGE_STRING, "Transferir", "Cancelar");
    }
    else
    {
        PlayerPlaySound(playerid, SOUND_ERROR);
        Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "La cuenta bancaria introducida no existe.");
    }
    return 1;
}

forward ATM_OnFinishBankTransfer(playerid, bank_account, amount);
public ATM_OnFinishBankTransfer(playerid, bank_account, amount)
{
    new row_count;
    cache_get_row_count(row_count);

    if (row_count)
    {
        new current_playerid, current_connection;
        cache_get_value_name_int(0, !"CURRENT_PLAYERID", current_playerid);
        cache_get_value_name_int(0, !"CURRENT_CONNECTION", current_connection);

        Bank_RegisterTransaction(Player_AccountID(playerid), BANK_TRANSFER_SENT, amount, bank_account);
        Bank_RegisterTransaction(bank_account, BANK_TRANSFER_RECEIVED, amount, Player_AccountID(playerid));
        Bank_AddBalance(playerid, -amount, false);

        if (IsPlayerConnected(current_playerid) && current_connection)
        {
            Bank_AddBalance(current_playerid, amount);
        }
        else
        {
            mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                UPDATE `BANK_ACCOUNT` SET \
                    `BALANCE` = `BALANCE` + %d \
                WHERE `ACCOUNT_ID` = %i;\
            ", amount, bank_account);
            mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
        }

        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Se acaban de transferir ~g~$%s~w~ a la cuenta %d.", Format_Thousand(amount), bank_account);
        Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 3000, 0x64A752FF);
        PlayerPlaySound(playerid, SOUND_SUCCESS);
    }
    return 1;
}

dialog bank_deposit(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        extract inputtext -> new amount; else
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

dialog bank_withdraw(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        extract inputtext -> new amount; else
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

dialog bank_transfer(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        extract inputtext -> new bank_account; else
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Introduce un valor numérico.");
            return 1;
        }

        if (bank_account <= 0 || bank_account == Player_AccountID(playerid))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "ingrese una cuenta bancaria válida.");
            return 1;
        }

        PlayerPlaySound(playerid, SOUND_BUTTON);

        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            SELECT `ACCOUNT`.`NAME`, `BANK_ACCOUNT`.`ACCOUNT_ID` FROM `ACCOUNT`, `BANK_ACCOUNT` WHERE `ACCOUNT`.`ID` = '%i' AND `BANK_ACCOUNT`.`ACCOUNT_ID` = `ACCOUNT`.`ID`;\
        ", bank_account);
        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "ATM_OnFoundBankAccount", "id", playerid, bank_account);
    }
    else PlayerPlaySound(playerid, SOUND_BUTTON);

    return 1;
}

dialog bank_transfer_amount(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        extract inputtext -> new amount; else
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

        PlayerPlaySound(playerid, SOUND_BUTTON);

        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            SELECT `CURRENT_PLAYERID`, `CURRENT_CONNECTION` FROM `ACCOUNT` WHERE `ID` = '%i';\
        ", g_rgePlayerTempData[playerid][e_iPlayerBankDest]);
        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "ATM_OnFinishBankTransfer", "idd", playerid, g_rgePlayerTempData[playerid][e_iPlayerBankDest], amount);
    }
    else PlayerPlaySound(playerid, SOUND_BUTTON);

    return 1;
}