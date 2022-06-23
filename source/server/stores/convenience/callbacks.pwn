#if defined _convenience_callbacks_
    #endinput
#endif
#define _convenience_callbacks_

static Convenience_OnBuy(playerid, shop_id, item_id)
{
    #pragma unused shop_id

    switch(item_id)
    {
        case 0: // Repair kit
        {
            if(Inventory_GetItemAmount(playerid, ITEM_REPAIR_KIT) > 2)
            {
                Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Solo puedes tener 2 kits de reparación");
                return 0;
            }

            Inventory_AddFixedItem(playerid, ITEM_REPAIR_KIT, 1, 0);
            Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un kit de reparación");
        }
        case 1: // Coffee cup
        {
            Inventory_AddFixedItem(playerid, ITEM_COFFEE, 1, 0);
            Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un vaso de café");
        }
    }

    return 1;
}

public OnGameModeInit()
{
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2001.8507, -1761.6123, 13.5391, 359.4877, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 0, 10, -1, 0);

    // Actors
    CreateDynamicActor(229, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 0, .interiorid = 10);
    
    // MapIcons
    CreateDynamicMapIcon(2001.8507, -1761.6123, 13.5391, 17, -1, .worldid = 0, .interiorid = 0);

    new shopid = Shop_Create("24/7", 
        2.1105, -29.0141, 1003.5494, 0, 10,
        // Camera
        1.124887, -28.677103, 1004.111938,
        4.151215, -32.320850, 1002.510559,
        // Objects
        -29.88, 1003.47, 2.4,
        -29.88, 1003.47, 2.4,
        -29.88, 1003.47, 2.4,
        __addressof(Convenience_OnBuy)
    );
    Shop_AddItem(shopid, "Kit de reparación", 19921, 2000, 0.0, 0.0, 0.0);
    Shop_AddItem(shopid, "Vaso de cafe", 19835, 10, 0.0, 0.0, 0.0);

    #if defined SHOP_CONV_OnGameModeInit
        return SHOP_CONV_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit SHOP_CONV_OnGameModeInit
#if defined SHOP_CONV_OnGameModeInit
    forward SHOP_CONV_OnGameModeInit();
#endif
