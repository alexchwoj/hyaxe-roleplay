#if defined _pizza_callbacks_
    #endinput
#endif
#define _pizza_callbacks_

static Pizza_OnBuy(playerid, shop_id, item_id)
{
    #pragma unused shop_id

    return 1;
}

public OnGameModeInit()
{
    // Actors
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 1, .interiorid = 5);

    // EnExs
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 2105.0681, -1806.4565, 13.5547, 91.9755, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 1, 5, -1, 0);

    // MapIcons
    CreateDynamicMapIcon(2105.0681, -1806.4565, 13.5547, 29, -1, .worldid = 0, .interiorid = 0);

    new ugis = Shop_Create("Ugi's Pizza", 373.7325, -119.4309, 1001.4922, -1, 5, 
        372.986755, -118.988250, 1002.399780, 
        375.441986, -115.871269, 999.357360,
        373.21, -118.10, 1001.58,
        373.97, -118.07, 1001.58,
        375.06, -118.06, 1001.58,
        __addressof(Pizza_OnBuy)
    );
    Shop_AddItem(ugis, "Porción de pizza pepperoni", 2218, 25, -25.29, 23.39, 74.69); // Pizza tray
    Shop_AddItem(ugis, "Pizza con papas fritas", 2220, 35, -25.29, 23.39, 74.69); // Pizza with extras
    Shop_AddItem(ugis, "Ensalada con pollo", 2355, 40, -25.29, 23.39, 74.69 ); // Chicken Salad
    Shop_AddItem(ugis, "Porción de pizza con ensalada", 2219, 50, -25.29, 23.39, 74.69); // Pizza and salad
    Shop_AddItem(ugis, "Pizza grande", 19580, 100, -25.29, 23.39, 74.69); // Large pizza

    #if defined PIZZA_OnGameModeInit
        return PIZZA_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit PIZZA_OnGameModeInit
#if defined PIZZA_OnGameModeInit
    forward PIZZA_OnGameModeInit();
#endif
