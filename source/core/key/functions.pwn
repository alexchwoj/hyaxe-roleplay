#if defined _KEY_FUNCTIONS_
    #endinput
#endif
#define _KEY_FUNCTIONS_

Key_GetName(key)
{
    new name[16];

    switch(key)
    {
        case KEY_ACTION: name = "TAB";
        case KEY_CROUCH: name = "C";
        case KEY_FIRE: name = "CLICK IZQ.";
        case KEY_SPRINT: name = "ESPACIO";
        case KEY_SECONDARY_ATTACK: name = "ENTER";
        case KEY_JUMP: name = "SHIFT";
        case KEY_LOOK_RIGHT: name = "E";
        case KEY_HANDBRAKE: name = "CLICK DER.";
        case KEY_LOOK_LEFT: name = "Q";
        case KEY_WALK: name = "ALT";
        case KEY_ANALOG_UP: name = "NUM 8";
        case KEY_ANALOG_DOWN: name = "NUM 2";
        case KEY_ANALOG_LEFT: name = "NUM 4";
        case KEY_ANALOG_RIGHT: name = "NUM 6";
        case KEY_YES: name = "Y";
        case KEY_NO: name = "N";
        case KEY_CTRL_BACK: name = "H";
        default: name = "NONE";
    }
    return name;
}

Key_ShowAll(playerid)
{
    PlayerTextDrawShow(playerid, p_tdKey_BG{playerid});
    PlayerTextDrawShow(playerid, p_tdKey_Text{playerid});
    return 1;
}

Key_Alert(Float:x, Float:y, Float:range, key, world = 0, interior = 0)
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