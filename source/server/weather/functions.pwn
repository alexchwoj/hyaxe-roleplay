#if defined _weather_functions_
    #endinput
#endif
#define _weather_functions_

// Clock functions
stock Clock_Initialise(msPerGameMinute = 60000, hour = 12, minute = 0)
{
    s_iMsPerClockMinute = msPerGameMinute;

    s_iLastClockTick = GetTickCount() - (minute * s_iMsPerClockMinute / 60);
    s_iClockMinutes = hour;
    s_iClockSeconds = minute;

    if (s_iClockUpdateTimer != 0)
        KillTimer(s_iClockUpdateTimer);

    s_bClockSyncToggled = true;

    s_iWeatherTypeInList = 0;
    s_iOldWeatherType = WEATHER_EXTRASUNNY_LA;
    s_iNewWeatherType = WEATHER_EXTRASUNNY_LA;
    s_iForcedWeatherType = WEATHER_UNDEFINED;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        s_bPlayerClockSyncToggled{i} = s_bClockSyncToggled;
        s_iPlayerForcedWeather[i] = s_iForcedWeatherType;
    }

    Weather_Update();

    if (s_bClockSyncToggled)
    {
        for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
        {
            if (!IsPlayerConnected(i) || IsPlayerPaused(i)) continue;

            Clock_SyncForPlayer(i);
        }
    }

    s_iClockUpdateTimer = SetTimer(#Timer_ClockUpdate, s_iMsPerClockMinute / 60, true);

    return 1;
}

stock Clock_SetTime(hour, minute)
{
    new oldMinutes = s_iClockMinutes;

    s_iLastClockTick = GetTickCount() - (minute * s_iMsPerClockMinute / 60);

    s_iClockMinutes = hour;
    s_iClockSeconds = minute;

    if (oldMinutes != s_iClockMinutes)
        Weather_Update();

    if (s_bClockSyncToggled)
    {
        for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
        {
            if (!IsPlayerConnected(i) || IsPlayerPaused(i)) continue;

            Clock_SyncForPlayer(i);
        }
    }

    return 1;
}

stock Clock_GetTime(&hour = 0, &minute = 0)
{
    hour = s_iClockMinutes;
    minute = s_iClockSeconds;

    return 1;
}

stock Clock_ToggleSync(bool:toggle, playerid = INVALID_PLAYER_ID)
{
    if (playerid == INVALID_PLAYER_ID)
    {
        s_bClockSyncToggled = toggle;

        for (new i = 0; i < MAX_PLAYERS; i++)
            s_bPlayerClockSyncToggled{i} = toggle;
    }
    else if (s_bClockSyncToggled)
        s_bPlayerClockSyncToggled{playerid} = toggle;

    return 1;
}

stock bool:Clock_SyncIsToggled(playerid = INVALID_PLAYER_ID)
    return (playerid == INVALID_PLAYER_ID ? s_bClockSyncToggled : s_bPlayerClockSyncToggled{playerid});

stock Clock_SyncForPlayer(playerid)
{
    if (s_bPlayerClockSyncToggled{playerid})
        SetPlayerTime(playerid, s_iClockMinutes, s_iClockSeconds);

    return 1;
}

// Weather functions
stock Weather_Force(weather, playerid = INVALID_PLAYER_ID, bool:now = false)
{
    if (playerid == INVALID_PLAYER_ID)
    {
        s_iForcedWeatherType = eWeatherType:weather;

        for (new i = 0; i < MAX_PLAYERS; i++)
            s_iPlayerForcedWeather[i] = s_iForcedWeatherType;

        if (now)
            Weather_Update();

        return 1;
    }
    else if (s_iForcedWeatherType == WEATHER_UNDEFINED)
    {
        s_iPlayerForcedWeather[playerid] = eWeatherType:weather;

        if (now)
            Weather_SyncForPlayer(playerid);

        return 1;
    }

    return 0;
}

stock Weather_IsForced(playerid = INVALID_PLAYER_ID)
    return (playerid == INVALID_PLAYER_ID ? (s_iForcedWeatherType != WEATHER_UNDEFINED) : (s_iPlayerForcedWeather[playerid] != WEATHER_UNDEFINED));

stock Weather_Release(playerid = INVALID_PLAYER_ID, bool:now = false)
{
    if (playerid == INVALID_PLAYER_ID)
    {
        s_iForcedWeatherType = WEATHER_UNDEFINED;

        for (new i = 0; i < MAX_PLAYERS; i++)
            s_iPlayerForcedWeather[i] = WEATHER_UNDEFINED;

        if (now)
            Weather_Update();

        return 1;
    }
    else if (s_iForcedWeatherType == WEATHER_UNDEFINED)
    {
        s_iPlayerForcedWeather[playerid] = WEATHER_UNDEFINED;

        if (now)
            Weather_SyncForPlayer(playerid);

        return 1;
    }

    return 0;
}

stock Weather_SyncForPlayer(playerid)
{
    if (s_bPlayerClockToggled{playerid})
        Clock_SyncForPlayer(playerid);

    return SetPlayerWeather(playerid, _:(s_iPlayerForcedWeather[playerid] == WEATHER_UNDEFINED ? s_iNewWeatherType : s_iPlayerForcedWeather[playerid]));
}

// Internal
stock Weather_Update()
{
    s_iOldWeatherType = s_iNewWeatherType;

    if (s_iForcedWeatherType == WEATHER_UNDEFINED)
    {
        s_iWeatherTypeInList = (s_iWeatherTypeInList + 1) % sizeof(s_iWeatherTypesListLA);

        s_iNewWeatherType = s_iWeatherTypesListLA[s_iWeatherTypeInList];

        /*if (OnWeatherTypeChange(_:s_iNewWeatherType, _:s_iOldWeatherType))
        {
            for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
            {
                if (!IsPlayerConnected(i) || IsPlayerPaused(i)) continue;

                Weather_SyncForPlayer(i);
            }
        }*/

        for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
        {
            if (!IsPlayerConnected(i) || IsPlayerPaused(i)) continue;

            Weather_SyncForPlayer(i);
        }
    }
    else
    {
        s_iOldWeatherType = s_iForcedWeatherType;
        s_iNewWeatherType = s_iForcedWeatherType;

        for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
        {
            if (!IsPlayerConnected(i) || IsPlayerPaused(i)) continue;

            Weather_SyncForPlayer(i);
        }
    }

    return 1;
}

stock bool:Clock_IsToggledForPlayer(playerid)
    return s_bPlayerClockToggled{playerid};

// Hooked functions
stock Clock_ToggleForPlayer(playerid, toggle)
{
    s_bPlayerClockToggled{playerid} = bool:toggle;

    Clock_SyncForPlayer(playerid);

    return TogglePlayerClock(playerid, toggle);
}

// Hooks: functions
#if defined _ALS_TogglePlayerClock
	#undef TogglePlayerClock
#else
	#define _ALS_TogglePlayerClock
#endif
#define TogglePlayerClock Clock_ToggleForPlayer
