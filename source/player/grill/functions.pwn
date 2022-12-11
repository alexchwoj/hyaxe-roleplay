#if defined _grill_functions_
    #endinput
#endif
#define _grill_functions_

Grill_Create(playerid, Float:x, Float:y, Float:z, Float:angle)
{
    Sound_PlayInRange(12200, 10.0, x, y, z, 0, 0);

    new data[eGrillData];
    data[e_iOwnerID] = playerid;
    data[e_i3DLabel] = CreateDynamic3DTextLabel(va_return("{DADADA}Parrilla de {DD6A4D}%s", Player_RPName(playerid)), 0xDADADA00, x, y, z + 0.2, 5.0, .worldid = 0, .interiorid = 0);
    data[e_iBBQObject] = CreateDynamicObject(19831, x, y, z - 1.0, 0.0, 0.0, angle, 0, 0);
    new grill_id = CreateDynamicSphere(
        x, y, z, 2.0,
        .worldid = 0, .interiorid = 0
    );
    Streamer_SetArrayData(STREAMER_TYPE_AREA, grill_id, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q')) , data); // BBQ

    Player_Grill(playerid) = grill_id;

    foreach (new i : PlayerInRange(30.0, x, y, z))
    {
        Streamer_Update(i);
    }

    return grill_id;
}

Grill_Destroy(grill_id)
{
    if (!Streamer_HasArrayData(STREAMER_TYPE_AREA, grill_id, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q'))))
        return 0;

    new data[eGrillData];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, grill_id, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q')), data);

    if (IsValidDynamicObject(data[e_iBBQObject]))
        DestroyDynamicObject(data[e_iBBQObject]);

    if (IsValidDynamicObject(data[e_iContentObject]))
        DestroyDynamicObject(data[e_iContentObject]);

    if (IsValidDynamicObject(data[e_iSmokeObject]))
        DestroyDynamicObject(data[e_iSmokeObject]);

    DestroyDynamic3DTextLabel(data[e_i3DLabel]);
    DestroyDynamicArea(grill_id);

    return 1;
}

Player_GetNearestGrill(playerid)
{
    new areas = GetPlayerNumberDynamicAreas(playerid);
    if (areas)
    {
        YSI_UNSAFE_HUGE_STRING[areas] = INVALID_STREAMER_ID;
        GetPlayerDynamicAreas(playerid, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH);

        for (new i; YSI_UNSAFE_HUGE_STRING[i] != INVALID_STREAMER_ID; ++i)
        {
            new area = YSI_UNSAFE_HUGE_STRING[i];
            if (Streamer_HasArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q'))))
            {
                return area;
            }
        }
    }

    return INVALID_STREAMER_ID;
}

Grill_StartCooking(grill_id)
{
    if (!Streamer_HasArrayData(STREAMER_TYPE_AREA, grill_id, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q'))))
        return 0;

    new data[eGrillData];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, grill_id, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q')), data);

    new Float:x, Float:y, Float:z;
    GetDynamicObjectPos(data[e_iBBQObject], x, y, z);

    data[e_iContentObject] = CreateDynamicObject(2804, x, y, z + 0.9, 0.0, 0.0, 0.0, 0, 0);
    data[e_iSmokeObject] = CreateDynamicObject(18735, x, y, z - 0.3, 0.0, 0.0, 0.0, 0, 0);
    data[e_bCooking] = true;

    Streamer_SetArrayData(STREAMER_TYPE_AREA, grill_id, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q')), data);

    inline const FinishCooking()
	{
        if (!IsValidDynamicArea(grill_id) || !Streamer_HasArrayData(STREAMER_TYPE_AREA, grill_id, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q'))))
            return 1;

        new timer_data[eGrillData];
        Streamer_GetArrayData(STREAMER_TYPE_AREA, grill_id, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q')), timer_data);

        DestroyDynamicObject(timer_data[e_iContentObject]);
        timer_data[e_iContentObject] = INVALID_STREAMER_ID;
        DestroyDynamicObject(timer_data[e_iSmokeObject]);
        timer_data[e_iSmokeObject] = INVALID_STREAMER_ID;
        timer_data[e_bCooking] = false;

        Streamer_SetArrayData(STREAMER_TYPE_AREA, grill_id, E_STREAMER_CUSTOM(MAKE_CELL(0,'B','B','Q')), timer_data);

        DroppedItem_Create(ITEM_HAM, 1, 0, x, y, z + 0.9, 0, 0, .physics = false);
	}
    Timer_CreateCallback(using inline FinishCooking, 15000, 1);
    return 1;
}