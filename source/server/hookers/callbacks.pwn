#if defined _hookers_callbacks_
    #endinput
#endif
#define _hookers_callbacks_

public OnGameModeInit()
{    
    for(new i = HYAXE_MAX_HOOKERS - 1; i != -1; --i)
    {
        new String:name = Str_Random(24);
        g_rgiHookers[i] = FCNPC_Create_s(name);
        str_delete(name);
    }

    #if defined HOOKERS_OnGameModeInit
        return HOOKERS_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit HOOKERS_OnGameModeInit
#if defined HOOKERS_OnGameModeInit
    forward HOOKERS_OnGameModeInit();
#endif

public OnGameModeExit()
{
    for(new i = HYAXE_MAX_HOOKERS - 1; i != -1; --i)
    {
        if(FCNPC_IsValid(g_rgiHookers[i]))
        {
            FCNPC_Destroy(g_rgiHookers[i]);
        }
    }

    #if defined HOOKERS_OnGameModeExit
        return HOOKERS_OnGameModeExit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeExit
    #undef OnGameModeExit
#else
    #define _ALS_OnGameModeExit
#endif
#define OnGameModeExit HOOKERS_OnGameModeExit
#if defined HOOKERS_OnGameModeExit
    forward HOOKERS_OnGameModeExit();
#endif