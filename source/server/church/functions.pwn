#if defined _church_functions_
    #endinput
#endif
#define _church_functions_

Mass_Start(invoker)
{
    g_rgbMassStarted = true;
    g_rgeMassState = MASS_STATE_ENTRANCE;
    FCNPC_Spawn(g_rgiPriestNPC, 68, 387.1989, 2324.4072, 1889.5798);
    FCNPC_SetVirtualWorld(g_rgiPriestNPC, 2);
    FCNPC_SetInterior(g_rgiPriestNPC, 17);
    FCNPC_SetAngle(g_rgiPriestNPC, 92.6745);
    FCNPC_StartPlayingPlayback(g_rgiPriestNPC, "mass_walk_in");
}

Mass_End()
{
    FCNPC_StopPlayingPlayback(g_rgiPriestNPC);
    FCNPC_Kill(g_rgiPriestNPC);
    g_rgbMassStarted = false;
    g_rgeMassState = MASS_STATE_NONE;
}