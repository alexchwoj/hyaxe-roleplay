#if defined _stores_functions_
    #endinput
#endif
#define _stores_functions_

static Shop_FindFreeIndex()
{
    for(new i; i < HYAXE_MAX_SHOPS; ++i)
    {
        if(!g_rgeShops[i][e_bShopValid])
            return i;
    }

    return -1;
}

static ShopItem_FindFreeIndex(shop_id)
{
    for(new i; i < HYAXE_MAX_SHOP_ITEMS; ++i)
    {
        if(!g_rgeShopItems[shop_id][i][e_iItemModel])
            return i;
    }

    return -1;
}

Shop_Create(const name[], const Float:position[3], world, interior, const Float:camera_pos[2][3], const Float:object_positions[3][3], buy_callback)
{
    new idx = Shop_FindFreeIndex();
    if(i == -1)
    {
        print("[shops!] Failed to create shop (pool out of space)");
        return -1;
    }

    g_rgeShops[idx][e_bShopValid] = true;
    
    strcpy(g_rgeShops[idx][e_szShopName], name);
    g_rgeShops[idx][e_iShopLabel] = CreateDynamic3DTextLabel(name, 0xCB3126FF, position[0], position[1], position[2], 10.0, .testlos = 1, .worldid = world, .interiorid = interior);
    g_rgeShops[idx][e_iShopArea] = CreateDynamicCircle(position[0], position[1], 0.5, .worldid = world, .interiorid = interior);
    Key_Alert(position[0], position[1], 1.0, KEYNAME_YES, world, interior);

    new info[2] = { 0x73686F70 };
    info[1] = idx;
    Streamer_SetArrayData(STREAMER_TYPE_ARRAY, g_rgeShops[idx][e_iShopArea], E_STREAMER_EXTRA_ID, info);

    g_rgeShops[idx][e_fShopX] = position[0]; 
    g_rgeShops[idx][e_fShopY] = position[1];
    g_rgeShops[idx][e_fShopZ] = position[2];
    g_rgeShops[idx][e_iShopWorld] = world;
    g_rgeShops[idx][e_iShopInterior] = interior;
    g_rgeShops[idx][e_fShopCamX] = camera_pos[0][0];
    g_rgeShops[idx][e_fShopCamY] = camera_pos[0][1];
    g_rgeShops[idx][e_fShopCamZ] = camera_pos[0][2];
    g_rgeShops[idx][e_fShopCamLookX] = camera_pos[1][0];
    g_rgeShops[idx][e_fShopCamLookY] = camera_pos[1][1];
    g_rgeShops[idx][e_fShopCamLookZ] = camera_pos[1][2];
    g_rgeShops[idx][e_iShopCallback] = buy_callback;
    g_rgeShops[idx][e_fShopObjectStartX] = object_positions[0][0];
    g_rgeShops[idx][e_fShopObjectStartY] = object_positions[0][1];
    g_rgeShops[idx][e_fShopObjectStartZ] = object_positions[0][2];
    g_rgeShops[idx][e_fShopObjectIdleX] = object_positions[1][0];
    g_rgeShops[idx][e_fShopObjectIdleY] = object_positions[1][1];
    g_rgeShops[idx][e_fShopObjectIdleZ] = object_positions[1][2];
    g_rgeShops[idx][e_fShopObjectEndX] = object_positions[2][0];
    g_rgeShops[idx][e_fShopObjectEndY] = object_positions[2][1];
    g_rgeShops[idx][e_fShopObjectEndZ] = object_positions[2][2];

    return idx;
}

Shop_AddItem(shop_id, const name[], model, price, const Float:rotations[3])
{
    if(!g_rgeShops[shop_id][e_bShopValid])
        return 0;

    new item_id = ShopItem_FindFreeIndex();
    if(item_id == -1)
    {
        printf("[shops!] Failed to create item for shop %i (pool out of space)", shop_id);
        return -1;
    }

    StrCpy(g_rgeShopItems[shop_id][item_id][e_szItemName], name);
    g_rgeShopItems[shop_id][item_id][e_iItemModel] = model;
    g_rgeShopItems[shop_id][item_id][e_iItemPrice] = price;
    g_rgeShopItems[shop_id][item_id][e_fRotationX] = rx;
    g_rgeShopItems[shop_id][item_id][e_fRotationY] = ry;
    g_rgeShopItems[shop_id][item_id][e_fRotationZ] = rz;

    ++g_rgeShops[shop_id][e_iShopItemAmount];

    return item_id;
}

Player_StopShopping(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_SHOPPING, false);
    Bit_Set(Player_Flags(playerid), PFLAG_CAN_USE_SHOP_BUTTONS, false);

    for(new i = (sizeof(g_tdShops) - 1); i != -1; --i)
    {
        TextDrawHideForPlayer(playerid, g_tdShops[i]);
    }

    CancelSelectTextDraw(playerid);
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, true);

    DestroyPlayerObject(playerid, g_rgiPlayerShopObject[playerid]);
    g_rgiPlayerShopObject[playerid] = INVALID_OBJECT_ID;
    g_rgiPlayerCurrentShopItem{playerid} = 0;
    g_rgiPlayerCurrentShop{playerid} = 0xFF;
    g_rgbPlayerWaitingObjectMove{playerid} = false;

    return 1;
}