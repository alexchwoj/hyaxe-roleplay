#if defined _pizza_callbacks_
    #endinput
#endif
#define _pizza_callbacks_

public OnGameModeInit()
{
    // Actors
    Actor_CreateRobbable(155, 500, 750, 373.7393, -117.2236, 1002.4995, 175.4680, .worldid = 1, .interiorid = 5);

    // EnExs
    EnterExit_Create(19902, "{ED2B2B}Ugi's Pizza\n{DADADA}Presiona {ED2B2B}H {DADADA}para entrar", "{DADADA}Presiona {ED2B2B}H {DADADA}para salir", 2105.0681, -1806.4565, 13.5547, 91.9755, 0, 0, 372.4150, -133.3214, 1001.4922, 355.1316, 1, 5, -1, 0);

    // MapIcons
    CreateDynamicMapIcon(2105.0681, -1806.4565, 13.5547, 29, -1, .worldid = 0, .interiorid = 0);

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
