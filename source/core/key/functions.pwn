#if defined _KEY_FUNCTIONS_
    #endinput
#endif
#define _KEY_FUNCTIONS_

Key_ShowAll(playerid)
{
    PlayerTextDrawShow(playerid, p_tdKey_BG{playerid});
    PlayerTextDrawShow(playerid, p_tdKey_Text{playerid});
    return 1;
}

Key_Alert(Float:x, Float:y, Float:z, Float:range, key, world = -1, interior = -1, key_type = KEY_TYPE_FOOT, attachedplayer = INVALID_PLAYER_ID)
{
    new info[4];
    info[0] = world; // World
    info[1] = interior; // Interior
    info[2] = key; // Key name
    info[3] = key_type; // Key type (KEY_TYPE_FOOT, KEY_TYPE_VEHICLE)

    new area = CreateDynamicSphere(
        x, y, z, range,
        .worldid = world, .interiorid = interior
    );
    Streamer_SetArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x4B4559), info);
    
    if(attachedplayer != INVALID_PLAYER_ID)
    {
        AttachDynamicAreaToPlayer(area, attachedplayer);
    }

    return area;
}