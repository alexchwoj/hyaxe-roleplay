#if defined _tuning_callbacks_
    #endinput
#endif
#define _tuning_callbacks_

static Tuning_OnPress(playerid, repairid)
{
    #pragma unused repairid
    Tuning_Open(playerid);
    return 1;
}

public OnGameModeInit()
{
    new area_id = CreateDynamicCube(
        -122.50, -1207.50, 0.0,
        -53.50, -1138.50, 10.0,
        .worldid = 0, .interiorid = 0
    );
    Streamer_SetIntData(STREAMER_TYPE_AREA, area_id, E_STREAMER_CUSTOM(0x4d4558), 0); // MEC

    for(new i; i < sizeof(g_rgeRepairPositions); ++i)
    {
        CreateDynamic3DTextLabel("{CB3126}Taller mecánico\n{DADADA}Modifique su vehículo aquí", 0xFFFFFFFF, g_rgeRepairPositions[i][e_fRepairPosX], g_rgeRepairPositions[i][e_fRepairPosY], g_rgeRepairPositions[i][e_fRepairPosZ], 10.0, .testlos = 1);
        Key_Alert(g_rgeRepairPositions[i][e_fRepairPosX], g_rgeRepairPositions[i][e_fRepairPosY], g_rgeRepairPositions[i][e_fRepairPosZ], 1.5, KEYNAME_YES, 0, 0, KEY_TYPE_VEHICLE, .callback_on_press = __addressof(Tuning_OnPress), .cb_data = i);
    }

    #if defined TUN_OnGameModeInit
        return TUN_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit TUN_OnGameModeInit
#if defined TUN_OnGameModeInit
    forward TUN_OnGameModeInit();
#endif

public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if (Streamer_HasArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4d4558)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        //Notification_Show(playerid, "Has entrado al taller mecánico, las colisiones de tu vehículo se han desactivado.", 3000, 0xDAA838FF);
        DisableRemoteVehicleCollisions(playerid, true);
    }

    #if defined TUN_OnPlayerEnterDynamicArea
        return TUN_OnPlayerEnterDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicArea
    #undef OnPlayerEnterDynamicArea
#else
    #define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea TUN_OnPlayerEnterDynamicArea
#if defined TUN_OnPlayerEnterDynamicArea
    forward TUN_OnPlayerEnterDynamicArea(playerid, areaid);
#endif

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    if (Streamer_HasArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x4d4558)) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        //Notification_Show(playerid, "Has salido del taller mecánico, las colisiones de tu vehículo se han activado de nuevo.", 3000, 0xDAA838FF);
        DisableRemoteVehicleCollisions(playerid, false);
    }

    #if defined TUN_OnPlayerLeaveDynamicArea
        return TUN_OnPlayerLeaveDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerLeaveDynamicArea
    #undef OnPlayerLeaveDynamicArea
#else
    #define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea TUN_OnPlayerLeaveDynamicArea
#if defined TUN_OnPlayerLeaveDynamicArea
    forward TUN_OnPlayerLeaveDynamicArea(playerid, areaid);
#endif

public GARAGE_VehicleRepairPlaySound(playerid)
{
    static const random_sounds[] = {
        1133,
        1134,
        1140,
        1148
    };

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    Sound_PlayInRange(random_sounds[random(sizeof(random_sounds))], 10.0, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

    return 1;
}

public GARAGE_FinishRepairCar(playerid, vehicleid, bool:show_tuning)
{
    Vehicle_Repair(vehicleid);
    Vehicle_Repairing(vehicleid) = false;
    Notification_ShowBeatingText(playerid, 3000, 0x98D952, 100, 255, "Vehículo reparado");
    Timer_Kill(g_rgiRepairSoundTimer[playerid]);
    g_rgiRepairFinishTimer[playerid] = 0;

    if (show_tuning)
        TuningMenu_Main(playerid);
    return 1;
}

forward TUNING_MainComponents(playerid);
public TUNING_MainComponents(playerid)
{
    new row_count;
    cache_get_row_count(row_count);

    for(new i = 0; i < row_count; ++i)
    {
        cache_get_value_name_int(i, "CAMERA_TYPE", g_rgeTuningMenu[playerid][i][e_iCameraType]);
        cache_get_value_name(i, "PART", g_rgeTuningMenu[playerid][i][e_szName], 24);
        Menu_AddItem(playerid, g_rgeTuningMenu[playerid][i][e_szName]);
    }

    Menu_UpdateListitems(playerid);
    return 1;
}

forward TUNING_SubComponents(playerid);
public TUNING_SubComponents(playerid)
{
    new row_count;
    cache_get_row_count(row_count);

    for(new i = 0; i < row_count; ++i)
    {
        cache_get_value_name_int(i, "ID", g_rgeTuningMenu[playerid][i][e_iID]);
        cache_get_value_name_int(i, "PRICE", g_rgeTuningMenu[playerid][i][e_iPrice]);
        cache_get_value_name(i, "NAME", g_rgeTuningMenu[playerid][i][e_szName], 24);

        new line_str[32];
        format(line_str, sizeof(line_str), "Precio: ~g~$%d", g_rgeTuningMenu[playerid][i][e_iPrice]);
        Menu_AddItem(playerid, g_rgeTuningMenu[playerid][i][e_szName], line_str);
    }

    Menu_UpdateListitems(playerid);
    return 1;
}

Menu:tuning_main(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_CLOSE)
    {
        Tuning_Back(playerid);
    }
    else if (response == MENU_RESPONSE_SELECT)
    {
        switch(listitem)
        {
            case 0:
            {
                if (Player_Money(playerid) < 250)
                {
                    Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes dinero para reparar tu vehículo");
                    TuningMenu_Main(playerid);
                    return 1;
                }

                Player_GiveMoney(playerid, -250);

                PlayerPlaySound(playerid, 12201);

                new vehicleid = GetPlayerVehicleID(playerid);
                Vehicle_ToggleEngine(vehicleid, VEHICLE_STATE_OFF);
                Vehicle_Repairing(vehicleid) = true;

                Notification_ShowBeatingText(playerid, 5000, 0xF29624, 100, 255, "Reparando vehículo...");
                g_rgiRepairSoundTimer[playerid] = SetTimerEx("GARAGE_VehicleRepairPlaySound", 1000, true, "i", playerid);
                g_rgiRepairFinishTimer[playerid] = SetTimerEx("GARAGE_FinishRepairCar", 5000, false, "iib", playerid, vehicleid, true);
            }

            case 1:
            {
                TuningMenu_SelectColorSlot(playerid);
            }

            case 2:
            {
                new paintjobs = Vehicle_GetPaintjobs(GetVehicleModel( GetPlayerVehicleID(playerid) ));
                if (!paintjobs)
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Este vehículo no admite trabajos de pintura.");
                    TuningMenu_Main(playerid);
                    return 1;
                }

                Menu_Show(playerid, "tuning_paintjob", "Paintjob");
                Menu_AddItem(playerid, "Eliminar paintjob", "Precio: ~g~$500");
                for(new i; i != paintjobs; ++i)
                {
                    new line_str[25];
                    format(line_str, sizeof line_str, "Poaintjob %d", i + 1);
                    Menu_AddItem(playerid, line_str, "Precio: 500$");
                }
            }

            default:
            {
                g_rgiTuningCamera[playerid] = g_rgeTuningMenu[playerid][listitem - 3][e_iCameraType];

                Menu_Show(playerid, "tuning_sel_component", g_rgeTuningMenu[playerid][listitem - 3][e_szName]);

                InterpolateCameraPos(
                    playerid, 606.906799, 2.143145, 1002.159118,
                    g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fPosX],
                    g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fPosY],
                    g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fPosZ],
                    1000
                );

                InterpolateCameraLookAt(
                    playerid, 611.030334, -0.317962, 1000.766418,
                    g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fLookX],
                    g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fLookY],
                    g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fLookZ],
                    1000
                );

                mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "SELECT `COMPONENTS_INFO`.`ID`, `COMPONENTS_INFO`.`NAME` FROM `COMPONENTS_INFO`, `VEHICLE_COMPONENTS` WHERE `COMPONENTS_INFO`.`PART` = '%s' AND `VEHICLE_COMPONENTS`.`MODELID` = '%d' AND `VEHICLE_COMPONENTS`.`COMPONENT_ID` = `COMPONENTS_INFO`.`ID`;", g_rgeTuningMenu[playerid][listitem - 3][e_szName], GetVehicleModel( GetPlayerVehicleID(playerid) ));
                mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "TUNING_SubComponents", !"i", playerid);
            }
        }
    }
    return 1;
}

Menu:tuning_paintjob(playerid, response, listitem)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if (!IsValidVehicle(vehicleid))
        return 1;

    if (response == MENU_RESPONSE_CLOSE)
    {
        TuningMenu_Main(playerid);
        ChangeVehiclePaintjob(vehicleid, g_rgeVehicles[vehicleid][e_iPaintjob]);
    }
    else if (response == MENU_RESPONSE_SELECT)
    {
        TuningMenu_Main(playerid);

        if (500 > Player_Money(playerid))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
            TuningMenu_SelectColorSlot(playerid);
            return 1;
        }

        Player_GiveMoney(playerid, -500);
        PlayerPlaySound(playerid, 1133);
    }
    else if (response == MENU_RESPONSE_DOWN || response == MENU_RESPONSE_UP)
    {
        if (!listitem)
            ChangeVehiclePaintjob(vehicleid, 3);
        else
            ChangeVehiclePaintjob(vehicleid, listitem - 1);
    }
    return 1;
}

Menu:tuning_sel_component(playerid, response, listitem)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if (!IsValidVehicle(vehicleid))
        return 1;

    if (response == MENU_RESPONSE_CLOSE)
    {
        TuningMenu_Main(playerid);

        if (g_rgiActualTuningComponent[playerid] != -1)
        {
            RemoveVehicleComponent(vehicleid, g_rgiActualTuningComponent[playerid]);

            for(new i; i < 14; ++i)
            {
                AddVehicleComponent(vehicleid, g_rgeVehicles[vehicleid][e_iComponents][i]);
            }
        }
    }
    else if (response == MENU_RESPONSE_SELECT)
    {
        TuningMenu_Main(playerid);

        if (g_rgeTuningMenu[playerid][listitem][e_iPrice] > Player_Money(playerid))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
            TuningMenu_SelectColorSlot(playerid);
            return 1;
        }

        Player_GiveMoney(playerid, -g_rgeTuningMenu[playerid][listitem][e_iPrice]);
        PlayerPlaySound(playerid, 1133);
    }
    else if (response == MENU_RESPONSE_DOWN || response == MENU_RESPONSE_UP)
    {
        g_rgiActualTuningComponent[playerid] = g_rgeTuningMenu[playerid][listitem][e_iID];
        AddVehicleComponent(vehicleid, g_rgeTuningMenu[playerid][listitem][e_iID]);
    }
    return 1;
}

Menu:tuning_color_type(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_CLOSE)
    {
        TuningMenu_Main(playerid);

        new vehicleid = GetPlayerVehicleID(playerid);
        if (IsValidVehicle(vehicleid))
            ChangeVehicleColor(vehicleid, g_rgeVehicles[vehicleid][e_iColorOne], g_rgeVehicles[vehicleid][e_iColorTwo]);
    }
    else if (response == MENU_RESPONSE_SELECT)
    {
        g_rgiSelectedColorType[playerid] = listitem;

        Menu_Show(playerid, "tuning_color", (g_rgiSelectedColorType[playerid] ? "Color 2" : "Color 1"), .clearChat = true);

        for(new i; i < 128; ++i)
        {
            new line_str[32];
            format(line_str, sizeof(line_str), "%d (%x)", i, g_rgiVehicleColoursTableRGBA[i]);
            Menu_AddItem(playerid, line_str, .color = g_rgiVehicleColoursTableRGBA[i]);
        }
        Menu_UpdateListitems(playerid);
    }
    return 1;
}

Menu:tuning_color(playerid, response, listitem)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if (!IsValidVehicle(vehicleid))
        return 1;

    if (response == MENU_RESPONSE_CLOSE)
    {
        TuningMenu_SelectColorSlot(playerid);
    }
    else if (response == MENU_RESPONSE_SELECT)
    {
        new cost = (g_rgiSelectedColorType[playerid] ? 75 : 100);
        if (cost > Player_Money(playerid))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
            TuningMenu_SelectColorSlot(playerid);
            return 1;
        }

        Player_GiveMoney(playerid, -cost);
        TuningMenu_Main(playerid);

        new color1, color2;
        GetVehicleColor(vehicleid, color1, color2);
        if (g_rgiSelectedColorType[playerid])
        {
            g_rgeVehicles[vehicleid][e_iColorTwo] = color2;
            ChangeVehicleColor(vehicleid, g_rgeVehicles[vehicleid][e_iColorOne], color2);
        }
        else
        {
            g_rgeVehicles[vehicleid][e_iColorOne] = color1;
            ChangeVehicleColor(vehicleid, color1, g_rgeVehicles[vehicleid][e_iColorTwo]);
        }

        PlayerPlaySound(playerid, 1134);
    }
    else if (response == MENU_RESPONSE_DOWN)
    {
        //printf("[DOWN] COLOR %d (%x)", listitem, g_rgiVehicleColoursTableRGBA[listitem]);

        if (g_rgiSelectedColorType[playerid])
            ChangeVehicleColor(vehicleid, g_rgeVehicles[vehicleid][e_iColorOne], listitem);
        else
            ChangeVehicleColor(vehicleid, listitem, g_rgeVehicles[vehicleid][e_iColorTwo]);
    }
    else if (response == MENU_RESPONSE_UP)
    {
        //printf("[UP] COLOR %d (%x)", listitem, g_rgiVehicleColoursTableRGBA[listitem]);

        if (g_rgiSelectedColorType[playerid])
            ChangeVehicleColor(vehicleid, g_rgeVehicles[vehicleid][e_iColorOne], listitem);
        else
            ChangeVehicleColor(vehicleid, listitem, g_rgeVehicles[vehicleid][e_iColorTwo]);
    }
    return 1;
}