#if defined _police_callbacks_
    #endinput
#endif
#define _police_callbacks_

static PoliceLocker_OnKeyPress(playerid)
{
    return 0;
}

public OnGameModeInit()
{
    Key_Alert(0.0, 0.0, 0.0, 1.0, KEYNAME_NO, .callback_on_press = __addressof(PoliceLocker_OnKeyPress));    

    #if defined POLICE_OnGameModeInit
        return POLICE_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit POLICE_OnGameModeInit
#if defined POLICE_OnGameModeInit
    forward POLICE_OnGameModeInit();
#endif

public OnPlayerAuthenticate(playerid)
{
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "SELECT `RANK` FROM `POLICE_OFFICERS` WHERE `ACCOUNT_ID` = %i LIMIT 1;", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "POLICE_UserLoaded", "i", playerid);

    #if defined POLICE_OnPlayerAuthenticate
        return POLICE_OnPlayerAuthenticate(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerAuthenticate
    #undef OnPlayerAuthenticate
#else
    #define _ALS_OnPlayerAuthenticate
#endif
#define OnPlayerAuthenticate POLICE_OnPlayerAuthenticate
#if defined POLICE_OnPlayerAuthenticate
    forward POLICE_OnPlayerAuthenticate(playerid);
#endif

public POLICE_UserLoaded(playerid)
{
    new rowc;
    cache_get_row_count(rowc);

    if(rowc)
    {
        new rank;
        cache_get_value_name_int(0, "RANK", rank);
        if(rank > _:POLICE_RANK_NONE)
        {
            Police_Rank(playerid) = rank;
            Iter_Add(Police, playerid);
        }
    }

    return 1;
}