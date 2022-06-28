#if defined _fuel_station_callbacks_
    #endinput
#endif
#define _fuel_station_callbacks_

static GasStation_OnKeyPress(playerid)
{
    Dialog_Show(playerid, "fuel_station", DIALOG_STYLE_LIST, !"{CB3126}Gasolinera", !"Llenar tanque\nCargar por litro", !"Seleccionar", !"Cerrar");
    return 1;
}

public OnGameModeInit()
{
    for(new i; i < sizeof(g_rgfFuelStations); ++i)
    {
        Key_Alert(
            g_rgfFuelStations[i][0], g_rgfFuelStations[i][1], g_rgfFuelStations[i][2], 12.5,
            KEYNAME_CTRL_BACK, 0, 0, KEY_TYPE_VEHICLE, .callback_on_press = __addressof(GasStation_OnKeyPress)
        );

        CreateDynamic3DTextLabel(
            "Gasolinera\n{F7F7F7}Precio del litro: {64A752}$3", 0xDAA838FF,
            g_rgfFuelStations[i][0], g_rgfFuelStations[i][1], g_rgfFuelStations[i][2] + 0.5, 15.0,
            .testlos = true, .worldid = 0, .interiorid = 0
        );
    }

    #if defined FUEL_OnGameModeInit
        return FUEL_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit FUEL_OnGameModeInit
#if defined FUEL_OnGameModeInit
    forward FUEL_OnGameModeInit();
#endif

dialog fuel_station(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        new vehicle_id = GetPlayerVehicleID(playerid);
        if (vehicle_id == INVALID_VEHICLE_ID)
            return 0;

        switch (listitem)
        {
            case 0:
            {
                new Float:fuel_to_load = Vehicle_GetModelMaxFuel( GetVehicleModel(vehicle_id) ) - Vehicle_Fuel(vehicle_id);
                if (fuel_to_load <= 0.25)
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Tienes el tanque lleno.");
                }

                format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}¿Quieres cargar %.2f litros de combustible por {64A752}$%d{DADADA}?", fuel_to_load, floatround(3 * fuel_to_load));
                Dialog_Show(playerid, "fuel_station_full", DIALOG_STYLE_MSGBOX, !"{CB3126}Gasolinera", HYAXE_UNSAFE_HUGE_STRING, !"Si", !"No");
            }
            case 1: Dialog_Show(playerid, "fuel_station_manual", DIALOG_STYLE_INPUT, !"{CB3126}Gasolinera", !"{DADADA}¿Cuántos litros de gasolina quieres cargar?", !"Seguir", !"Cerrar");
        }
    }
    return 1;
}

dialog fuel_station_manual(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        extract inputtext -> new liters; else
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Introduce un valor numérico.");
            return 1;
        }

        new vehicle_id = GetPlayerVehicleID(playerid);
        if (vehicle_id == INVALID_VEHICLE_ID)
            return 0;

        if (liters > (Vehicle_GetModelMaxFuel( GetVehicleModel(vehicle_id) ) - Vehicle_Fuel(vehicle_id)))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No entra tanto combustible en el tanque.");
            return 1;
        }

        new price = 3 * liters;
        if (price > Player_Money(playerid))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);

            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "No tienes el dinero suficiente, necesitas $%d.", price);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, HYAXE_UNSAFE_HUGE_STRING);
            return 1;
        }

        Vehicle_Fuel(vehicle_id) += liters;
        Player_GiveMoney(playerid, -price);
        PlayerPlaySound(playerid, 32600);

        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Cargaste %d litros de combustible por $%d", liters, price);
        Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 3000, 0x64A752FF);
    }
    return 1;
}

dialog fuel_station_full(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        new vehicle_id = GetPlayerVehicleID(playerid);
        if (vehicle_id == INVALID_VEHICLE_ID)
            return 0;

        new 
            Float:fuel_to_load = Vehicle_GetModelMaxFuel( GetVehicleModel(vehicle_id) ) - Vehicle_Fuel(vehicle_id),
            price = floatround(3 * fuel_to_load)
        ;

        if (price > Player_Money(playerid))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
            return 1;
        }

        Vehicle_Fuel(vehicle_id) += fuel_to_load;
        Player_GiveMoney(playerid, -price);
        PlayerPlaySound(playerid, 32600);

        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Cargaste %.2f litros de combustible por $%d", fuel_to_load, price);
        Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 3000, 0x64A752FF);
    }
    return 1;
}