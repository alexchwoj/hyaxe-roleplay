#if defined _events_callbacks_
    #endinput
#endif
#define _events_callbacks_

public OnGameModeInit()
{
    SetTimer("GVENT_CheckTime", 30000, true);

    #if defined GVENT_OnGameModeInit
        return GVENT_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit GVENT_OnGameModeInit
#if defined GVENT_OnGameModeInit
    forward GVENT_OnGameModeInit();
#endif

forward GVENT_CheckTime();
public GVENT_CheckTime()
{
    new hour, minute;
    gettime(hour, minute);
    return 1;
}