#if defined _car_rental_callbacks_
    #endinput
#endif
#define _car_rental_callbacks_

public OnGameModeInit()
{
    CreateDynamic3DTextLabel(
        "Rentar un auto\n{F7F7F7}Presiona {CB3126}Y{F7F7F7} para rentar", 0xCB3126FF,
        1677.0374, -1134.7346, 23.9140, 15.0,
        .testlos = true, .worldid = 0, .interiorid = 0
    );
    Key_Alert(1677.0374, -1134.7346, 23.9140, 2.6, KEYNAME_YES, 0, 0);

    new area_id = CreateDynamicSphere(1677.0374, -1134.7346, 23.9140, 2.5, 0, 0);
	Streamer_SetIntData(STREAMER_TYPE_AREA, area_id, E_STREAMER_CUSTOM(0x524e54), 1); // RNT

    #if defined RENTAL_OnGameModeInit
        return RENTAL_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit RENTAL_OnGameModeInit
#if defined RENTAL_OnGameModeInit
    forward RENTAL_OnGameModeInit();
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_YES) != 0)
    {
        if (IsPlayerInAnyDynamicArea(playerid))
        {
            for_list(it : GetPlayerAllDynamicAreas(playerid))
            {
                new areaid = iter_get(it);
                if (Streamer_HasArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x524e54)))
                {
                    Dialog_Show(playerid, "rent_car", DIALOG_STYLE_MSGBOX, !"{CB3126}Rentar un auto", !"{DADADA}¿Quieres rentar un Manana por {64A752}$50{DADADA}?", !"Rentar", !"Cerrar");
                    return 1;
                }
            }
        }
    }

    #if defined RENTAL_OnPlayerKeyStateChange
        return RENTAL_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange RENTAL_OnPlayerKeyStateChange
#if defined RENTAL_OnPlayerKeyStateChange
    forward RENTAL_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

dialog rent_car(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        if (50 > Player_Money(playerid))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
            return 1;
        }

        if (IsValidVehicle(g_rgiPlayerRentalCar[playerid]))
            DestroyVehicle(g_rgiPlayerRentalCar[playerid]);

        new index = random( sizeof(g_rgfCarRentalPosition) );
        g_rgiPlayerRentalCar[playerid] = Vehicle_Create(
            410,
            g_rgfCarRentalPosition[index][0],
            g_rgfCarRentalPosition[index][1],
            g_rgfCarRentalPosition[index][2],
            g_rgfCarRentalPosition[index][3],
            -1, -1, 0)
        ;
        PutPlayerInVehicle(playerid, g_rgiPlayerRentalCar[playerid], 0);

        Player_GiveMoney(playerid, -50);
        PlayerPlaySound(playerid, SOUND_SUCCESS);

        Notification_Show(playerid, "Has rentado un Manana.", 4000, 0x64A752FF);
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if (IsValidVehicle(g_rgiPlayerRentalCar[playerid]))
        DestroyVehicle(g_rgiPlayerRentalCar[playerid]);

    #if defined RENTAL_OnPlayerDisconnect
        return RENTAL_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect RENTAL_OnPlayerDisconnect
#if defined RENTAL_OnPlayerDisconnect
    forward RENTAL_OnPlayerDisconnect(playerid, reason);
#endif
