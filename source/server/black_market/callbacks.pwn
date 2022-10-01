#if defined _black_market_callbacks_
    #endinput
#endif
#define _black_market_callbacks_

static PistolShop_OnBuy(playerid, shop_id, item_id)
{
    switch(item_id)
    {
        case 0: Player_GiveWeapon(playerid, 22);
        case 1: Player_GiveWeapon(playerid, 23);
        case 2: Player_GiveWeapon(playerid, 24);
    }

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Compraste un(a) %s a ~g~$%d", g_rgeShopItems[shop_id][item_id][e_szItemName], g_rgeShopItems[shop_id][item_id][e_iItemPrice]);
    Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 4000, 0x64A752FF);
    return 1;
}

static ShotgunShop_OnBuy(playerid, shop_id, item_id)
{
    switch(item_id)
    {
        case 0: Player_GiveWeapon(playerid, 25);
        case 1: Player_GiveWeapon(playerid, 26);
        case 2: Player_GiveWeapon(playerid, 27);
    }

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Compraste un(a) %s a ~g~$%d", g_rgeShopItems[shop_id][item_id][e_szItemName], g_rgeShopItems[shop_id][item_id][e_iItemPrice]);
    Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 4000, 0x64A752FF);
    return 1;
}

static SubmachineShop_OnBuy(playerid, shop_id, item_id)
{
    switch(item_id)
    {
        case 0: Player_GiveWeapon(playerid, 28);
        case 1: Player_GiveWeapon(playerid, 29);
        case 2: Player_GiveWeapon(playerid, 32);
    }

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Compraste un(a) %s a ~g~$%d", g_rgeShopItems[shop_id][item_id][e_szItemName], g_rgeShopItems[shop_id][item_id][e_iItemPrice]);
    Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 4000, 0x64A752FF);
    return 1;
}

static RifleShop_OnBuy(playerid, shop_id, item_id)
{
    switch(item_id)
    {
        case 0: Player_GiveWeapon(playerid, 30);
        case 1: Player_GiveWeapon(playerid, 31);
        case 2: Player_GiveWeapon(playerid, 33);
    }

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Compraste un(a) %s a ~g~$%d", g_rgeShopItems[shop_id][item_id][e_szItemName], g_rgeShopItems[shop_id][item_id][e_iItemPrice]);
    Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 4000, 0x64A752FF);
    return 1;
}

static MiscShop_OnEnter(playerid)
{
    Dialog_ShowCallback(playerid, using public _hydg@misc_shop<iiiis>, DIALOG_STYLE_TABLIST_HEADERS, "{CB3126}Varios", "{F7F7F7}Productor\t{F7F7F7}Precio\nBandera para conquistar\t{64A752}$100\nBote de spray\t{64A752}$150\n", !"Comprar", !"Cerrar");
    PlayerPlaySound(playerid, SOUND_BUTTON);
    return 1;
}

dialog misc_shop(playerid, dialogid, response, listitem, const inputtext[])
{
    if (response)
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

                if (Inventory_AddItem(playerid, ITEM_FLAG, 1, 0))
                {
                    Player_GiveMoney(playerid, -100);
                    PlayerPlaySound(playerid, SOUND_SUCCESS);
                    Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una bandera para conquistar.");
                }
                else
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Tienes el inventario lleno.");
                    return 1;
                }
            }
            case 1:
            {
                if (150 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveWeapon(playerid, 41);

                Player_GiveMoney(playerid, -150);
                PlayerPlaySound(playerid, SOUND_SUCCESS);

                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un bote de pintura.");
            }

        }
    }
    return 1;
}

public OnScriptInit()
{
    CreateDynamicMapIcon(2453.5684, -1971.7292, 13.5469, 18, -1, .worldid = 0, .interiorid = 0);

    // Misc shop
    CreateDynamicActor(202, 2440.5835, -1975.5815, 13.5469, 266.2618, .worldid = 0, .interiorid = 0);
    CreateDynamic3DTextLabel("Varios", 0xCB3126FF, 2440.5835, -1975.5815, 13.5469, 10.0, .testlos = 1, .worldid = 0, .interiorid = 0);
    Key_Alert(2440.5835, -1975.5815, 13.5469, 1.5, KEYNAME_YES, 0, 0, .callback_on_press = __addressof(MiscShop_OnEnter));

    // Pistol shop
    CreateDynamicActor(73, 2447.4807, -1980.9473, 13.5469, 0.2792, .worldid = 0, .interiorid = 0);

    new pistol_shop = Shop_Create("Comprar pistolas", 2447.4788, -1978.4786, 13.5469, 0, 0, 
        2447.466796, -1978.812622, 14.167802, // Cam pos
        2447.482177, -1983.038085, 11.494686, // Cam look
        2446.174560, -1979.767089, 13.320656, // Start
        2447.413330, -1979.805541, 13.326949, // Idle
        2448.734619, -1979.768676, 13.334807, // End
        __addressof(PistolShop_OnBuy)
    );
    Shop_AddItem(pistol_shop, "9mm", 346, 600, 90.899719, 0.000000, -20.800004);
    Shop_AddItem(pistol_shop, "Silenced 9mm", 347, 700, 90.899719, 0.000000, -20.800004);
    Shop_AddItem(pistol_shop, "Desert Eagle", 348, 2500, 90.899719, 0.000000, -20.800004);

    // Shotgun shop
    CreateDynamicActor(121, 2440.9241, -1964.0116, 13.5469, 272.5686, .worldid = 0, .interiorid = 0);
    new shotgun_shop = Shop_Create("Comprar escopetas", 2443.5037, -1963.9403, 13.5469, 0, 0, 
        2443.061279, -1963.960327, 14.375052, // Cam pos
        2439.204589, -1963.958129, 11.192975, // Cam look
        2442.017822, -1962.506713, 13.300580, // Start
        2442.224121, -1963.785400, 13.431170, // Idle
        2442.319580, -1964.942749, 13.550785, // End
        __addressof(ShotgunShop_OnBuy)
    );
    Shop_AddItem(shotgun_shop, "Shotgun", 349, 900, 96.000076, 75.499954, 173.299972);
    Shop_AddItem(shotgun_shop, "Sawnoff Shotgun", 350, 800, 96.000076, 75.499954, 173.299972);
    Shop_AddItem(shotgun_shop, "Combat Shotgun", 351, 6000, 96.000076, 75.499954, 173.299972);

    // Submachine shop
    CreateDynamicActor(122, 2451.5879, -1963.2706, 13.5539, 184.8346, .worldid = 0, .interiorid = 0);
    new submachine_shop = Shop_Create("Comprar metralletas", 2451.8999, -1965.7794, 13.5539, 0, 0, 
        2451.927246, -1965.705200, 14.296304, // Cam pos
        2451.856445, -1961.570312, 11.486007, // Cam look
        2453.073486, -1964.491821, 13.364885, // Start
        2451.844970, -1964.523193, 13.387802, // Idle
        2450.502685, -1964.619384, 13.411356, // End
        __addressof(SubmachineShop_OnBuy)
    );
    Shop_AddItem(submachine_shop, "Micro SMG/Uzi", 352, 1100, -88.199981, 0.000000, 37.900032);
    Shop_AddItem(submachine_shop, "MP5", 353, 2400, -88.199981, 0.000000, 37.900032);
    Shop_AddItem(submachine_shop, "Tec-9", 372, 900, -88.199981, 0.000000, 37.900032);

    // Rifle shop
    CreateDynamicActor(161, 2458.5735, -1969.5461, 13.4984, 91.5895, .worldid = 0, .interiorid = 0);
    new rifle_shop = Shop_Create("Comprar rifles", 2455.9763, -1969.6743, 13.5482, 0, 0, 
        2456.080322, -1969.684692, 14.325413, // Cam pos
        2460.118652, -1969.831420, 11.380958, // Cam look
        2457.427246, -1971.318725, 13.331473, // Start
        2457.138916, -1969.966308, 13.440942, // Idle
        2456.884521, -1968.482543, 13.564177, // End
        __addressof(RifleShop_OnBuy)
    );
    Shop_AddItem(rifle_shop, "AK-47", 355, 10000, 84.000061, -39.400012, 150.699996);
    Shop_AddItem(rifle_shop, "M4", 356, 16000, 84.000061, -39.400012, 150.699996);
    Shop_AddItem(rifle_shop, "Country Rifle", 357, 5000, 84.000061, -39.400012, 150.699996);

    #if defined BMARKET_OnScriptInit
        return BMARKET_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit BMARKET_OnScriptInit
#if defined BMARKET_OnScriptInit
    forward BMARKET_OnScriptInit();
#endif
