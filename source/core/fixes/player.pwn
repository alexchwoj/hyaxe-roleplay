#if defined _fixes_player_
    #endinput
#endif
#define _fixes_player_

public OnPlayerConnect(playerid)
{
    TogglePlayerAllDynamicCPs(playerid, false);

    #if defined HYFIX_OnPlayerConnect
        return HYFIX_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect HYFIX_OnPlayerConnect
#if defined HYFIX_OnPlayerConnect
    forward HYFIX_OnPlayerConnect(playerid);
#endif
