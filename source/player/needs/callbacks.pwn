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

public NEEDS_VomitStepOne(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    new object = CreateObject(18722, x + 0.355, y - 0.116, z - 1.6, 0.0, 0.0, 0.0);
    
    g_rgeNeedsTimers[playerid][e_iNeedsTimerVomit] = SetTimerEx("NEEDS_VomitStepTwo", 3500, false, !"ii", playerid, object);
}

public NEEDS_VomitStepTwo(playerid, objectid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_IS_PUKING, false);
    DestroyObject(objectid);
    ClearAnimations(playerid);
    return 1;
}
