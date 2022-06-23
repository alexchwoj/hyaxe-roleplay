#if defined _clothing_functions_
    #endinput
#endif
#define _clothing_functions_

Clothing_CreateArea(store_type, Float:x, Float:y, Float:z, interior)
{
    new area = CreateDynamicSphere(
        x, y, z, 1.8,
        .worldid = -1, .interiorid = interior
    );
    Streamer_SetIntData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x434c53), store_type);

    Key_Alert(
        x, y, z, 1.2,
        KEYNAME_YES, -1, interior
    );

    CreateDynamic3DTextLabel("{CB3126}Tienda de ropa{DADADA}\nPresiona {CB3126}Y{DADADA} para comprar", 0xDADADAFF, x, y, z, 10.0, .testlos = 1, .worldid = -1, .interiorid = interior);
    return 1;
}

Clothing_Select(playerid, index)
{
    SetPlayerSkin(playerid, g_rgiClothingSkins[ g_rgiPlayerClothingStore[playerid] ][ Player_Sex(playerid) ][index][0]);
    TextDrawSetStringForPlayer(g_tdShops[10], playerid, "$%d", g_rgiClothingSkins[ g_rgiPlayerClothingStore[playerid] ][ Player_Sex(playerid) ][index][1]);
    TextDrawSetStringForPlayer(g_tdShops[11], playerid, "Skin %d", g_rgiClothingSkins[ g_rgiPlayerClothingStore[playerid] ][ Player_Sex(playerid) ][index][0]);
    return 1;
}