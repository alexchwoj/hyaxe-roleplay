#if defined _boombox_functions_
    #endinput
#endif
#define _boombox_functions_

Boombox_Create(playerid, Float:x, Float:y, Float:z, Float:distance)
{
    new
        vw = GetPlayerVirtualWorld(playerid),
        interior = GetPlayerInterior(playerid);

    new data[eBoomboxData];
    new area = CreateDynamicSphere(x, y, z, distance, .worldid = vw, .interiorid = interior);
    data[e_iBoomboxOwnerId] = playerid;
    data[e_iBoomboxObjectId] = CreateDynamicObject(2226, x, y, z, 0.0, 0.0, 0.0, vw, interior, .streamdistance = distance + 20.0);
    data[e_iBoomboxLabelId] = CreateDynamic3DTextLabel(va_return("Parlante de {CB3126}%s\n{DADADA}Presiona {CB3126}N{DADADA} para configurarlo", Player_RPName(playerid)), 0xDADADAFF, x, y, z, 10.0, .testlos = 1, .worldid = vw, .interiorid = interior);
    Streamer_SetArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O')), data);

    foreach (new i : PlayerInRange(distance, x, y, z, vw, interior))
    {
        Streamer_Update(i);
    }

    Player_Boombox(playerid) = area;
    return area;
}

Boombox_Destroy(boombox_id)
{
    if (!IsValidDynamicArea(boombox_id) || !Streamer_HasArrayData(STREAMER_TYPE_AREA, boombox_id, E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O'))))
        return 0;

    new data[eBoomboxData];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, boombox_id, E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O')), data);

    foreach (new i : PlayerInArea(boombox_id, true))
    {
        StopAudioStreamForPlayer(i);
    }

    DestroyDynamicObject(data[e_iBoomboxObjectId]);
    DestroyDynamic3DTextLabel(data[e_iBoomboxLabelId]);
    DestroyDynamicArea(boombox_id);
    Player_Boombox(data[e_iBoomboxOwnerId]) = INVALID_STREAMER_ID;
    
    return 1;
}

bool:Boombox_Exists(boombox_id)
{
    return IsValidDynamicArea(boombox_id) && Streamer_HasArrayData(STREAMER_TYPE_AREA, boombox_id, E_STREAMER_CUSTOM(MAKE_CELL('S','T','R','O')));
}