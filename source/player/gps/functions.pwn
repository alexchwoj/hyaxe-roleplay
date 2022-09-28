#if defined _gps_functions_
    #endinput
#endif
#define _gps_functions_

Player_ShowGPS(playerid)
{
    Dialog_ShowCallback(playerid, using public _hydg@gps_main<iiiis>, DIALOG_STYLE_LIST, "{CB3126}Hyaxe{DADADA} - GPS", "\
        Trabajos\n\
        Hospitales\n\
        Concesionarios\n\
    ", "Ver", "Cerrar");
    return 1;
}

Player_SetGPSCheckpoint(playerid, Float:x, Float:y, Float:z, world = 0, interior = 0)
{
    if (IsValidDynamicCP(g_rgiGPSCheckpoint[playerid]))
	    DestroyDynamicCP(g_rgiGPSCheckpoint[playerid]);

	g_rgiGPSCheckpoint[playerid] = CreateDynamicCP(x, y, z, 5.0, world, interior, playerid, 9999999999.0);
    return 1;
}