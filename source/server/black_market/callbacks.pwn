#if defined _black_market_callbacks_
    #endinput
#endif
#define _black_market_callbacks_

static PistolShop_OnBuy(playerid, shop_id, item_id)
{
    switch(item_id)
    {
        case 0: Player_GiveWeapon(playerid, 22, 99999);
        case 1: Player_GiveWeapon(playerid, 23, 99999);
        case 2: Player_GiveWeapon(playerid, 24, 99999);
    }

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Compraste un(a) %s a ~g~$%d", g_rgeShopItems[shop_id][item_id][e_szItemName], g_rgeShopItems[shop_id][item_id][e_iItemPrice]);
    Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 4000, 0x64A752FF);
    return SHOP_SELL_ON_CREDIT;
}

static ShotgunShop_OnBuy(playerid, shop_id, item_id)
{
    switch(item_id)
    {
        case 0: Player_GiveWeapon(playerid, 25, 99999);
        case 1: Player_GiveWeapon(playerid, 26, 99999);
        case 2: Player_GiveWeapon(playerid, 27, 99999);
    }

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Compraste un(a) %s a ~g~$%d", g_rgeShopItems[shop_id][item_id][e_szItemName], g_rgeShopItems[shop_id][item_id][e_iItemPrice]);
    Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 4000, 0x64A752FF);
    return 1;
}

public OnGameModeInit()
{
    CreateDynamicMapIcon(2453.5684, -1971.7292, 13.5469, 18, -1, .worldid = 0, .interiorid = 0);

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

    // Rifle shop
    //CreateDynamicActor(161, 2447.4807, -1980.9473, 13.5469, 0.2792, .worldid = 0, .interiorid = 0);

    #if defined BMARKET_OnGameModeInit
        return BMARKET_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit BMARKET_OnGameModeInit
#if defined BMARKET_OnGameModeInit
    forward BMARKET_OnGameModeInit();
#endif
