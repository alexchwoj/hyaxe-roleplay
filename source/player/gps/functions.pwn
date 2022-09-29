#if defined _gps_functions_
    #endinput
#endif
#define _gps_functions_

Player_ShowGPS(playerid)
{
    Phone_Show(playerid, "gps_main");
	Phone_AddItem(playerid, "Trabajos");
	Phone_AddItem(playerid, "Hospitales");
	Phone_AddItem(playerid, "Concesionarios");
    return 1;
}

Player_SetGPSCheckpoint(playerid, Float:x, Float:y, Float:z, world = 0, interior = 0)
{
    if (IsValidDynamicCP(g_rgiGPSCheckpoint[playerid]))
	    DestroyDynamicCP(g_rgiGPSCheckpoint[playerid]);

	g_rgiGPSCheckpoint[playerid] = CreateDynamicCP(x, y, z, 5.0, world, interior, playerid, 9999999999.0);
    Phone_Hide(playerid);
    return 1;
}