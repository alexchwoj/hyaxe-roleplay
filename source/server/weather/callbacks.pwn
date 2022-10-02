#if defined _weather_callbacks_
    #endinput
#endif
#define _weather_callbacks_

public Timer_WeatherUpdate()
{
    g_iWeatherIndex ++;
    if (g_iWeatherIndex >= sizeof(g_iWeatherTypesList))
        g_iWeatherIndex = 0;

    g_iWeatherType = g_iWeatherTypesList[g_iWeatherIndex];
    printf("[wather:dbg] g_iWeatherType = %d, g_iWeatherIndex = %d", g_iWeatherType, g_iWeatherIndex);

    foreach(new i : LoggedIn)
    {
        if (!Bit_Get(Player_Flags(i), PFLAG_IN_GAME) || Bit_Get(Player_Config(i), CONFIG_PERFORMANCE_MODE))
            continue;

        SetPlayerWeather(i, g_iWeatherType);
    }
    return 1;
}

public OnPlayerAuthenticate(playerid)
{
    if (!Bit_Get(Player_Config(playerid), CONFIG_PERFORMANCE_MODE))
        SetPlayerWeather(playerid, g_iWeatherType);

    #if defined WEATHER_OnPlayerAuthenticate
        return WEATHER_OnPlayerAuthenticate(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerAuthenticate
    #undef OnPlayerAuthenticate
#else
    #define _ALS_OnPlayerAuthenticate
#endif
#define OnPlayerAuthenticate WEATHER_OnPlayerAuthenticate
#if defined WEATHER_OnPlayerAuthenticate
    forward WEATHER_OnPlayerAuthenticate(playerid);
#endif

public OnPlayerPauseStateChange(playerid, pausestate)
{
    if (!pausestate && !Bit_Get(Player_Config(playerid), CONFIG_PERFORMANCE_MODE))
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
