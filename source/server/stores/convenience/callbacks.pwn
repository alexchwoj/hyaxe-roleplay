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
            if(Inventory_GetItemCount(playerid, ITEM_REPAIR_KIT) >= 2)
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
        case 2: // Phone
        {
            Inventory_AddFixedItem(playerid, ITEM_PHONE, 1, 100000 + random(100000));
            Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un celular");
        }
        case 3: // Grill
        {
            Inventory_AddFixedItem(playerid, ITEM_GRILL, 1, 0);
            Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una parrilla");
        }
        case 4: // Boombox
        {
            Inventory_AddFixedItem(playerid, ITEM_BOOMBOX, 1, 0);
            Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un parlante");
        }
    }

    return 1;
}

player_menu meats_buy(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_SELECT)
    {
        switch(listitem)
        {
            case 0:
            {
                if (150 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -150);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un kilo de carne");
                Inventory_AddFixedItem(playerid, ITEM_MEAT, 1, 0);
            }
        }
    }
    return 1;
}

player_menu milk_buy(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_SELECT)
    {
        switch(listitem)
        {
            case 0:
            {
                if (100 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -100);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una caja de leche");
                Inventory_AddFixedItem(playerid, ITEM_MILK, 1, 0);
            }
        }
    }
    return 1;
}

player_menu icecream_buy(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_SELECT)
    {
        switch(listitem)
        {
            case 0:
            {
                if (100 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -100);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un helado de chocolate");
                Inventory_AddFixedItem(playerid, ITEM_CHOCOLATE_ICE_CREAM, 1, 0);
            }

            case 1:
            {
                if (100 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -100);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un helado de frutilla");
                Inventory_AddFixedItem(playerid, ITEM_STRAWBERRY_ICE_CREAM, 1, 0);
            }
        }
    }
    return 1;
}

player_menu beverages_buy(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_SELECT)
    {
        switch(listitem)
        {
            case 0:
            {
                if (100 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -100);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un jugo de naranja");
                Inventory_AddFixedItem(playerid, ITEM_ORANGE_JUICE, 1, 0);
            }

            case 1:
            {
                if (100 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -100);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un jugo de manzana");
                Inventory_AddFixedItem(playerid, ITEM_APPLE_JUICE, 1, 0);
            }

            case 2:
            {
                if (200 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -200);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una cerveza");
                Inventory_AddFixedItem(playerid, ITEM_BEER, 1, 0);
            }

            case 3:
            {
                if (200 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -200);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un wisky");
                Inventory_AddFixedItem(playerid, ITEM_WISKY, 1, 0);
            }

            case 4:
            {
                if (200 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -200);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un champagne");
                Inventory_AddFixedItem(playerid, ITEM_CHAMPAGNE, 1, 0);
            }

            case 5:
            {
                if (200 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -200);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una cerveza artesanal");
                Inventory_AddFixedItem(playerid, ITEM_CRAFT_BEER, 1, 0);
            }
        }
    }
    return 1;
}

static Meats_OnPress(playerid)
{
    Menu_Show(playerid, "meats_buy", "Comprar");
    Menu_AddItem(playerid, "Un kilo de carne", "Precio: ~g~$150");
    Menu_UpdateListitems(playerid);
    return 1;
}

static Milk_OnPress(playerid)
{
    Menu_Show(playerid, "milk_buy", "Comprar");
    Menu_AddItem(playerid, "Leche", "Precio: ~g~$100");
    Menu_UpdateListitems(playerid);
    return 1;
}

static IceCream_OnPress(playerid)
{
    Menu_Show(playerid, "icecream_buy", "Comprar");
    Menu_AddItem(playerid, "Helado de chocolate", "Precio: ~g~$100");
    Menu_AddItem(playerid, "Helado de frutilla", "Precio: ~g~$100");
    Menu_UpdateListitems(playerid);
    return 1;
}

static Beverages_OnPress(playerid)
{
    Menu_Show(playerid, "beverages_buy", "Comprar");
    Menu_AddItem(playerid, "Jugo de naranja", "Precio: ~g~$100");
    Menu_AddItem(playerid, "Jugo de manzana", "Precio: ~g~$100");
    Menu_AddItem(playerid, "Cerveza", "Precio: ~g~$200");
    Menu_AddItem(playerid, "Wisky", "Precio: ~g~$200");
    Menu_AddItem(playerid, "Champagne", "Precio: ~g~$200");
    Menu_AddItem(playerid, "Cerveza artesanal", "Precio: ~g~$200");
    Menu_UpdateListitems(playerid);
    return 1;
}

public OnScriptInit()
{
    CreateDynamic3DTextLabel("{ED2B2B}Carnes\n{DADADA}1 producto disponible", 0xFFFFFFFF, 0.9752, -25.8198, 1003.5494, 10.0, .worldid = -1, .interiorid = 10);
    Key_Alert(
        0.9752, -25.8198, 1003.5494, 1.2,
        KEYNAME_YES, -1, 10,
        .callback_on_press = __addressof(Meats_OnPress)
    );

    CreateDynamic3DTextLabel("{ED2B2B}Leche\n{DADADA}1 producto disponible", 0xFFFFFFFF, 8.3222, -27.3006, 1003.5494, 10.0, .worldid = -1, .interiorid = 10);
    Key_Alert(
        8.3222, -27.3006, 1003.5494, 1.2,
        KEYNAME_YES, -1, 10,
        .callback_on_press = __addressof(Milk_OnPress)
    );

    CreateDynamic3DTextLabel("{ED2B2B}Helados\n{DADADA}2 productos disponible", 0xFFFFFFFF, 4.9930, -21.8446, 1003.5494, 10.0, .worldid = -1, .interiorid = 10);
    Key_Alert(
        4.9930, -21.8446, 1003.5494, 1.2,
        KEYNAME_YES, -1, 10,
        .callback_on_press = __addressof(IceCream_OnPress)
    );

    CreateDynamic3DTextLabel("{ED2B2B}Bebidas\n{DADADA}6 productos disponible", 0xFFFFFFFF, 2.6388, -26.2849, 1003.5494, 10.0, .worldid = -1, .interiorid = 10);
    Key_Alert(
        2.6388, -26.2849, 1003.5494, 1.2,
        KEYNAME_YES, -1, 10,
        .callback_on_press = __addressof(Beverages_OnPress)
    );

    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2001.8507, -1761.6123, 13.5391, 359.4877, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 0, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 1352.314941, -1758.961425, 13.507812, 0.0, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 1, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 1833.540771, -1842.542724, 13.578125, 90.0, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 2, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 1315.453247, -897.967102, 39.578125, 180.0, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 3, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 1000.317199, -919.933349, 42.328125, 105.0, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 4, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2117.6494, 897.1806, 11.1797, 12.1038, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 5, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2637.5356, 1129.2190, 11.1797, 182.5185, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 6, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2546.6067, 1972.2355, 10.8203, 180.0468, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 7, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2452.4578, 2064.7595, 10.8203, 181.0483, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 8, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2194.5137, 1991.1290, 12.2969, 91.8167, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 9, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2097.4353, 2224.2637, 11.0234, 180.5131, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 10, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 1937.4686, 2307.2776, 10.8203, 92.3837, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 11, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2188.1104, 2469.9355, 11.2422, 272.2827, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 12, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2150.9756, 2734.2964, 11.1763, 3.1420, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 13, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 2884.8887, 2453.7634, 11.0690, 224.2287, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 14, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", -1676.0208, 432.0192, 7.1797, 223.0368, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 15, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", -2419.8621, 969.9724, 45.2969, 271.3646, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 16, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", -2442.8604, 755.0207, 35.1719, 179.8825, 0, 0, 6.0728,-31.3407, 1003.5494, 6.2127, 17, 10, -1, 0);
    EnterExit_Create(19902, "{ED2B2B}24/7", "{DADADA}Salida", 1582.2601, -1170.5659, 24.0781, 357.4225, 0, 0, 6.0728, -31.3407, 1003.5494, 6.2127, 18, 10, -1, 0);

    // Actors
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 0, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 1, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 2, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 3, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 4, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 5, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 6, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 7, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 8, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 9, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 10, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 11, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 12, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 13, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 14, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 15, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 16, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 17, .interiorid = 10);
    Actor_CreateRobbable(229, 500, 1000, 2.0491, -30.7007, 1004.5494, 358.3559, .worldid = 18, .interiorid = 10);
    
    // MapIcons
    CreateDynamicMapIcon(2001.8507, -1761.6123, 13.5391, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2001.8507, -1761.6123, 13.5391, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(352.314941, -1758.961425, 13.507812, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(1833.540771, -1842.542724, 13.578125, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(1315.453247, -897.967102, 39.578125, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(1000.317199, -919.933349, 42.328125, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2117.6494, 897.1806, 11.1797, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2637.5356, 1129.2190, 11.1797, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2546.6067, 1972.2355, 10.8203, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2452.4578, 2064.7595, 10.8203, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2194.5137, 1991.1290, 12.2969, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2097.4353, 2224.2637, 11.0234, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(1937.4686, 2307.2776, 10.8203, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2188.1104, 2469.9355, 11.2422, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2150.9756, 2734.2964, 11.1763, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2884.8887, 2453.7634, 11.0690, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(-1676.0208, 432.0192, 7.1797, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(-2419.8621, 969.9724, 45.2969, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(-2442.8604, 755.0207, 35.1719, 17, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(1582.2601, -1170.5659, 24.0781, 17, -1, .worldid = 0, .interiorid = 0);

    new shopid = Shop_Create("24/7", 
        2.1105, -29.0141, 1003.5494, -1, 10,
        // Camera
        1.124887, -28.677103, 1004.111938,
        4.151215, -32.320850, 1002.510559,
        // Objects
        2.9500, -29.7900, 1003.55,
        2.1000, -29.7900, 1003.55,
        1.2500, -29.7900, 1003.55,
        __addressof(Convenience_OnBuy)
    );
    Shop_AddItem(shopid, "Kit de reparación", 19921, 2000, 0.0, 0.0, 0.0);
    Shop_AddItem(shopid, "Vaso de cafe", 19835, 10, 0.0, 0.0, 0.0);
    Shop_AddItem(shopid, "Celular", 18866, 1500, 0.0, 0.0, 0.0);
    Shop_AddItem(shopid, "Parrilla", 19831, 1500, 0.0, 0.0, 0.0);
    //Shop_AddItem(shopid, "Parlante", 2226, 3000, 0.0, 0.0, 0.0);

    #if defined SHOP_CONV_OnScriptInit
        return SHOP_CONV_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit SHOP_CONV_OnScriptInit
#if defined SHOP_CONV_OnScriptInit
    forward SHOP_CONV_OnScriptInit();
#endif
