#if defined _account_callbacks_
    #endinput
#endif
#define _account_callbacks_

public OnPlayerConnect(playerid)
{
    DEBUG_PRINT("OnPlayerConnect(%i)", playerid);

    TogglePlayerSpectating(playerid, true);

    GetPlayerName(playerid, Player_Name(playerid));

    static Regex:name_regex;
    if(!name_regex)
        name_regex = Regex_New("^[A-Z][a-zA-Z]+_[A-Z][a-zA-Z]+$");

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

    Player_IP(playerid) = GetPlayerRawIp(playerid);
    for(new i = 0, j = GetPlayerName(playerid, Player_RPName(playerid)); i < j; ++i)
    {
        if(g_rgePlayerData[playerid][e_szPlayerRpName][i] == '_')
            g_rgePlayerData[playerid][e_szPlayerRpName][i] = ' ';
    }

    SetPlayerNameInServerQuery(playerid, Player_RPName(playerid));
    Bit_Set(Player_Flags(playerid), PFLAG_AUTHENTICATING, true);

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        SELECT `ACCOUNT`.*, `CONNECTION_LOG`.`DATE` AS `LAST_CONNECTION` \
        FROM `ACCOUNT`, `CONNECTION_LOG` \
        WHERE \
            `ACCOUNT`.`NAME` = '%e' AND \
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

forward OnAccountInserted(playerid, callback);
public OnAccountInserted(playerid, callback)
{
    Player_AccountID(playerid) = cache_insert_id();
    Account_RegisterConnection(playerid);

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
