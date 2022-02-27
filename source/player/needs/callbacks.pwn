#if defined _needs_callbacks_
    #endinput
#endif
#define _needs_callbacks_

public NEEDS_ProcessHunger(playerid)
{
    Player_AddHunger(playerid, HUNGER_INCREMENT_AMOUNT);
    return 1;
}

public NEEDS_ProcessThirst(playerid)
{
    Player_AddThirst(playerid, THIRST_INCREMENT_AMOUNT);
    return 1;
}
