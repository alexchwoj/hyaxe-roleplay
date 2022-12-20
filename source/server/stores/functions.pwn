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

static Shop_OnPress(playerid, shop_id)
{
    Bit_Set(Player_Flags(playerid), PFLAG_SHOPPING, true);
    Bit_Set(Player_Flags(playerid), PFLAG_CAN_USE_SHOP_BUTTONS, false);
    TogglePlayerControllable(playerid, false);

    SetExclusiveBroadcast(true);
    BroadcastToPlayer(playerid, true);

    TextDrawSetString(g_tdShops[5], Str_FixEncoding(g_rgeShops[shop_id][e_szShopName]));
    TextDrawSetString(g_tdShops[10], va_return("$%d", g_rgeShopItems[shop_id][0][e_iItemPrice]));
    TextDrawSetString(g_tdShops[11], Str_FixEncoding(g_rgeShopItems[shop_id][0][e_szItemName]));

    BroadcastToPlayer(playerid, false);
    SetExclusiveBroadcast(false);

    for(new j = (sizeof(g_tdShops) - 1); j != -1; --j)
    {
        TextDrawShowForPlayer(playerid, g_tdShops[j]);
    }
    
    /*new Float:cam_x, Float:cam_y, Float:cam_z, Float:cvec_x, Float:cvec_y, Float:cvec_z;
    GetPlayerCameraPos(playerid, cam_x, cam_y, cam_z);
    GetPlayerCameraFrontVector(playerid, cvec_x, cvec_y, cvec_z);
    InterpolateCameraPos(playerid, cam_x, cam_y, cam_z, g_rgeShops[shop_id][e_fShopCamX], g_rgeShops[shop_id][e_fShopCamY], g_rgeShops[shop_id][e_fShopCamZ], 1000);
    InterpolateCameraLookAt(playerid, cvec_x, cvec_y, cvec_z, g_rgeShops[shop_id][e_fShopCamLookX], g_rgeShops[shop_id][e_fShopCamLookY], g_rgeShops[shop_id][e_fShopCamLookZ], 1000);*/
    InterpolateCameraPos(playerid, g_rgeShops[shop_id][e_fShopCamX], g_rgeShops[shop_id][e_fShopCamY], g_rgeShops[shop_id][e_fShopCamZ], g_rgeShops[shop_id][e_fShopCamX], g_rgeShops[shop_id][e_fShopCamY], g_rgeShops[shop_id][e_fShopCamZ], 1000);
    InterpolateCameraLookAt(playerid, g_rgeShops[shop_id][e_fShopCamLookX], g_rgeShops[shop_id][e_fShopCamLookY], g_rgeShops[shop_id][e_fShopCamLookZ] - 1.5, g_rgeShops[shop_id][e_fShopCamLookX], g_rgeShops[shop_id][e_fShopCamLookY], g_rgeShops[shop_id][e_fShopCamLookZ], 1000);

    SelectTextDraw(playerid, 0xD2B567FF);

    PlayerPlaySound(playerid, 1145);
    g_rgiPlayerCurrentShop{playerid} = shop_id;
    g_rgiPlayerCurrentShopItem{playerid} = 0;
    g_rgiPlayerWaitingObjectMove{playerid} = 0b11;
    g_rgiPlayerShopObject[playerid] = CreatePlayerObject(playerid, g_rgeShopItems[shop_id][0][e_iItemModel], g_rgeShops[shop_id][e_fShopObjectStartX], g_rgeShops[shop_id][e_fShopObjectStartY], g_rgeShops[shop_id][e_fShopObjectStartZ], g_rgeShopItems[shop_id][0][e_fRotX], g_rgeShopItems[shop_id][0][e_fRotY], g_rgeShopItems[shop_id][0][e_fRotZ]);
    MovePlayerObject(playerid, g_rgiPlayerShopObject[playerid], g_rgeShops[shop_id][e_fShopObjectIdleX], g_rgeShops[shop_id][e_fShopObjectIdleY], g_rgeShops[shop_id][e_fShopObjectIdleZ], 1.2);

    return 1;
}

Shop_Create(const name[], Float:pos_x, Float:pos_y, Float:pos_z, world, interior, Float:cam_x, Float:cam_y, Float:cam_z, Float:cam_look_x, Float:cam_look_y, Float:cam_look_z, Float:object_start_x, Float:object_start_y, Float:object_start_z, Float:object_idle_x, Float:object_idle_y, Float:object_idle_z, Float:object_end_x, Float:object_end_y, Float:object_end_z, buy_callback)
{
    new idx = Shop_FindFreeIndex();
    if(idx == -1)
    {
        print("[shops!] Failed to create shop (pool out of space)");
        return -1;
    }

    g_rgeShops[idx][e_bShopValid] = true;
    
    strcpy(g_rgeShops[idx][e_szShopName], name);
    g_rgeShops[idx][e_iShopLabel] = CreateDynamic3DTextLabel(name, 0xCB3126FF, pos_x, pos_y, pos_z, 10.0, .testlos = 1, .worldid = world, .interiorid = interior);
    g_rgeShops[idx][e_iShopArea] = CreateDynamicCircle(pos_x, pos_y, 0.5, .worldid = world, .interiorid = interior);
    Key_Alert(pos_x, pos_y, pos_z, 1.0, KEYNAME_YES, world, interior, .callback_on_press = __addressof(Shop_OnPress), .cb_data = idx);

    g_rgeShops[idx][e_fShopX] = pos_x; 
    g_rgeShops[idx][e_fShopY] = pos_y;
    g_rgeShops[idx][e_fShopZ] = pos_z;
    g_rgeShops[idx][e_iShopWorld] = world;
    g_rgeShops[idx][e_iShopInterior] = interior;
    g_rgeShops[idx][e_fShopCamX] = cam_x;
    g_rgeShops[idx][e_fShopCamY] = cam_y;
    g_rgeShops[idx][e_fShopCamZ] = cam_z;
    g_rgeShops[idx][e_fShopCamLookX] = cam_look_x;
    g_rgeShops[idx][e_fShopCamLookY] = cam_look_y;
    g_rgeShops[idx][e_fShopCamLookZ] = cam_look_z;
    g_rgeShops[idx][e_iShopCallback] = buy_callback;
    g_rgeShops[idx][e_fShopObjectStartX] = object_start_x;
    g_rgeShops[idx][e_fShopObjectStartY] = object_start_y;
    g_rgeShops[idx][e_fShopObjectStartZ] = object_start_z;
    g_rgeShops[idx][e_fShopObjectIdleX] = object_idle_x;
    g_rgeShops[idx][e_fShopObjectIdleY] = object_idle_y;
    g_rgeShops[idx][e_fShopObjectIdleZ] = object_idle_z;
    g_rgeShops[idx][e_fShopObjectEndX] = object_end_x;
    g_rgeShops[idx][e_fShopObjectEndY] = object_end_y;
    g_rgeShops[idx][e_fShopObjectEndZ] = object_end_z;

    return idx;
}

Shop_AddItem(shop_id, const name[], model, price, Float:rx, Float:ry, Float:rz)
{
    if(!g_rgeShops[shop_id][e_bShopValid])
        return 0;

    new item_id = ShopItem_FindFreeIndex(shop_id);
    if(item_id == -1)
    {
        printf("[shops!] Failed to create item for shop %i (pool out of space)", shop_id);
        return -1;
    }

    strcpy(g_rgeShopItems[shop_id][item_id][e_szItemName], name);
    g_rgeShopItems[shop_id][item_id][e_iItemModel] = model;
    g_rgeShopItems[shop_id][item_id][e_iItemPrice] = price;
    g_rgeShopItems[shop_id][item_id][e_fRotX] = rx;
    g_rgeShopItems[shop_id][item_id][e_fRotY] = ry;
    g_rgeShopItems[shop_id][item_id][e_fRotZ] = rz;

    ++g_rgeShops[shop_id][e_iShopItemAmount];

    return item_id;
}

Player_StopShopping(playerid)
{
    KillTimer(g_rgiRotateSkinTimer[playerid]);

    if(Bit_Get(Player_Flags(playerid), PFLAG_SHOPPING_CLOTHES))
    {
        Player_SetPos(playerid, s_rgfPreviousPositions[playerid][0], s_rgfPreviousPositions[playerid][1], s_rgfPreviousPositions[playerid][2]);
        DestroyDynamicObject(Player_StoreCosmeticObject(playerid));
    }

    Bit_Set(Player_Flags(playerid), PFLAG_SHOPPING, false);
    Bit_Set(Player_Flags(playerid), PFLAG_SHOPPING_CLOTHES, false);
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
    g_rgiPlayerWaitingObjectMove{playerid} = false;

    Player_SyncTime(playerid);
    return 1;
}