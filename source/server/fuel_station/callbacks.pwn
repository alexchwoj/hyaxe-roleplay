#if defined _fuel_station_callbacks_
    #endinput
#endif
#define _fuel_station_callbacks_

public OnGameModeInit()
{
    for(new i; i < sizeof(g_rgfFuelStations); ++i)
    {
        Key_Alert(
            g_rgfFuelStations[i][0], g_rgfFuelStations[i][1], g_rgfFuelStations[i][2], 12.5,
            KEYNAME_YES, 0, 0
        );

        CreateDynamic3DTextLabel(
            "Gasolinera\n{F7F7F7}Precio del litro: {64A752}$3", 0xDAA838FF,
            g_rgfFuelStations[i][0], g_rgfFuelStations[i][1], g_rgfFuelStations[i][2] + 0.5, 15.0,
            .testlos = true, .worldid = 0, .interiorid = 0
        );

        new area_id = CreateDynamicSphere(g_rgfFuelStations[i][0], g_rgfFuelStations[i][1], g_rgfFuelStations[i][2], 2.5, .worldid = 0, .interiorid = 0);
        Streamer_SetIntData(STREAMER_TYPE_AREA, area_id, E_STREAMER_EXTRA_ID, 0x4655454c); // FUEL
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


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_YES) != 0)
    {
        if(IsPlayerInAnyDynamicArea(playerid))
        {
            for_list(it : GetPlayerAllDynamicAreas(playerid))
            {
                new info = Streamer_GetIntData(STREAMER_TYPE_AREA, iter_get(it), E_STREAMER_EXTRA_ID);
                if(info == 0x4655454c)
                {
                    if (!IsPlayerInAnyVehicle(playerid))
                    {
                        PlayerPlaySound(playerid, SOUND_ERROR);
                        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "No estás en un vehículo.");
                    }
                    Dialog_Show(playerid, "fuel_station", DIALOG_STYLE_LIST, !"{CB3126}Gasolinera", !"Llenar tanque\nCargar por litro", !"Seleccionar", !"Cerrar");
                }
            }
        }
    }

    #if defined FUEL_OnPlayerKeyStateChange
        return FUEL_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange FUEL_OnPlayerKeyStateChange
#if defined FUEL_OnPlayerKeyStateChange
    forward FUEL_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
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
            case 1: Dialog_Show(playerid, "fuel_station_manual", DIALOG_STYLE_INPUT, !"{CB3126}Gasolinera", !"Llenar tanque\nCargar por litro", !"Seleccionar", !"Cerrar");
        }
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
        
        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Cargaste %.2f litros de combustible por $%f", fuel_to_load, price);
        Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 3000, 0x64A752FF);
    }
    return 1;
}