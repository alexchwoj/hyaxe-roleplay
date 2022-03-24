#if defined _hookers_functions_
    #endinput
#endif
#define _hookers_functions_

Hooker_Spawn(hookerid)
{
    g_rgbHookerAvailable{hookerid} = true;
    
    FCNPC_Spawn(g_rgiHookers[hookerid], g_rgiHookerSkins[random(sizeof(g_rgiHookerSkins))], g_rgfHookerPos[hookerid][0], g_rgfHookerPos[hookerid][1], g_rgfHookerPos[hookerid][2]);
    FCNPC_SetAngle(g_rgiHookers[hookerid], g_rgfHookerPos[hookerid][3]);
    FCNPC_SetInterior(g_rgiHookers[hookerid], 0);
    FCNPC_SetVirtualWorld(g_rgiHookers[hookerid], 0);

    return 1;
}