#if defined _weapons_callbacks_
    #endinput
#endif
#define _weapons_callbacks_

public OnPlayerConnect(playerid)
{
    #if defined WP_OnPlayerConnect
        return WP_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect WP_OnPlayerConnect
#if defined WP_OnPlayerConnect
    forward WP_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    #if defined WP_OnPlayerDisconnect
        return WP_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect WP_OnPlayerDisconnect
#if defined WP_OnPlayerDisconnect
    forward WP_OnPlayerDisconnect(playerid, reason);
#endif