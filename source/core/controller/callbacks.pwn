#if defined _controller_callbacks_
    #endinput
#endif
#define _controller_callbacks_

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    printf("newkeys = %d", newkeys);

    #if defined CONT_OnPlayerKeyStateChange
        return CONT_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange CONT_OnPlayerKeyStateChange
#if defined CONT_OnPlayerKeyStateChange
    forward CONT_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if (clickedid == g_tdController[0])
    {

    }
    else if (clickedid == g_tdController[1])
    {

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