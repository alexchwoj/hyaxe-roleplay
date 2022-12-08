#if defined _stores_callbacks_
    #endinput
#endif
#define _stores_callbacks_

public OnPlayerDisconnect(playerid, reason)
{
    g_rgiPlayerCurrentShopItem{playerid} = 0;
    g_rgiPlayerCurrentShop{playerid} = 0xFF;
    g_rgiPlayerWaitingObjectMove{playerid} = false;
    if(IsValidPlayerObject(playerid, g_rgiPlayerShopObject[playerid]))
    {
        DestroyPlayerObject(playerid, g_rgiPlayerShopObject[playerid]);
    }
    g_rgiPlayerShopObject[playerid] = INVALID_OBJECT_ID;

    #if defined SHOP_OnPlayerDisconnect
        return SHOP_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect SHOP_OnPlayerDisconnect
#if defined SHOP_OnPlayerDisconnect
    forward SHOP_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerObjectMoved(playerid, objectid)
{
    if(g_rgiPlayerWaitingObjectMove{playerid})
    {
        Bit_Set(Player_Flags(playerid), PFLAG_CAN_USE_SHOP_BUTTONS, true);

        PlayerPlaySound(playerid, 1145);
        if(g_rgiPlayerWaitingObjectMove{playerid} != 0b11)
        {
            DestroyPlayerObject(playerid, g_rgiPlayerShopObject[playerid]);

            new current_shop = g_rgiPlayerCurrentShop{playerid};
            new current_item = g_rgiPlayerCurrentShopItem{playerid};
            g_rgiPlayerShopObject[playerid] = CreatePlayerObject(playerid, g_rgeShopItems[current_shop][current_item][e_iItemModel], g_rgeShops[current_shop][e_fShopObjectStartX], g_rgeShops[current_shop][e_fShopObjectStartY], g_rgeShops[current_shop][e_fShopObjectStartZ], g_rgeShopItems[current_shop][current_item][e_fRotX], g_rgeShopItems[current_shop][current_item][e_fRotY], g_rgeShopItems[current_shop][current_item][e_fRotZ]);
            MovePlayerObject(playerid, g_rgiPlayerShopObject[playerid], g_rgeShops[current_shop][e_fShopObjectIdleX], g_rgeShops[current_shop][e_fShopObjectIdleY], g_rgeShops[current_shop][e_fShopObjectIdleZ], 1.2);

            TextDrawSetStringForPlayer(g_tdShops[10], playerid, "$%d", g_rgeShopItems[current_shop][current_item][e_iItemPrice]);
            TextDrawSetStringForPlayer(g_tdShops[11], playerid, Str_FixEncoding(g_rgeShopItems[current_shop][current_item][e_szItemName]));
        }

        g_rgiPlayerWaitingObjectMove{playerid} = false;

        return 1;
    }

    #if defined SHOP_OnPlayerObjectMoved
        return SHOP_OnPlayerObjectMoved(playerid, objectid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerObjectMoved
    #undef OnPlayerObjectMoved
#else
    #define _ALS_OnPlayerObjectMoved
#endif
#define OnPlayerObjectMoved SHOP_OnPlayerObjectMoved
#if defined SHOP_OnPlayerObjectMoved
    forward SHOP_OnPlayerObjectMoved(playerid, objectid);
#endif

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(Bit_Get(Player_Flags(playerid), PFLAG_SHOPPING) && Bit_Get(Player_Flags(playerid), PFLAG_CAN_USE_SHOP_BUTTONS))
    {
        new shop_id = g_rgiPlayerCurrentShop{playerid};

        // Left button
        if(clickedid == g_tdShops[7])
        {
            if(g_rgiPlayerCurrentShopItem{playerid} <= 0)
                return 1;

            Bit_Set(Player_Flags(playerid), PFLAG_CAN_USE_SHOP_BUTTONS, false);
            g_rgiPlayerWaitingObjectMove{playerid} = true;

            --g_rgiPlayerCurrentShopItem{playerid};
            MovePlayerObject(playerid, g_rgiPlayerShopObject[playerid], g_rgeShops[shop_id][e_fShopObjectEndX], g_rgeShops[shop_id][e_fShopObjectEndY], g_rgeShops[shop_id][e_fShopObjectEndZ], 1.2);
        }
        // Right button
        else if(clickedid == g_tdShops[8])
        {
            if(g_rgiPlayerCurrentShopItem{playerid} + 1 >= g_rgeShops[shop_id][e_iShopItemAmount])
                return 1;
            
            Bit_Set(Player_Flags(playerid), PFLAG_CAN_USE_SHOP_BUTTONS, false);
            g_rgiPlayerWaitingObjectMove{playerid} = true;

            ++g_rgiPlayerCurrentShopItem{playerid};
            MovePlayerObject(playerid, g_rgiPlayerShopObject[playerid], g_rgeShops[shop_id][e_fShopObjectEndX], g_rgeShops[shop_id][e_fShopObjectEndY], g_rgeShops[shop_id][e_fShopObjectEndZ], 1.2);
        }
        // Buy button
        else if(clickedid == g_tdShops[9])
        {
            new 
                item_id = g_rgiPlayerCurrentShopItem{playerid},
                cb_address = g_rgeShops[shop_id][e_iShopCallback],
                ret = 1;

            if (Player_Money(playerid) < g_rgeShopItems[shop_id][item_id][e_iItemPrice])
            {
                PlayerPlaySound(playerid, SOUND_ERROR);
                Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                return 0;
            }

            __emit
            {                       // callback(playerid, shop_id, item_id)
                push.s item_id
                push.s shop_id
                push.s playerid
                push.c 12
                lctrl 6
                add.c 0x24
                lctrl 8
                push.pri
                load.s.pri cb_address
                sctrl 6
                stor.s.pri ret
            }

            if(ret)
            {
                Player_GiveMoney(playerid, -(g_rgeShopItems[shop_id][item_id][e_iItemPrice]), true);
                PlayerPlaySound(playerid, 1054);
            }
            else
            {
                PlayerPlaySound(playerid, 1055);
            }
        }
    }

    #if defined SHOP_OnPlayerClickTextDraw
        return SHOP_OnPlayerClickTextDraw(playerid, Text:clickedid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw SHOP_OnPlayerClickTextDraw
#if defined SHOP_OnPlayerClickTextDraw
    forward SHOP_OnPlayerClickTextDraw(playerid, Text:clickedid);
#endif

public OnPlayerCancelTDSelection(playerid)
{
    if(Bit_Get(Player_Flags(playerid), PFLAG_SHOPPING_CLOTHES))
    {
        SetPlayerVirtualWorld(playerid, g_rgePlayerTempData[playerid][e_iPlayerLastWorld]);
        Player_StopShopping(playerid);
        SetPlayerSkin(playerid, Player_Skin(playerid));
        return 1;
    }

    if(Bit_Get(Player_Flags(playerid), PFLAG_SHOPPING))
    {
        KillTimer(g_rgiRotateSkinTimer[playerid]);
        Player_StopShopping(playerid);
        return 1;
    }

    #if defined SHOP_OnPlayerCancelTDSelection
        return SHOP_OnPlayerCancelTDSelection(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerCancelTDSelection
    #undef OnPlayerCancelTDSelection
#else
    #define _ALS_OnPlayerCancelTDSelection
#endif
#define OnPlayerCancelTDSelection SHOP_OnPlayerCancelTDSelection
#if defined SHOP_OnPlayerCancelTDSelection
    forward SHOP_OnPlayerCancelTDSelection(playerid);
#endif
