#if defined _controller_callbacks_
    #endinput
#endif
#define _controller_callbacks_

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if (clickedid == g_tdController[0]) // Space
    {
        CallLocalFunction("OnPlayerKeyStateChange", "iii", playerid, KEY_SPRINT, 0);
    }
    else if (clickedid == g_tdController[1]) // Enter
    {
        CallLocalFunction("OnPlayerKeyStateChange", "iii", playerid, KEY_SECONDARY_ATTACK, 0);
    }
    else if (clickedid == g_tdController[2]) // W
    {
        g_rgiPlayerUpDownKeys[playerid] = KEY_UP;
    }
    else if (clickedid == g_tdController[3]) // S
    {
        g_rgiPlayerUpDownKeys[playerid] = KEY_DOWN;
    }
    else if (clickedid == g_tdController[4]) // A
    {
        g_rgiPlayerLeftRightKeys[playerid] = KEY_LEFT;
    }
    else if (clickedid == g_tdController[5]) // D
    {
        g_rgiPlayerLeftRightKeys[playerid] = KEY_RIGHT;
    }

    #if defined CONT_OnPlayerClickTextDraw
        return CONT_OnPlayerClickTextDraw(playerid, clickedid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw CONT_OnPlayerClickTextDraw
#if defined CONT_OnPlayerClickTextDraw
    forward CONT_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    g_rgiPlayerUpDownKeys[playerid] = 0;
    g_rgiPlayerLeftRightKeys[playerid] = 0;

    #if defined CONT_OnPlayerDisconnect
        return CONT_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect CONT_OnPlayerDisconnect
#if defined CONT_OnPlayerDisconnect
    forward CONT_OnPlayerDisconnect(playerid, reason);
#endif