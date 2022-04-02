#if defined _needs_functions_
    #endinput
#endif
#define _needs_functions_

static Needs_UpdateBar(playerid, bool:hunger = true, bool:thirst = true, bool:show_always = false)
{
    if(show_always || IsPlayerTextDrawVisible(playerid, p_tdNeedBars[playerid]{0}))
    {
        if(thirst)
        {
            const Float:THIRST_BAR_MIN = 517.320;
            const Float:THIRST_BAR_MAX = 557.785;
            new Float:x = lerp(THIRST_BAR_MIN, THIRST_BAR_MAX, Player_Thirst(playerid) / 100.0);
            PlayerTextDrawTextSize(playerid, p_tdNeedBars[playerid]{0}, x, 75.0);
            PlayerTextDrawShow(playerid, p_tdNeedBars[playerid]{0});
        }

        if(hunger)
        {
            const Float:HUNGER_BAR_MIN = 563.350;
            const Float:HUNGER_BAR_MAX = 604.050;
            new Float:x = lerp(HUNGER_BAR_MIN, HUNGER_BAR_MAX, Player_Hunger(playerid) / 100.0);
            PlayerTextDrawTextSize(playerid, p_tdNeedBars[playerid]{1}, x, 75.0);
            PlayerTextDrawShow(playerid, p_tdNeedBars[playerid]{1});
        }
    }

    return 1;
}

Needs_StartUpdating(playerid)
{
    if(!g_rgeNeedsTimers[playerid][e_iNeedsTimerUpdateHunger])
        g_rgeNeedsTimers[playerid][e_iNeedsTimerUpdateHunger] = SetTimerEx(!"NEEDS_ProcessHunger", 120000, true, !"i", playerid);

    if(!g_rgeNeedsTimers[playerid][e_iNeedsTimerUpdateThirst])
        g_rgeNeedsTimers[playerid][e_iNeedsTimerUpdateHunger] = SetTimerEx(!"NEEDS_ProcessThirst", 60000, true, !"i", playerid);
}

Needs_StopUpdating(playerid)
{
    if(g_rgeNeedsTimers[playerid][e_iNeedsTimerUpdateHunger])
        KillTimer(g_rgeNeedsTimers[playerid][e_iNeedsTimerUpdateHunger]);

    if(g_rgeNeedsTimers[playerid][e_iNeedsTimerUpdateThirst])
        KillTimer(g_rgeNeedsTimers[playerid][e_iNeedsTimerUpdateThirst]);

    g_rgeNeedsTimers[playerid][e_iNeedsTimerUpdateHunger] =    
    g_rgeNeedsTimers[playerid][e_iNeedsTimerUpdateThirst] = 0;
}

Player_SetThirst(playerid, Float:thirst)
{
    Player_Thirst(playerid) = fclamp(thirst, 0.0, 100.0);
    Needs_UpdateBar(playerid, false, true);
}

Player_SetHunger(playerid, Float:hunger)
{
    Player_Hunger(playerid) = fclamp(hunger, 0.0, 100.0);
    Needs_UpdateBar(playerid, true, false);
}

Player_AddThirst(playerid, Float:thirst)
{
    Player_Thirst(playerid) = fclamp(Player_Thirst(playerid) + thirst, 0.0, 100.0);
    Needs_UpdateBar(playerid, false, true);
}

Player_AddHunger(playerid, Float:hunger)
{
    Player_Hunger(playerid) = fclamp(Player_Hunger(playerid) + hunger, 0.0, 100.0);
    Needs_UpdateBar(playerid, true, false);
}

Needs_ShowBars(playerid)
{
    for(new i = sizeof(g_tdNeedBars) - 1; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdNeedBars[i]);
    }

    Needs_UpdateBar(playerid, .show_always = true);
    return 1;
}

Player_Puke(playerid)
{
    log_function();

    Player_StopShopping(playerid);
    g_rgePlayerTempData[playerid][e_iPlayerEatCount] = 0;
    g_rgePlayerTempData[playerid][e_iPlayerPukeTick] = GetTickCount();
    Bit_Set(Player_Flags(playerid), PFLAG_IS_PUKING, true);

    SetPlayerFacingAngle(playerid, 0.0);
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    ApplyAnimation(playerid, "FOOD", "EAT_VOMIT_P", 4.1, false, false, false, true, 0);
    Sound_PlayInRange(SOUND_PUKE, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

    g_rgeNeedsTimers[playerid][e_iNeedsTimerVomit] = SetTimerEx("NEEDS_VomitStepOne", 3500, false, !"i", playerid);
    return 1;
}

command set_thirst(playerid, const params[], "Asigna la sed de un jugador")
{
    new destination, Float:thirst;

    if(sscanf(params, "rf", destination, thirst) || !(0.0 <= thirst <= 100.0))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/set_thirst {DADADA}<jugador> <nivel de sed [0.0, 100.0]>");
        return 1;
    }

    Player_SetThirst(destination, thirst);
    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Le asignaste {ED2B2B}%.2f{DADADA} puntos de sed a {ED2B2B}%s{DADADA}.", thirst, Player_RPName(destination));

    return 1;
}
flags:set_thirst(CMD_RANK<RANK_LEVEL_MODERATOR>)

command set_hunger(playerid, const params[], "Asigna el hambre de un jugador")
{
    new destination, Float:hunger;

    if(sscanf(params, "rf", destination, hunger) || !(0.0 <= hunger <= 100.0))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/set_hunger {DADADA}<jugador> <nivel de hambre [0.0, 100.0]>");
        return 1;
    }

    Player_SetHunger(destination, hunger);
    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Le asignaste {ED2B2B}%.2f{DADADA} puntos de hambre a {ED2B2B}%s{DADADA}.", hunger, Player_RPName(destination));

    return 1;
}
flags:set_hunger(CMD_RANK<RANK_LEVEL_MODERATOR>)
