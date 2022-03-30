#if defined _leveling_callbacks_
    #endinput
#endif
#define _leveling_callbacks_

public OnPlayerDisconnect(playerid, reason)
{
    Timer_Kill(g_rgiLevelingTimer[playerid]);

    #if defined LEVELS_OnPlayerDisconnect
        return LEVELS_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect LEVELS_OnPlayerDisconnect
#if defined LEVELS_OnPlayerDisconnect
    forward LEVELS_OnPlayerDisconnect(playerid, reason);
#endif

public LEVELS_InterpolateTo(playerid, Float:init_x, Float:end_x, bool:new_level)
{
    log_function();

    g_rgiLevelingBarSteps{playerid}++;
    new Float:t = floatdiv(g_rgiLevelingBarSteps{playerid}, LEVEL_BAR_ANIMATION_STEPS);
    new Float:x = lerp(init_x, end_x, t);

    if(t >= 1.0)
    {
        KillTimer(g_rgiLevelingTimer[playerid]);

        if(new_level)
        {
            new number[4];
            valstr(number, Player_Level(playerid));
            PlayerTextDrawSetString(playerid, p_tdLevelingBar[playerid]{0}, number);

            valstr(number, Player_Level(playerid) + 1);
            PlayerTextDrawSetString(playerid, p_tdLevelingBar[playerid]{1}, number);

            x = LEVEL_BAR_MIN_X;
            g_rgiLevelingBarSteps{playerid} = 0;

            new Float:new_end_x = lerp(LEVEL_BAR_MIN_X, LEVEL_BAR_MAX_X, floatdiv(Player_XP(playerid), Level_GetRequiredXP(Player_Level(playerid))));
            if(new_end_x == LEVEL_BAR_MIN_X)
            {
                g_rgiLevelingTimer[playerid] = SetTimerEx("LEVELS_HideAllBars", 10000, false, "i", playerid);
            }
            else
            {
                g_rgiLevelingTimer[playerid] = SetTimerEx("LEVELS_InterpolateTo", 15, true, "iffi", playerid, LEVEL_BAR_MIN_X, new_end_x, false);
            }
        }
        else
        {
            g_rgiLevelingTimer[playerid] = SetTimerEx("LEVELS_HideAllBars", 10000, false, "i", playerid);
        }
    }

    TextDrawTextSize(g_tdLevelingBar[3], x, 75.500000);
    TextDrawShowForPlayer(playerid, g_tdLevelingBar[3]);

    return 1;
}

public LEVELS_HideAllBars(playerid)
{
    for(new i = sizeof(g_tdLevelingBar) - 1; i != -1; --i)
    {
        TextDrawHideForPlayer(playerid, g_tdLevelingBar[i]);
    }

    PlayerTextDrawHide(playerid, p_tdLevelingBar[playerid]{0});
    PlayerTextDrawHide(playerid, p_tdLevelingBar[playerid]{1});

    g_rgiLevelingTimer[playerid] = 0;

    return 1;
}