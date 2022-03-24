#if defined _account_callbacks_
    #endinput
#endif
#define _account_callbacks_

public OnPlayerConnect(playerid)
{
    LogThisFunction();

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
            Recuerda que los nombres como Miguel_Gamer o que contengan insultos\n\
            no están permitidos, procura ponerte un nombre que parezca real.",
        "Entendido", "");
        KickTimed(playerid, 500);
        return 1;
    }

    EnablePlayerCameraTarget(playerid, true);
    
    Player_IP(playerid) = GetPlayerRawIp(playerid);
    
    strcpy(Player_RPName(playerid), Player_Name(playerid));

    new idx = 0;
    while((idx = strfind(Player_Name(playerid), " ", .pos = idx)) != -1)
    {
        Player_Name(playerid)[idx] = '_';
    }

    idx = 0;
    while((idx = strfind(Player_RPName(playerid), "_", .pos = idx)) != -1)
    {
        Player_RPName(playerid)[idx] = ' ';
    }

    SetPlayerNameInServerQuery(playerid, Player_RPName(playerid));
    SetPlayerName(playerid, Player_RPName(playerid));

    new BitStream:bs = BS_New();
    BS_WriteValue(bs,
        PR_UINT16, playerid,
        PR_UINT8, strlen(Player_RPName(playerid)),
        PR_STRING, Player_RPName(playerid),
        PR_UINT8, 1
    );
    PR_SendRPC(bs, playerid, 11, PR_HIGH_PRIORITY, PR_RELIABLE);
    BS_Delete(bs);

    Bit_Set(Player_Flags(playerid), PFLAG_AUTHENTICATING, true);

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

public OnPlayerDisconnect(playerid, reason)
{
    if(Player_Cache(playerid) != MYSQL_INVALID_CACHE)
        cache_delete(Player_Cache(playerid));

    Account_Save(playerid, true);

    g_rgePlayerData[playerid] = g_rgePlayerData[MAX_PLAYERS];
    Player_ResetTemp(playerid);
    Bit_SetAll(Player_Flags(playerid), false);

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
    DEBUG_PRINT("OnPlayerDataFetched(%i)", playerid);

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
    Player_AccountID(playerid) = cache_insert_id();
    Account_RegisterConnection(playerid);

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        INSERT INTO `PLAYER_WEAPONS` (`ACCOUNT_ID`) VALUES (%i); \
        INSERT INTO `BANK_ACCOUNT` (`ACCOUNT_ID`) VALUES (%i); \
        INSERT INTO `CONNECTION_LOG` (`ACCOUNT_ID`, `IP_ADDRESS`) VALUES (%i, '%e');\
    ", Player_AccountID(playerid), Player_AccountID(playerid), RawIpToString(Player_IP(playerid)), Player_AccountID(playerid));

    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, !"OnAccountFullyInserted", !"ii", playerid, callback);

    return 1;
}

public OnAccountFullyInserted(playerid, callback)
{
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
