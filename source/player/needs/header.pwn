#if defined _needs_header_
    #endinput
#endif
#define _needs_header_

const Float:HUNGER_INCREMENT_AMOUNT = 0.5;
const Float:THIRST_INCREMENT_AMOUNT = 0.5;

enum eNeedsTimers
{
    e_iNeedsTimerUpdateThirst,
    e_iNeedsTimerUpdateHunger
};

new g_rgeNeedsTimers[MAX_PLAYERS][eNeedsTimers];

forward Needs_StartUpdating(playerid);
forward Needs_StopUpdating(playerid);

forward Player_SetThirst(playerid, Float:thirst);
forward Player_SetHunger(playerid, Float:hunger);
forward Player_AddThirst(playerid, Float:thirst);
forward Player_AddHunger(playerid, Float:hunger);

forward NEEDS_ProcessHunger(playerid);
forward NEEDS_ProcessThirst(playerid);