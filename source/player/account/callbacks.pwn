#if defined _account_callbacks_
    #endinput
#endif
#define _account_callbacks_

public OnPlayerConnect(playerid)
{
    log_function();

    SetPlayerColor(playerid, 0xF7F7F700);
    TogglePlayerSpectating(playerid, true);

    GetPlayerName(playerid, Player_Name(playerid));

    static Regex:name_regex;
    if(!name_regex)
        name_regex = Regex_New("^[A-Z][a-zA-Z]+[ _][A-Z][a-zA-Z]+$");

    if(!Regex_Check(Player_Name(playerid), name_regex))
    {
        ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{CB3126}Hyaxe", 
            "{DADADA}Tu nombre no es adecuado, usa: {CB3126}N{DADADA}ombre_{CB3126}A{DADADA}pellido.\n\
            Recuerda que los nombres como {CB3126}Miguel_Gamer{DADADA} o que contengan insultos\n\
            no están permitidos, procura ponerte un nombre que parezca real.",
        "Entendido", "");
        KickTimed(playerid, 500);
        return 1;
    }

    EnablePlayerCameraTarget(playerid, true);
    
    Player_IP(playerid) = GetPlayerRawIp(playerid);
    strcpy(Player_RPName(playerid), Player_Name(playerid));

    new space_idx = strfind(Player_Name(playerid), !"_");
    if(space_idx != -1)
    {
        Player_RPName(playerid)[space_idx] = ' ';
    }
    else
    {
        space_idx = strfind(Player_RPName(playerid), !" ");
        Player_Name(playerid)[space_idx] = '_';
    }

    SetPlayerNameInServerQuery(playerid, Player_RPName(playerid));

    Bit_Set(Player_Flags(playerid), PFLAG_AUTHENTICATING, true);

    new ip[17];
    GetPlayerIp(playerid, ip);

    // Check if the user is banned
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        SELECT \
            `BANS`.*, \
            `ACCOUNT`.`NAME` AS `ADMIN_NAME`, \
            CURRENT_TIMESTAMP() AS `CURRENT_TIME`, \
            (`EXPIRATION_DATE` > CURRENT_TIMESTAMP()) AS `STILL_VALID` \
        FROM `BANS` \
            LEFT JOIN `ACCOUNT` \
                ON `BANS`.`ADMIN_ID` = `ACCOUNT`.`ID` \
            WHERE `BANS`.`BANNED_USER` = '%e' OR `BANS`.`BANNED_IP` = '%e '\
        LIMIT 1;\
    ", 
        Player_Name(playerid), ip
    );
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "ACCOUNT_CheckForBans", "i", playerid);

    #if defined ACC_OnPlayerConnect
        return ACC_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect ACC_OnPlayerConnect
#if defined ACC_OnPlayerConnect
    forward ACC_OnPlayerConnect(playerid);
#endif

public ACCOUNT_CheckForBans(playerid)
{
    new rowc;
    cache_get_row_count(rowc);

    if(rowc)
    {
        new bool:still_valid_null;
        cache_is_value_name_null(0, !"STILL_VALID", still_valid_null);

        new bool:still_valid = still_valid_null;
        if(!still_valid_null)
        {
            cache_get_value_name_int(0, !"STILL_VALID", _:still_valid);
        }

        if(still_valid)
        {
            new bool:is_anticheat, admin_account_id_string[40], admin_name[24] = "Anticheat";
            cache_is_value_name_null(0, !"ADMIN_ID", is_anticheat);
            if(!is_anticheat)
            {
                new admin_account_id;
                cache_get_value_name_int(0, !"ADMIN_ID", admin_account_id);
                format(admin_account_id_string, sizeof(admin_account_id_string), "({CB3126}%i{DADADA})", admin_account_id);
                cache_get_value_name(0, !"ADMIN_NAME", admin_name);
            }

            new banned_name[25], issued_date[21], expiration_date[21] = "Indefinida", reason[51];
            cache_get_value_name(0, !"ISSUED_DATE", issued_date);
            cache_get_value_name(0, !"REASON", reason);

            new bool:is_permanent;
            cache_is_value_name_null(0, !"EXPIRATION_DATE", is_permanent);
            if(!is_permanent)
                cache_get_value_name(0, !"EXPIRATION_DATE", expiration_date);

            new bool:is_name_banned;
            cache_is_value_name_null(0, !"BANNED_IP", is_name_banned);
            if(!is_name_banned)
            {
                cache_get_value_name(0, !"BANNED_IP", banned_name);
            }
            else
            {
                strcat(banned_name, Player_RPName(playerid));
            }

            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                {DADADA}Esta %s está expulsada %s del servidor.\n\n\
                {CB3126}%s\n\t{DADADA}%s\n\n\
                {CB3126}Administrador\n\t{DADADA}%s %s\n\n\
                {CB3126}Razón de la expulsión\n\t{DADADA}%s\n\n\
                {CB3126}Fecha de expulsión\n\t{DADADA}%s\n\n\
                {CB3126}Fecha de expiración\n\t{DADADA}%s\
            ",
                (is_name_banned ? "cuenta" : "dirección IP"), (is_permanent ? "permanentemente" : "temporalmente"),
                (is_name_banned ? "Cuenta" : "Dirección IP"), banned_name, admin_name, admin_account_id_string,
                reason, issued_date, expiration_date
            );
            Dialog_Show(playerid, "kick", DIALOG_STYLE_MSGBOX, "{CB3126}Hyaxe {DADADA}- Expulsión", HYAXE_UNSAFE_HUGE_STRING, "Salir");
            KickTimed(playerid, 500);

            return 1;
        }

        mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "DELETE FROM `BANS` WHERE `BANNED_USER` = '%e' OR `BANNED_IP` = '%e';", Player_Name(playerid), Player_IP(playerid));
        mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
    }

    SetPlayerName(playerid, Player_RPName(playerid));

    SendRPC(playerid, 11,
        BS_UNSIGNEDSHORT, playerid,
        BS_UNSIGNEDCHAR, strlen(Player_RPName(playerid)),
        BS_STRING, Player_RPName(playerid),
        BS_UNSIGNEDCHAR, 1
    );

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        SELECT `ACCOUNT`.*, `PLAYER_WEAPONS`.*, `CONNECTION_LOG`.`DATE` AS `LAST_CONNECTION` \
        FROM `ACCOUNT`, `PLAYER_WEAPONS`, `CONNECTION_LOG` \
        WHERE \
            `ACCOUNT`.`NAME` = '%e' AND \
            `PLAYER_WEAPONS`.`ACCOUNT_ID` = `ACCOUNT`.`ID` AND \
            `CONNECTION_LOG`.`ACCOUNT_ID` = `ACCOUNT`.`ID` \
        ORDER BY `CONNECTION_LOG`.`DATE` DESC \
        LIMIT 1;\
    ", Player_Name(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, !"OnPlayerDataFetched", !"i", playerid);

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(Player_Cache(playerid) != MYSQL_INVALID_CACHE)
        cache_delete(Player_Cache(playerid));

    Account_Save(playerid, true);

    g_rgePlayerData[playerid] = g_rgePlayerData[MAX_PLAYERS];
    Player_Gang(playerid) = -1;
    Player_ResetTemp(playerid);
    Bit_SetAll(Player_Flags(playerid), false);

    if(Iter_Contains(LoggedIn, playerid))
    {
        if(Iter_Contains(Admin, playerid))
            Iter_Remove(Admin, playerid);

        if(Iter_Contains(Police, playerid))
            Iter_Remove(Police, playerid);

        if(Player_Gang(playerid) != -1)
            Iter_Remove(GangMember[Player_Gang(playerid)], playerid);

        Iter_Remove(LoggedIn, playerid);
    }

    #if defined ACC_OnPlayerDisconnect
        return ACC_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect ACC_OnPlayerDisconnect
#if defined ACC_OnPlayerDisconnect
    forward ACC_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerDataFetched(playerid)
{
    log_function();

    new rowc;
    cache_get_row_count(rowc);

    if(rowc)
    {
        Bit_Set(Player_Flags(playerid), PFLAG_REGISTERED, true);
        cache_get_value_name_int(0, !"ID", Player_AccountID(playerid));
        cache_get_value_name(0, !"PASSWORD", Player_Password(playerid));
        cache_get_value_name(0, !"LAST_CONNECTION", Player_LastConnection(playerid));
        Player_Cache(playerid) = cache_save();
    }

    CallLocalFunction(!"OnPlayerDataLoaded", !"i", playerid);

    #if defined ACC_OnPlayerDataFetched
        return ACC_OnPlayerDataFetched(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDataFetched
    #undef OnPlayerDataFetched
#else
    #define _ALS_OnPlayerDataFetched
#endif
#define OnPlayerDataFetched ACC_OnPlayerDataFetched
#if defined ACC_OnPlayerDataFetched
    forward ACC_OnPlayerDataFetched(playerid);
#endif

public OnAccountInserted(playerid, callback)
{
    Bit_Set(Player_Flags(playerid), PFLAG_REGISTERED, true);
    Bit_Set(Player_Flags(playerid), PFLAG_IN_GAME, true);
 
    cache_get_value_name_int(0, "ACCOUNT_ID", Player_AccountID(playerid));
    DEBUG_PRINT("[account] Registered player %i with account ID %i", playerid, Player_AccountID(playerid));

    if(callback != -1)
    {
        __emit {
            push.s playerid
            push.c 4
            lctrl 6
            add.c 0x24
            lctrl 8
            push.pri
            load.s.pri callback
            sctrl 6
        }
    }

    return 1;
}
