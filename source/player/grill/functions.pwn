#if defined _grill_functions_
    #endinput
#endif
#define _grill_functions_

Grill_FreeSlot()
{
    for(new i; i < HYAXE_MAX_GRILLS; ++i)
	{
		if (!g_rgeGrills[i][e_bValid])
		    return i;
	}
    return HYAXE_MAX_GRILLS + 1;
}

Grill_Create(playerid, Float:x, Float:y, Float:z, Float:angle)
{
    new grill_id = Grill_FreeSlot();
    if (grill_id < HYAXE_MAX_GRILLS)
    {
        Sound_PlayInRange(12200, 10.0, x, y, z, 0, 0);

        g_rgeGrills[ grill_id ][e_bValid] = true;
        g_rgeGrills[ grill_id ][e_iOwnerID] = playerid;
        g_rgeGrills[ grill_id ][e_i3DLabel] = CreateDynamic3DTextLabel(va_return("{DADADA}Parrilla de {DD6A4D}%s", Player_RPName(playerid)), 0xDADADA00, x, y, z + 0.2, 5.0, .worldid = 0, .interiorid = 0);
        g_rgeGrills[ grill_id ][e_iBBQObject] = CreateDynamicObject(19831, x, y, z - 1.0, 0.0, 0.0, angle, 0, 0);

        g_rgeGrills[ grill_id ][e_iArea] = CreateDynamicSphere(
            x, y, z, 2.0,
            .worldid = 0, .interiorid = 0
        );
        Streamer_SetIntData(STREAMER_TYPE_AREA, g_rgeGrills[ grill_id ][e_iArea], E_STREAMER_CUSTOM(0x424251), grill_id); // BBQ

        Player_Grill(playerid) = grill_id;
        Streamer_Update(playerid);
        return grill_id;
    }
    return HYAXE_MAX_GRILLS + 1;
}

Grill_Destroy(grill_id)
{
    g_rgeGrills[ grill_id ][e_bValid] = false;
    DestroyDynamicObject( g_rgeGrills[ grill_id ][e_iBBQObject] );
    DestroyDynamicObject( g_rgeGrills[ grill_id ][e_iContentObject] );
    DestroyDynamicObject( g_rgeGrills[ grill_id ][e_iSmokeObject] );

    DestroyDynamic3DTextLabel( g_rgeGrills[ grill_id ][e_i3DLabel] );
    DestroyDynamicArea( g_rgeGrills[ grill_id ][e_iArea] );

    g_rgeGrills[ grill_id ][e_bCooking] = false;
    g_rgeGrills[ grill_id ][e_iOwnerID] = INVALID_PLAYER_ID;
    return 1;
}

Player_GetNearestGrill(playerid)
{
    new areas = GetPlayerNumberDynamicAreas(playerid);
    if(areas)
    {
        YSI_UNSAFE_HUGE_STRING[areas] = INVALID_STREAMER_ID;
        GetPlayerDynamicAreas(playerid, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH);

        for(new i; YSI_UNSAFE_HUGE_STRING[i] != INVALID_STREAMER_ID; ++i)
        {
            new area = YSI_UNSAFE_HUGE_STRING[i];
            if(Streamer_HasIntData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x424251)))
            {
                return Streamer_GetIntData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x424251));
            }
        }
    }
    return HYAXE_MAX_GRILLS + 1;
}

Grill_StartCooking(grill_id)
{
    new Float:x, Float:y, Float:z;
    GetDynamicObjectPos(g_rgeGrills[ grill_id ][e_iBBQObject], x, y, z);

    g_rgeGrills[ grill_id ][e_iContentObject] = CreateDynamicObject(2804, x, y, z + 0.9, 0.0, 0.0, 0.0, 0, 0);
    g_rgeGrills[ grill_id ][e_iSmokeObject] = CreateDynamicObject(18735, x, y, z - 0.3, 0.0, 0.0, 0.0, 0, 0);

    g_rgeGrills[ grill_id ][e_bCooking] = true;

    new remaining_seconds = 15;
    inline FinishCooking()
	{
        --remaining_seconds;

        if (!remaining_seconds)
        {
            DestroyDynamicObject( g_rgeGrills[ grill_id ][e_iContentObject] );
            DestroyDynamicObject( g_rgeGrills[ grill_id ][e_iSmokeObject] );

            DroppedItem_Create(ITEM_HAM, 1, 0, x, y, z + 0.9, 0, 0, .physics = false);
        }
	}
    Timer_CreateCallback(using inline FinishCooking, 1000, 15);
    return 1;
}