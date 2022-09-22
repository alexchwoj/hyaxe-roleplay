#if defined _car_rental_callbacks_
    #endinput
#endif
#define _car_rental_callbacks_

static Rental_OnKeyPress(playerid)
{
    Dialog_Show(playerid, "rent_car", DIALOG_STYLE_MSGBOX, !"{CB3126}Rentar un auto", !"{DADADA}¿Quieres rentar un Manana por {64A752}$50{DADADA}?", !"Rentar", !"Cerrar");
    return 1;
}

public OnGameModeInit()
{
    CreateDynamic3DTextLabel(
        "Rentar un auto\n{F7F7F7}Presiona {CB3126}Y{F7F7F7} para rentar", 0xCB3126FF,
        1677.0374, -1134.7346, 23.9140, 15.0,
        .testlos = true, .worldid = 0, .interiorid = 0
    );
    Key_Alert(1677.0374, -1134.7346, 23.9140, 2.6, KEYNAME_YES, 0, 0, .callback_on_press = __addressof(Rental_OnKeyPress));
    CreateDynamicMapIcon(1677.0374, -1134.7346, 23.9140, 55, -1, .worldid = 0, .interiorid = 0);

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
            Vehicle_Destroy(g_rgiPlayerRentalCar[playerid]);

        new index = random( sizeof(g_rgfCarRentalPosition) );
        g_rgiPlayerRentalCar[playerid] = Vehicle_Create(
            410,
            g_rgfCarRentalPosition[index][0],
            g_rgfCarRentalPosition[index][1],
            g_rgfCarRentalPosition[index][2],
            g_rgfCarRentalPosition[index][3],
            -1, -1, 0)
        ;
        Vehicle_Type(g_rgiPlayerRentalCar[playerid]) = VEHICLE_TYPE_RENTAL;
        Vehicle_OwnerId(g_rgiPlayerRentalCar[playerid]) = playerid;

        Player_PutInVehicle(playerid, g_rgiPlayerRentalCar[playerid]);

        Player_GiveMoney(playerid, -50);
        PlayerPlaySound(playerid, SOUND_SUCCESS);

        Notification_Show(playerid, "Has rentado un Manana.", 4000, 0x64A752FF);
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if (IsValidVehicle(g_rgiPlayerRentalCar[playerid]))
        Vehicle_Destroy(g_rgiPlayerRentalCar[playerid]);

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
