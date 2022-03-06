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

Key_Alert(Float:x, Float:y, Float:range, key, bool:on_foot = true, world = 0, interior = 0)
{
    new info[4];
    info[0] = 0x4B4559; // KEY
    info[1] = world; // World
    info[2] = interior; // Interior
    info[3] = key; // Key string

    new area = CreateDynamicCircle(
        x, y, range,
        .worldid = world, .interiorid = interior
    );
    Streamer_SetArrayData(STREAMER_TYPE_AREA, area, E_STREAMER_EXTRA_ID, info);
	
    return area;
}

command cancelkey(playerid, const params[], "")
{
    KEY_HideAlert(playerid);
    return 1;
}