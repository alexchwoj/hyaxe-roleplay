#if defined _needs_functions_
    #endinput
#endif
#define _needs_functions_

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
}

Player_SetThirst(playerid, Float:thirst)
{
    Player_Thirst(playerid) = fclamp(thirst, 0.0, 100.0);
}

Player_SetHunger(playerid, Float:hunger)
{
    Player_Hunger(playerid) = fclamp(hunger, 0.0, 100.0);
}

Player_AddThirst(playerid, Float:thirst)
{
    Player_Thirst(playerid) = fclamp(Player_Thirst(playerid) + thirst, 0.0, 100.0);
}

Player_AddHunger(playerid, Float:hunger)
{
    Player_Hunger(playerid) = fclamp(Player_Hunger(playerid) + hunger, 0.0, 100.0);
}