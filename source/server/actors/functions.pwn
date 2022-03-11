#if defined _actors_functions_
    #endinput
#endif
#define _actors_functions_

static Actor_FindRobbableFreeIndex()
{
    for(new i; i < MAX_ROBBABLE_ACTORS; ++i)
    {
        if(!g_rgeRobbableActors[i][e_bValid])
            return i;
    }

    return -1;
}

Actor_CreateRobbable(model, min_money, max_money, Float:x, Float:y, Float:z, Float:angle, worldid = -1, interiorid = -1)
{
    new idx = Actor_FindRobbableFreeIndex();
    if(idx == -1)
    {
        print("[actors!] Couldn't find free index for a robbable actor.");
        return -1;
    }

    new id = CreateDynamicActor(model, x, y, z, angle, .worldid = worldid, .interiorid = interiorid);
    Streamer_SetIntData(STREAMER_TYPE_ACTOR, id, E_STREAMER_EXTRA_ID, idx);

    g_rgeRobbableActors[idx][e_bValid] = true;
    g_rgeRobbableActors[idx][e_iActorId] = id;
    g_rgeRobbableActors[idx][e_iMinMoneyReward] = min_money;
    g_rgeRobbableActors[idx][e_iMaxMoneyReward] = max_money;
    g_rgeRobbableActors[idx][e_iLastStealTick] = GetTickCount();
    g_rgeRobbableActors[idx][e_iRobbingPlayer] = INVALID_PLAYER_ID;

    return idx;
}

Actor_Rob(playerid, actorid)
{
    new id = Streamer_GetIntData(STREAMER_TYPE_ACTOR, actorid, E_STREAMER_EXTRA_ID);

    if(!(0 <= id < sizeof(g_rgeRobbableActors)) || !g_rgeRobbableActors[id][e_bValid] || g_rgeRobbableActors[id][e_iRobbingPlayer] != INVALID_PLAYER_ID)
        return 0;

    Bit_Set(Player_Flags(playerid), PFLAG_ROBBING_STORE, true);
    g_rgeRobbableActors[id][e_iRobbingPlayer] = playerid;

    if((random(100) + 1) % 2)
    {
        ApplyDynamicActorAnimation(actorid, "SHOP", "SHP_ROB_REACT", 4.1, false, false, false, true, 0);
    }
    else
    {
        ApplyDynamicActorAnimation(actorid, "SHOP", "SHP_ROB_HANDSUP", 4.1, false, false, false, true, 0);
    }

    g_rgeRobbableActors[id][e_iRobberyTimer] = SetTimerEx("ROBBERY_Progress", 5000, false, "iii", playerid, actorid, 0);
    return 1;
}