#if defined _weather_callbacks_
    #endinput
#endif
#define _weather_callbacks_

// Timers
public Timer_ClockUpdate()
{
    // Next minute
    s_iClockSeconds = (GetTickCount() - s_iLastClockTick) * 60 / s_iMsPerClockMinute;

    if (s_iClockSeconds >= 60)
    {
        s_iLastClockTick += s_iMsPerClockMinute;
        s_iClockSeconds = 0;

        // Next hour
        ++s_iClockMinutes;
        if (s_iClockMinutes >= 24)
            s_iClockMinutes = 0;

        // Update weather
        Weather_Update();
    }

    // Sync players
    if (s_bClockSyncToggled)
    {
        for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
        {
            if (!IsPlayerConnected(i) || IsPlayerPaused(i)) continue;

            if (!s_bPlayerClockToggled{i} || (s_iMsPerClockMinute / 60) != 1000)
                Clock_SyncForPlayer(i);
        }
    }

    // GameTextForAll(sprintf("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~y~Update interval: ~w~%d~n~~y~Clock: ~w~%02d:%02d", (s_iMsPerClockMinute / 60), s_iClockMinutes, s_iClockSeconds), (s_iMsPerClockMinute / 60) + 250, 3);

    return 1;
}

public OnPlayerConnect(playerid)
{
    Clock_SyncForPlayer(playerid);
    Weather_SyncForPlayer(playerid);

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

public OnPlayerDisconnect(playerid, reason)
{
    s_bPlayerClockSyncToggled{playerid} = s_bClockSyncToggled;
    s_iPlayerForcedWeather[playerid] = s_iForcedWeatherType;
    s_bPlayerClockToggled{playerid} = false;

    #if defined Clock_OnPlayerDisconnect
        return Clock_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect Clock_OnPlayerDisconnect
#if defined Clock_OnPlayerDisconnect
    forward Clock_OnPlayerDisconnect(playerid, reason);
#endif

/*public OnWeatherTypeChange(newweather, oldweater)
{
    #if defined Clock_OnWeatherTypeChange
        return Clock_OnWeatherTypeChange(newweather, oldweater);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnWeatherTypeChange
    #undef OnWeatherTypeChange
#else
    #define _ALS_OnWeatherTypeChange
#endif
#define OnWeatherTypeChange Clock_OnWeatherTypeChange
#if defined Clock_OnWeatherTypeChange
    forward Clock_OnWeatherTypeChange(newweather, oldweater);
#endif*/


public OnPlayerPauseStateChange(playerid, pausestate)
{
    if (!pausestate)
    {
        if (s_bClockSyncToggled)
            Clock_SyncForPlayer(playerid);

        Weather_SyncForPlayer(playerid);
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