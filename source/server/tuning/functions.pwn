#if defined _tuning_functions_
    #endinput
#endif
#define _tuning_functions_

TuningMenu_Main(playerid)
{
    InterpolateCameraPos(
        playerid,
        g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fPosX],
        g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fPosY],
        g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fPosZ],
        606.906799, 2.143145, 1002.159118,
        1000
    );
                
    InterpolateCameraLookAt(
        playerid,
        g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fLookX],
        g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fLookY],
        g_rgeTuningCameras[ g_rgiTuningCamera[playerid] ][e_fLookZ],
        611.030334, -0.317962, 1000.766418,
        1000
    );

    g_rgiTuningCamera[playerid] = 0;

    Menu_Show(playerid, "tuning_main", "Tuning", .clearChat = true);
    Menu_AddItem(playerid, "Reparar", "Precio: ~g~$250");
    Menu_AddItem(playerid, "Colores");
	Menu_AddItem(playerid, "Paintjob");

    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "SELECT `COMPONENTS_INFO`.`PART`, `COMPONENTS_INFO`.`CAMERA_TYPE` FROM `COMPONENTS_INFO`, `VEHICLE_COMPONENTS` WHERE `VEHICLE_COMPONENTS`.`MODELID` = '%d' AND `VEHICLE_COMPONENTS`.`COMPONENT_ID` = `COMPONENTS_INFO`.`ID` GROUP BY `COMPONENTS_INFO`.`PART`;", GetVehicleModel( GetPlayerVehicleID(playerid) ));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "TUNING_MainComponents", !"i", playerid);
    return 1;
}

TuningMenu_SelectColorSlot(playerid)
{
    Menu_Show(playerid, "tuning_color_type", "Colores", .clearChat = true);
    Menu_AddItem(playerid, "Color primario", "Precio: ~g~$100");
    Menu_AddItem(playerid, "Color secundario", "Precio: ~g~$75");
    Menu_UpdateListitems(playerid);
    return 1;
}

Tuning_Open(playerid)
{
    new vehicle_id = GetPlayerVehicleID(playerid);
    if (!IsValidVehicle(vehicle_id))
        return 0;

    // Put the player in the garage
    GetVehiclePos(vehicle_id, s_rgfPreviusTuningPos[playerid][0], s_rgfPreviusTuningPos[playerid][1], s_rgfPreviusTuningPos[playerid][2]);
    GetVehicleZAngle(vehicle_id, s_rgfPreviusTuningPos[playerid][3]);
    s_rgiPreviusTuningInterior[playerid] = GetPlayerInterior(playerid);
    s_rgiPreviusTuningWorld[playerid] = GetPlayerVirtualWorld(playerid);

    SetPlayerVirtualWorld(playerid, playerid);
    SetPlayerInterior(playerid, 1);

    SetVehiclePos(vehicle_id, 612.3940, -1.1072, 1000.6490);
    SetVehicleZAngle(vehicle_id, 90.0593);
    SetVehicleVirtualWorld(vehicle_id, playerid);
    LinkVehicleToInterior(vehicle_id, 1);

    Player_SetPos(playerid, 612.3940, -1.1072, 1000.6490);
    PutPlayerInVehicle(playerid, vehicle_id, 0);
    TogglePlayerControllable(playerid, false);
    SetCameraBehindPlayer(playerid);
    g_rgiActualTuningComponent[playerid] = -1;

    Speedometer_Hide(playerid);
    Needs_HideBars(playerid);

    // Camera
    InterpolateCameraPos(playerid, 603.253234, -1.074449, 1002.081970, 606.906799, 2.143145, 1002.159118, 1000);
    InterpolateCameraLookAt(playerid, 608.203308, -0.976854, 1001.383850, 611.030334, -0.317962, 1000.766418, 1000);

    // Menu
    TuningMenu_Main(playerid);
    return 1;
}

Tuning_Back(playerid)
{
    Menu_Hide(playerid);

    if (Bit_Get(Player_Config(playerid), CONFIG_DISPLAY_SPEEDOMETER))
        Speedometer_Show(playerid);

    if (Bit_Get(Player_Config(playerid), CONFIG_DISPLAY_NEED_BARS))
        Needs_ShowBars(playerid);

    Player_SetPos(playerid, s_rgfPreviusTuningPos[playerid][0], s_rgfPreviusTuningPos[playerid][1], s_rgfPreviusTuningPos[playerid][2]);
    SetPlayerFacingAngle(playerid, s_rgfPreviusTuningPos[playerid][3]);
    SetPlayerInterior(playerid, s_rgiPreviusTuningInterior[playerid]);
    SetPlayerVirtualWorld(playerid, s_rgiPreviusTuningWorld[playerid]);

    new vehicle_id = GetPlayerVehicleID(playerid);
    if (IsValidVehicle(vehicle_id))
    {
        SetVehiclePos(vehicle_id, s_rgfPreviusTuningPos[playerid][0], s_rgfPreviusTuningPos[playerid][1], s_rgfPreviusTuningPos[playerid][2]);
        SetVehicleZAngle(vehicle_id, s_rgfPreviusTuningPos[playerid][3]);
        SetVehicleVirtualWorld(vehicle_id, s_rgiPreviusTuningWorld[playerid]);
        LinkVehicleToInterior(vehicle_id, s_rgiPreviusTuningInterior[playerid]);
        PutPlayerInVehicle(playerid, vehicle_id, 0);

        ChangeVehicleColor(vehicle_id, g_rgeVehicles[vehicle_id][e_iColorOne], g_rgeVehicles[vehicle_id][e_iColorTwo]);
    }

    TogglePlayerControllable(playerid, true);
    SetCameraBehindPlayer(playerid);
    return 1;
}

command tuning(playerid, const params[], "")
{
    Tuning_Open(playerid);
    return 1;
}

command tuningback(playerid, const params[], "")
{
    Tuning_Back(playerid);
    return 1;
}