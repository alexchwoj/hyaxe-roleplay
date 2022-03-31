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

public LEVELS_InterpolateTo(playerid, Float:init_x, Float:end_x, Float:start_xp, start_level, bool:new_level)
{
    log_function();

    g_rgiLevelingBarSteps{playerid}++;
    new Float:t = floatdiv(g_rgiLevelingBarSteps{playerid}, LEVEL_BAR_ANIMATION_STEPS);
    new Float:x = lerp(init_x, end_x, t);
    new xp_bar_str = floatround(lerp(start_xp, float(new_level ? Level_GetRequiredXP(start_level) : Player_XP(playerid)), t));

    TextDrawTextSize(g_tdLevelingBar[3], x, 75.500000);
    TextDrawShowForPlayer(playerid, g_tdLevelingBar[3]);
    TextDrawSetStringForPlayer(g_tdLevelingBar[5], playerid, "%i/%i", xp_bar_str, Level_GetRequiredXP((new_level ? start_level : Player_Level(playerid))));

    if(t >= 1.0)
    {
        KillTimer(g_rgiLevelingTimer[playerid]);

        if(new_level)
        {
            await TD_Fade(playerid, p_tdLevelingBar[playerid]{1}, 3, 10);

            PlayerTextDrawSetString_s(playerid, p_tdLevelingBar[playerid]{0}, @f("%i", Player_Level(playerid)));
            PlayerTextDrawSetString_s(playerid, p_tdLevelingBar[playerid]{1}, @f("%i", Player_Level(playerid) + 1));

            g_rgiLevelingBarSteps{playerid} = 0;

            new Float:new_end_x = lerp(LEVEL_BAR_MIN_X, LEVEL_BAR_MAX_X, floatdiv(Player_XP(playerid), Level_GetRequiredXP(Player_Level(playerid))));
            if(new_end_x == LEVEL_BAR_MIN_X)
            {
                g_rgiLevelingTimer[playerid] = SetTimerEx("LEVELS_HideAllBars", 10000, false, "i", playerid);
            }
            else
            {
                g_rgiLevelingTimer[playerid] = SetTimerEx("LEVELS_InterpolateTo", 15, true, "ifffii", playerid, LEVEL_BAR_MIN_X, new_end_x, start_xp, start_level, false);
            }

            return 1;
        }
        else
        {
            g_rgiLevelingTimer[playerid] = SetTimerEx("LEVELS_HideAllBars", 10000, false, "i", playerid);
        }
    }

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