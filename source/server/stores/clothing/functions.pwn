#if defined _clothing_functions_
    #endinput
#endif
#define _clothing_functions_

static Clothing_OnPress(playerid, store_type)
{
    KillTimer(g_rgiRotateSkinTimer[playerid]);

    Bit_Set(Player_Flags(playerid), PFLAG_SHOPPING, true);
    Bit_Set(Player_Flags(playerid), PFLAG_SHOPPING_CLOTHES, true);
    TogglePlayerControllable(playerid, false);

    g_rgePlayerTempData[playerid][e_iPlayerLastWorld] = GetPlayerVirtualWorld(playerid);
    SetPlayerVirtualWorld(playerid, MAX_PLAYERS + playerid);

    g_rgiPlayerClothingStore[playerid] = store_type;

    new Float:x, Float:y, Float:z, Float:angle;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);
    GetXYFromAngle(x, y, angle, 2.0);

    s_rgfPreviousPositions[playerid][0] = x;
    s_rgfPreviousPositions[playerid][1] = y;
    s_rgfPreviousPositions[playerid][2] = z;

    InterpolateCameraPos(playerid, x, y, z + 1.0, x, y, z + 1.0, 1000);
    GetPlayerPos(playerid, x, y, z);
    InterpolateCameraLookAt(playerid, x, y, z + 0.5, x, y, z, 1000);

    g_rgiRotateSkinTimer[playerid] = SetTimerEx("CLOTH_RotatePlayerSkin", 75, true, "if", playerid, 5.0);

    for(new j = (sizeof(g_tdShops) - 1); j != -1; --j)
    {
        TextDrawShowForPlayer(playerid, g_tdShops[j]);
    }

    TextDrawSetStringForPlayer(g_tdShops[5], playerid, "Comprar ropa");

    SelectTextDraw(playerid, 0xD2B567FF);
    PlayerPlaySound(playerid, 1145);

    g_rgiPlayerSelectedSkin[playerid] = 0;
    Clothing_Select(playerid, 0);
    
    return 1;
}

Clothing_CreateArea(store_type, Float:x, Float:y, Float:z, interior)
{
    new area = CreateDynamicSphere(
        x, y, z, 1.8,
        .worldid = -1, .interiorid = interior
    );
    Streamer_SetIntData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x434c53), store_type);

    Key_Alert(
        x, y, z, 1.2,
        KEYNAME_YES, -1, interior,
        .callback_on_press = __addressof(Clothing_OnPress), .cb_data = store_type
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

Cosmetics_ShowShop(playerid)
{
    SetPlayerTime(playerid, 12, 0);

    Menu_Show(playerid, "cosmetics_shop", "Cosméticos");
    Menu_AddItem(playerid, "Sombreros");
    Menu_AddItem(playerid, "Gafas");
    Menu_AddItem(playerid, "Relojes");
    Menu_AddItem(playerid, "Máscaras");
    Menu_UpdateListitems(playerid);

    Streamer_SetIntData(STREAMER_TYPE_OBJECT, Player_StoreCosmeticObject(playerid), E_STREAMER_MODEL_ID, 19482);
    Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

    InterpolateCameraPos(playerid, 1289.789672, 1564.599121, 12.737116, 1289.789672, 1564.599121 - 1.0, 12.737116 + 1.0, 1000);
    InterpolateCameraLookAt(playerid, 1289.737304, 1569.565063, 12.156714, 1289.737304, 1569.565063, 12.156714, 1000);
    return 1;
}