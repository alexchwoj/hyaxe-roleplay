#if defined _hookers_functions_
    #endinput
#endif
#define _hookers_functions_

/*
Hooker_Spawn(hookerid)
{
    g_rgbHookerAvailable{hookerid} = true;
    new npcid = g_rgiHookers[hookerid];

    if (!FCNPC_IsSpawned(npcid))
    {
        new skin = g_rgiHookerSkins[random(sizeof(g_rgiHookerSkins))];
        DEBUG_PRINT("[hookers] Spawning hooker %i with skin %i", hookerid, skin);
        FCNPC_Spawn(npcid, skin, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
    }
    else
    {
        FCNPC_Respawn(npcid);
        FCNPC_SetPosition(npcid, g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
    }

    FCNPC_SetInvulnerable(npcid, true);
    FCNPC_SetAngle(npcid, g_rgfHookerPos[hookerid][3]);
    FCNPC_SetInterior(npcid, 0);
    FCNPC_SetVirtualWorld(npcid, 0);
    FCNPC_SetAnimationByName(npcid, "BAR:BARCUSTOM_LOOP", 4.1, 1, 0, 0, 0, 0);

    return 1;
}
*/

Hooker_FindIdxFromPlayerId(npcid)
{
    for (new i; i < HYAXE_MAX_HOOKERS; ++i)
    {
        if (g_rgiHookers[i] == npcid)
            return i;
    }

    return INVALID_HOOKER_ID;
}

Hooker_WalkToFrontOfPlayer(hookernpcid, playerid, Float:dist = 0.9)
{
    new Float:x, Float:y, Float:z, Float:ang;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, ang);

    new Float:add_x, Float:add_y;
    GetXYFromAngle(add_x, add_y, ang, dist);
    x += add_x;
    y += add_y;

    FCNPC_GoTo(hookernpcid, x, y, z, FCNPC_MOVE_TYPE_WALK);
    return 1;
}

bool:Hooker_CanGetInVehicle(modelid)
{
    return (Model_Seats(modelid) >= 1 && Model_IsCar(modelid));
}
