#if defined _leveling_functions_
    #endinput
#endif
#define _leveling_functions_

static Levels_AnimateBar(playerid, start_xp, start_level = -1, bool:new_level = false)
{
    new required_xp = Level_GetRequiredXP(Player_Level(playerid));
    new Float:initial_x = lerp(LEVEL_BAR_MIN_X, LEVEL_BAR_MAX_X, floatdiv(start_xp, required_xp));
    new Float:end_x = (new_level ? LEVEL_BAR_MAX_X : lerp(LEVEL_BAR_MIN_X, LEVEL_BAR_MAX_X, floatdiv(Player_XP(playerid), required_xp)));

    g_rgiLevelingBarSteps{playerid} = 0;
    g_rgiLevelingTimer[playerid] = SetTimerEx("LEVELS_InterpolateTo", 15, true, "ifffii", playerid, initial_x, end_x, float(start_xp), (start_level == -1 ? Player_Level(playerid) : start_level), new_level);
}

Level_GetRequiredXP(level)
{
    return floatround((float(level * 2048) * 1.5) / 2.0);
}

Levels_ShowBarToPlayer(playerid)
{
    new Float:current_level_x = lerp(LEVEL_BAR_MIN_X, LEVEL_BAR_MAX_X, floatdiv(Player_XP(playerid), Level_GetRequiredXP(Player_Level(playerid))));
    TextDrawTextSize(g_tdLevelingBar[3], current_level_x, 75.500);

    for(new i = sizeof(g_tdLevelingBar) - 1; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdLevelingBar[i]);
    }

    PlayerTextDrawSetString(playerid, p_tdLevelingBar[playerid]{0}, va_return("%i", Player_Level(playerid)));
    PlayerTextDrawSetString(playerid, p_tdLevelingBar[playerid]{1}, va_return("%i", Player_Level(playerid) + 1));

    if(!IsPlayerTextDrawVisible(playerid, p_tdLevelingBar[playerid]{0}))
    {
        PlayerTextDrawShow(playerid, p_tdLevelingBar[playerid]{0});
        PlayerTextDrawShow(playerid, p_tdLevelingBar[playerid]{1});
    }

    TextDrawSetStringForPlayer(g_tdLevelingBar[5], playerid, "%i/%i", Player_XP(playerid), Level_GetRequiredXP(Player_Level(playerid)));

    return 1;
}

Player_AddXP(playerid, xp)
{
    if(g_rgiLevelingTimer[playerid])
    {
        KillTimer(g_rgiLevelingTimer[playerid]);
    }

    new max_xp = Level_GetRequiredXP(Player_Level(playerid));
    new const bool:animate = !Bit_Get(Player_Config(playerid), CONFIG_PERFORMANCE_MODE) && Performance_IsFine(playerid);

    if(animate)
    {
        Levels_ShowBarToPlayer(playerid);
    }

    new current_xp = Player_XP(playerid);
    new new_xp = clamp(current_xp + xp, 0, max_xp);
    if(new_xp == max_xp)
    {
        new current_level = Player_Level(playerid);

        new total_xp = current_xp + xp;
        do
        {
            total_xp -= Level_GetRequiredXP(Player_Level(playerid));
            Player_Level(playerid)++;
        }
        while(total_xp >= Level_GetRequiredXP(Player_Level(playerid)));

        Player_XP(playerid) = total_xp;
        SetPlayerScore(playerid, Player_Level(playerid));

        if(animate)
            Levels_AnimateBar(playerid, current_xp, .start_level = current_level, .new_level = true);
        else
        {
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Subiste al nivel ~r~%i~w~.", Player_Level(playerid));
            Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 7000);
        }
    }
    else
    {
        Player_XP(playerid) = new_xp;
        
        if(animate)
            Levels_AnimateBar(playerid, current_xp);
    }

    if(!animate)
    {
        Levels_ShowBarToPlayer(playerid);
        g_rgiLevelingTimer[playerid] = SetTimerEx("LEVELS_HideAllBars", 10000, false, "i", playerid);
    }

    return 1;
}

Player_SetLevel(playerid, level)
{
    if(level < 1)
        return 0;
    
    if(Player_Level(playerid) == level)
        return 0;

    if(g_rgiLevelingTimer[playerid])
    {
        KillTimer(g_rgiLevelingTimer[playerid]);
    }

    if(Player_Level(playerid) > level)
    {
        Player_XP(playerid) = 0;
        Player_Level(playerid) = level;
        Levels_ShowBarToPlayer(playerid);
        g_rgiLevelingTimer[playerid] = SetTimerEx("LEVELS_HideAllBars", 10000, false, "i", playerid);
    }
    else
    {
        new old_xp = Player_XP(playerid);
        new old_level = Player_Level(playerid);

        Levels_ShowBarToPlayer(playerid);

        Player_XP(playerid) = 0;
        Player_Level(playerid) = level;

        Levels_AnimateBar(playerid, old_xp, old_level, true);
    }

    SetPlayerScore(playerid, Player_Level(playerid));
    
    return 1;
}

command add_xp(playerid, const params[], "Dar experiencia a un jugador")
{
    new destination, xp;
    if(sscanf(params, "ri", destination, xp))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/add_xp {DADADA}<jugador> <experiencia>");
        return 1;
    }

    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Le diste {ED2B2B}%i{DADADA} puntos de experiencia a {ED2B2B}%s{DADADA}.", xp, Player_RPName(destination));
    if(destination != playerid)
    {
        SendClientMessagef(destination, 0xED2B2BFF, "›{DADADA} Un administrador te asignó {ED2B2B}%i{DADADA} puntos de experiencia.", xp);
    }

    Player_AddXP(destination, xp);

    return 1;
}
flags:add_xp(CMD_FLAG<RANK_LEVEL_ADMINISTRATOR>)

command set_level(playerid, const params[], "Asigna el nivel de un jugador")
{
    new destination, level;
    if(sscanf(params, "ri", destination, level))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/set_level {DADADA}<jugador> <nivel>");
        return 1;
    }

    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Asignaste el nivel {ED2B2B}%i{DADADA} para {ED2B2B}%s{DADADA}.", level, Player_RPName(destination));
    if(destination != playerid)
    {
        SendClientMessagef(destination, 0xED2B2BFF, "›{DADADA} Un administrador te asignó el nivel {ED2B2B}%i{DADADA}.", level);
    }

    Player_SetLevel(destination, level);

    return 1;
}
flags:set_level(CMD_FLAG<RANK_LEVEL_ADMINISTRATOR>)
