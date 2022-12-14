#if defined _dealership_callbacks_
    #endinput
#endif
#define _dealership_callbacks_

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
    if (IsValidVehicle(vehicleid) && Vehicle_Type(vehicleid) == VEHICLE_TYPE_DEALERSHIP)
    {
        SetExclusiveBroadcast(true);
        BroadcastToPlayer(playerid);

        new Float:x, Float:y, Float:z, Float:ang;
        GetVehiclePos(vehicleid, x, y, z);
        GetVehicleZAngle(vehicleid, ang);
        
        SetVehiclePos(vehicleid, x, y, z);
        SetVehicleZAngle(vehicleid, ang);

        BroadcastToPlayer(playerid, 0);
        SetExclusiveBroadcast(false);
        
        return 0;
    }

    #if defined DS_OnUnoccupiedVehicleUpdate
        return DS_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnUnoccupiedVehicleUpdate
    #undef OnUnoccupiedVehicleUpdate
#else
    #define _ALS_OnUnoccupiedVehicleUpdate
#endif
#define OnUnoccupiedVehicleUpdate DS_OnUnoccupiedVehicleUpdate
#if defined DS_OnUnoccupiedVehicleUpdate
    forward DS_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z);
#endif

public OnScriptInit()
{
    CreateDynamicMapIcon(-1920.1965, 302.7697, 40.5643, 55, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(563.774475, -1273.510986, 16.867170, 55, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(2126.008544, -1115.513916, 25.176628, 55, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(1642.246582, 1796.102050, 10.820312, 55, -1, .worldid = 0, .interiorid = 0);
    CreateDynamicMapIcon(-1645.245361, 1217.047973, 6.732273, 55, -1, .worldid = 0, .interiorid = 0);

    for(new i; i != sizeof(g_rgeVehiclesForSale); ++i)
    {
        g_rgeVehiclesForSale[i][e_iVehicleID] = Vehicle_Create(
            g_rgeVehiclesForSale[i][e_iVehicleModelID],
            g_rgeVehiclesForSale[i][e_fVehicleX],
            g_rgeVehiclesForSale[i][e_fVehicleY],
            g_rgeVehiclesForSale[i][e_fVehicleZ],
            g_rgeVehiclesForSale[i][e_fVehicleAngle],
            g_rgeVehiclesForSale[i][e_iColor1],
            g_rgeVehiclesForSale[i][e_iColor2],
            1, .static_veh = true
        );
        Vehicle_Type(g_rgeVehiclesForSale[i][e_iVehicleID]) = VEHICLE_TYPE_DEALERSHIP;
        Vehicle_ToggleLock(g_rgeVehiclesForSale[i][e_iVehicleID]);

        format(
            HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH,
            "{CB3126}%s\n{DADADA}Precio: {64A752}$%s{DADADA}\n\nPresiona {CB3126}Y{DADADA} para comprar",
            g_rgeVehicleModelData[g_rgeVehiclesForSale[i][e_iVehicleModelID] - 400][e_szModelName],
            Format_Thousand(g_rgeVehicleModelData[g_rgeVehiclesForSale[i][e_iVehicleModelID] - 400][e_iPrice])
        );

        g_rgeVehiclesForSale[i][e_iVehicleLabel] = CreateDynamic3DTextLabel(HYAXE_UNSAFE_HUGE_STRING, 0xDADADAFF,
            g_rgeVehiclesForSale[i][e_fVehicleX],
            g_rgeVehiclesForSale[i][e_fVehicleY],
            g_rgeVehiclesForSale[i][e_fVehicleZ] + 2.0,
            10.0, .attachedvehicle = g_rgeVehiclesForSale[i][e_iVehicleID], .worldid = 0, .interiorid = 0
        );

        g_rgeVehicles[ g_rgeVehiclesForSale[i][e_iVehicleID] ][e_iSellIndex] = i;
    }

    #if defined CONC_OnScriptInit
        return CONC_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit CONC_OnScriptInit
#if defined CONC_OnScriptInit
    forward CONC_OnScriptInit();
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_YES) != 0 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        new vehicleid = INVALID_VEHICLE_ID;
        if (Bit_Get(Player_Config(playerid), CONFIG_ANDROID_MODE))
            vehicleid = GetPlayerNearestVehicle(playerid);
        else
            vehicleid = GetPlayerCameraTargetVehicle(playerid);
            
        if (IsValidVehicle(vehicleid))
        {
            if (g_rgeVehicles[vehicleid][e_iSellIndex] != -1)
            {
                static const vehicles_per_privilege_level[] = { 2, 3, 4, 8 };
                if (Iter_Count(PlayerVehicles[playerid]) >= vehicles_per_privilege_level[Player_VIP(playerid)])
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_Show(playerid, va_return("Solo puedes tener hasta %d vehículos. Dirígete a ~r~samp.hyaxe.com/store~w~ para adquirir VIP y tener más vehículos.", vehicles_per_privilege_level[Player_VIP(playerid)]), 10000);
                    return 1;
                }

                g_rgePlayerTempData[playerid][e_iPlayerBuyVehicleIndex] = g_rgeVehicles[vehicleid][e_iSellIndex];

                format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                    {DADADA}¿Quieres comprar un(a) {CB3126}%s{DADADA} a {64A752}$%s{DADADA}?\
                ",
                    g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_szModelName],
                    Format_Thousand(g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_iPrice])
                );
                Dialog_ShowCallback(playerid, using public _hydg@buy_vehicle<iiiis>, DIALOG_STYLE_MSGBOX, "{CB3126}Hyaxe{DADADA} - Comprar vehículo", HYAXE_UNSAFE_HUGE_STRING, "Comprar", "Cancelar");
            }
        }
    }

    #if defined CONC_OnPlayerKeyStateChange
        return CONC_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange CONC_OnPlayerKeyStateChange
#if defined CONC_OnPlayerKeyStateChange
    forward CONC_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

dialog buy_vehicle(playerid, dialogid, response, listitem, const inputtext[])
{
    if (response)
    {
        new
            modelid = g_rgeVehiclesForSale[ g_rgePlayerTempData[playerid][e_iPlayerBuyVehicleIndex]  ][e_iVehicleModelID] - 400,
            dealership = g_rgeVehiclesForSale[ g_rgePlayerTempData[playerid][e_iPlayerBuyVehicleIndex]  ][e_iDealership]
        ;

        if (Player_Money(playerid) < g_rgeVehicleModelData[modelid][e_iPrice])
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
            return 0;
        }

        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            Compraste un(a) %s $%s\
        ",
            g_rgeVehicleModelData[modelid][e_szModelName],
            Format_Thousand(g_rgeVehicleModelData[modelid][e_iPrice])
        );
        Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 5000, 0x64A752FF);

        new vehicleid = Vehicle_Create(
            modelid + 400,
            g_rgfDealershipPosition[dealership][0],
            g_rgfDealershipPosition[dealership][1],
            g_rgfDealershipPosition[dealership][2],
            g_rgfDealershipPosition[dealership][3],
            random(255), random(255), 0
        );
        Player_PutInVehicle(playerid, vehicleid);
        Player_RegisterVehicle(playerid, vehicleid);

        Player_AddXP(playerid, 500);
        PlayerPlaySound(playerid, SOUND_TRUMPET);
        Player_GiveMoney(playerid, -g_rgeVehicleModelData[modelid][e_iPrice]);

        DEBUG_PRINT("[vehicle] Buy vehicle, playerid = %d, vehicleid = %d, %s, %s (%d)", playerid, vehicleid, g_rgeVehicleModelData[modelid][e_szModelName], Vehicle_GetModelName(GetVehicleModel(vehicleid)), modelid + 400);
    }
    return 1;
}