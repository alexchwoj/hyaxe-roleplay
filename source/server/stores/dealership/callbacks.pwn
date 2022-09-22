#if defined _dealership_callbacks_
    #endinput
#endif
#define _dealership_callbacks_

public OnGameModeInit()
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
            60
        );
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

    #if defined CONC_OnGameModeInit
        return CONC_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit CONC_OnGameModeInit
#if defined CONC_OnGameModeInit
    forward CONC_OnGameModeInit();
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_YES) != 0)
    {
        new vehicleid = (IsPlayerInAnyVehicle(playerid) ? GetPlayerVehicleID(playerid) : GetPlayerCameraTargetVehicle(playerid));
        if (vehicleid != INVALID_VEHICLE_ID)
        {
            if (g_rgeVehicles[vehicleid][e_iSellIndex] != -1)
            {
                if (Iter_Count(PlayerVehicles[playerid]) >= 3)
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Solo puedes tener hasta 3 vehículos.");
                }

                g_rgePlayerTempData[playerid][e_iPlayerBuyVehicleIndex] = g_rgeVehicles[vehicleid][e_iSellIndex];

                format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
                    {DADADA}¿Quieres comprar un(a) {CB3126}%s{DADADA} a {64A752}$%s{DADADA}?\
                ",
                    g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_szModelName],
                    Format_Thousand(g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_iPrice])
                );
                Dialog_Show(playerid, "buy_vehicle", DIALOG_STYLE_MSGBOX, "{CB3126}Hyaxe{DADADA} - Comprar vehículo", HYAXE_UNSAFE_HUGE_STRING, "Comprar", "Cancelar");
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

dialog buy_vehicle(playerid, response, listitem, const inputtext[])
{
    if (response)
    {
        new
            modelid = g_rgeVehiclesForSale[ g_rgePlayerTempData[playerid][e_iPlayerBuyVehicleIndex]  ][e_iVehicleModelID],
            dealership = g_rgeVehiclesForSale[ g_rgePlayerTempData[playerid][e_iPlayerBuyVehicleIndex]  ][e_iDealership]
        ;

        if (Player_Money(playerid) < g_rgeVehicleModelData[modelid - 400][e_iPrice])
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
            return 0;
        }

        format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
            Compraste un(a) %s $%s\
        ",
            g_rgeVehicleModelData[modelid - 400][e_szModelName],
            Format_Thousand(g_rgeVehicleModelData[modelid - 400][e_iPrice])
        );
        Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 5000, 0x64A752FF);

        new vehicleid = Vehicle_Create(
            modelid,
            g_rgfDealershipPosition[dealership][0],
            g_rgfDealershipPosition[dealership][1],
            g_rgfDealershipPosition[dealership][2],
            g_rgfDealershipPosition[dealership][3],
            random(255), random(255), 0
        );
        Player_PutInVehicle(playerid, vehicleid);
        Player_RegisterVehicle(playerid, vehicleid);

        Player_AddXP(playerid, 500);
        PlayerPlaySound(playerid, 31205);
        Player_GiveMoney(playerid, -g_rgeVehicleModelData[modelid - 400][e_iPrice]);
    }
    return 1;
}