#if defined _hookers_callbacks_
    #endinput
#endif
#define _hookers_callbacks_

public OnGameModeInit()
{    
    for(new i = HYAXE_MAX_HOOKERS - 1; i != -1; --i)
    {
        g_rgiHookers[i] = FCNPC_Create_s(Str_Random(24));
        
        g_rgiHookerAreas[i] = CreateDynamicCircle(g_rgfHookerPos[i][0], g_rgfHookerPos[i][1], 5.0, .worldid = 0, .interiorid = 0);
        AttachDynamicAreaToPlayer(g_rgiHookerAreas[i], g_rgiHookers[i]);
        new info[2] = { 0x57484F52 };
        info[1] = i;
        Streamer_SetArrayData(STREAMER_TYPE_AREA, g_rgiHookerAreas[i], E_STREAMER_EXTRA_ID, info);
        
        Hooker_Spawn(i);
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