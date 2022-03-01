#if defined _utils_iterators_
    #endinput
#endif
#define _utils_iterators_

new
    IteratorArray:StreamedPlayer[MAX_PLAYERS]<MAX_PLAYERS>

public OnGameModeInit()
{
    Iter_Init(StreamedPlayer);

    #if defined HYITER_OnGameModeInit
        return HYITER_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit HYITER_OnGameModeInit
#if defined HYITER_OnGameModeInit
    forward HYITER_OnGameModeInit();
#endif

public OnPlayerStreamIn(playerid, forplayerid)
{
    Iter_Add(StreamedPlayer[forplayerid], playerid);

    #if defined ITER_OnPlayerStreamIn
        return ITER_OnPlayerStreamIn(playerid, forplayerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerStreamIn
    #undef OnPlayerStreamIn
#else
    #define _ALS_OnPlayerStreamIn
#endif
#define OnPlayerStreamIn ITER_OnPlayerStreamIn
#if defined ITER_OnPlayerStreamIn
    forward ITER_OnPlayerStreamIn(playerid, forplayerid);
#endif

public OnPlayerStreamOut(playerid, forplayerid)
{
    Iter_Remove(StreamedPlayer[forplayerid], playerid);

    #if defined ITER_OnPlayerStreamOut
        return ITER_OnPlayerStreamOut(playerid, forplayerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerStreamOut
    #undef OnPlayerStreamOut
#else
    #define _ALS_OnPlayerStreamOut
#endif
#define OnPlayerStreamOut ITER_OnPlayerStreamOut
#if defined ITER_OnPlayerStreamOut
    forward ITER_OnPlayerStreamOut(playerid, forplayerid);
#endif
