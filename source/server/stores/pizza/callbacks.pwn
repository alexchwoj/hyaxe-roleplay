#if defined _pizza_callbacks_
    #endinput
#endif
#define _pizza_callbacks_

static Pizza_OnBuy(playerid, shop_id, item_id)
{
    #pragma unused shop_id

    if(g_rgePlayerTempData[playerid][e_iPlayerEatTick] && GetTickDiff(GetTickCount(), g_rgePlayerTempData[playerid][e_iPlayerEatTick]) >= 120000)
    {
        g_rgePlayerTempData[playerid][e_iPlayerEatCount] = 0;
    }

    if(g_rgePlayerTempData[playerid][e_iPlayerPukeTick])
    {
        new diff = GetTickDiff(GetTickCount(), g_rgePlayerTempData[playerid][e_iPlayerPukeTick]);
        if(diff <= 300000)
        {
            SendClientMessagef(playerid, 0xDADADAFF, "Vomitaste hace poco y la comida te caera mal. Espera {CB3126}%i minutos{DADADA} antes de volver a comer.", ((300000 - diff) / 60000));
            return 0;
        }
    }

    g_rgePlayerTempData[playerid][e_iPlayerPukeTick] = 0;
    g_rgePlayerTempData[playerid][e_iPlayerEatCount]++;
    g_rgePlayerTempData[playerid][e_iPlayerEatTick] = GetTickCount();

    switch(item_id)
    {
        case 0:
        {
            SendClientMessage(playerid, 0xDADADAFF, "Compraste una {CB3126}porción de pizza pepperoni{DADADA}.");
            Player_AddHunger(playerid, -10.0);
            Player_AddThirst(playerid, 1.0);
        }
    }

    if(g_rgePlayerTempData[playerid][e_iPlayerEatCount] >= (Player_Skin(playerid) == 5 ? 10 : 5))
    {
        Player_Puke(playerid);
        return 0;
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    Sound_PlayInRange(SOUND_EAT, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

    return 1;
}

static PreloadPizzaPlaceAnims(playerid, bool:enter)
{
    if(enter)
    {
        ApplyAnimation(playerid, "FOOD", "null", 4.1, 0, 0, 0, 0, 0, 0);
    }

    return 1;
}

public OnScriptInit()
{
    // Actors
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 1, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 2, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 3, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 4, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 5, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 6, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 7, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 8, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 9, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 10, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 11, .interiorid = 5);
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 12, .interiorid = 5);

    // EnExs
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 2105.234619, -1806.479614, 13.554687, 90.0, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 1, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 1367.0798, 248.4809, 19.5669, 61.7051, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 2, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 2333.1362, 75.0152, 26.6210, 273.9927, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 3, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 2637.8176, 1849.6595, 11.0234, 91.669, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 4, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 2540.3069, 2150.0823, 10.8203, 92.0697, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 5, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 2469.5881, 2124.7515, 10.8203, 2.2244, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 6, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 2083.4851, 2224.2705, 11.0234, 181.7665, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 7, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 2351.9446, 2532.8774, 10.8203, 184.0101, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 8, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 2756.3547, 2477.1909, 11.0625, 140.568, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 9, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", -1808.5914, 945.7186, 24.8906, 217.5869, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 10, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", 203.5956, -202.7363, 1.5781, 179.2534, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 11, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza", "{DADADA}Salida", -1721.5070, 1359.7260, 7.1853, 88.3410, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 12, 5, .callback_address = __addressof(PreloadPizzaPlaceAnims));

    // MapIcons
    CreateDynamicMapIcon(2105.234619, -1806.479614, 13.554687, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(1366.856079, 248.451507, 19.566932, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2333.892333, 74.830787, 26.620975, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2637.8176, 1849.6595, 11.0234, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2540.3069, 2150.0823, 10.8203, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2469.5881, 2124.7515, 10.8203, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2083.4851, 2224.2705, 11.0234, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2351.9446, 2532.8774, 10.8203, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2756.3547, 2477.1909, 11.0625, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(-1808.33, 945.7053, 24.8906, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(-1721.5070, 1359.7260, 7.1853, 29, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon( 203.5956, -202.7363, 1.5781, 29, -1, .worldid = 0, .interiorid = 0);

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

    #if defined PIZZA_OnScriptInit
        return PIZZA_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit PIZZA_OnScriptInit
#if defined PIZZA_OnScriptInit
    forward PIZZA_OnScriptInit();
#endif
