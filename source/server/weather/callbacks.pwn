#if defined _weather_callbacks_
    #endinput
#endif
#define _weather_callbacks_

public Timer_WeatherUpdate()
{
    g_iWeatherType = g_iWeatherTypesList[ random( sizeof(g_iWeatherTypesList) ) ];
    printf("g_iWeatherType = %d", g_iWeatherType);

    foreach(new i : LoggedIn)
    {
        if (!Bit_Get(Player_Flags(i), PFLAG_IN_GAME))
            continue;

        SetPlayerWeather(i, g_iWeatherType);
    }
    return 1;
}

public OnPlayerConnect(playerid)
{
    SetPlayerWeather(playerid, g_iWeatherType);

    #if defined Clock_OnPlayerConnect
        return Clock_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Clock_OnPlayerConnect
#if defined Clock_OnPlayerConnect
    forward Clock_OnPlayerConnect(playerid);
#endif

public OnPlayerPauseStateChange(playerid, pausestate)
{
    if (!pausestate)
    {
        SetPlayerWeather(playerid, g_iWeatherType);
    }

    #if defined Clock_OnPlayerPauseStateChange
        return Clock_OnPlayerPauseStateChange(playerid, pausestate);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerPauseStateChange
    #undef OnPlayerPauseStateChange
#else
    #define _ALS_OnPlayerPauseStateChange
#endif
#define OnPlayerPauseStateChange Clock_OnPlayerPauseStateChange
#if defined Clock_OnPlayerPauseStateChange
    forward Clock_OnPlayerPauseStateChange(playerid, pausestate);
#endif

public OnScriptInit()
{
    SetTimer("Timer_WeatherUpdate", HYAXE_WEATHER_INTERVAL, true);

    #if defined Clock_OnScriptInit
        return Clock_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit Clock_OnScriptInit
#if defined Clock_OnScriptInit
    forward Clock_OnScriptInit();
#endif
