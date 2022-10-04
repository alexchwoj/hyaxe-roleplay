#if defined _townhall_callbacks_
    #endinput
#endif
#define _townhall_callbacks_

static SellVeh_OnPress(playerid)
{
    if(!Iter_Count(PlayerVehicles[playerid]))
        return Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No tienes vehículos");

    StrCpy(YSI_UNSAFE_HUGE_STRING, "{CB3126}Vehículo\t{CB3126}Matrícula\n", YSI_UNSAFE_HUGE_LENGTH);

    new vehicles[9], tmp;

    foreach(new i : PlayerVehicles[playerid])
    {
        new plate[32];
        GetVehicleNumberPlate(i, plate);
        strcat(YSI_UNSAFE_HUGE_STRING, va_return("{DADADA}%s\t{DADADA}%s\n", Vehicle_GetModelName(GetVehicleModel(i)), plate), YSI_UNSAFE_HUGE_LENGTH);
        vehicles[tmp++] = i;
    }

    inline const Response(response, listitem, string:inputtext[])
    {
        #pragma unused inputtext
        
        if(!response)
            return 1;

        new vehicleid = vehicles[listitem];
        new model = GetVehicleModel(vehicleid);

        new pay = Vehicle_GetModelPrice(model) - Percent:50;

        inline const SellResponse(r, l, string:it[])
        {
            #pragma unused r, l, it

            if(!r)
            {
                SellVeh_OnPress(playerid);
                return 1;
            }

            Notification_Show(playerid, va_return("Vendiste tu %s por %d$", Vehicle_GetModelName(model), pay), 5000);
            Player_GiveMoney(playerid, pay);
            Iter_Remove(PlayerVehicles[playerid], vehicleid);

            mysql_format(g_hDatabase, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "DELETE FROM `PLAYER_VEHICLES` WHERE `VEHICLE_ID` = %d;", g_rgeVehicles[vehicleid][e_iVehicleDbId]);
            mysql_tquery(g_hDatabase, YSI_UNSAFE_HUGE_STRING);

            Vehicle_Destroy(vehicleid);
        }
        Dialog_ShowCallback(playerid, using inline SellResponse, DIALOG_STYLE_MSGBOX, va_return("Vender tu {CB3126}%s", Vehicle_GetModelName(model)), va_return("{DADADA}El gobierno está dispuesto a darte {64A752}%d${DADADA} por tu {CB3126}%s{DADADA}.", pay, Vehicle_GetModelName(model)), "Vender", "Atrás");
    }
    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST_HEADERS, "Vender un {CB3126}vehículo", YSI_UNSAFE_HUGE_STRING, "Continuar", "Cancelar");
    
    return 1;
}

public OnScriptInit()
{
    CreateDynamic3DTextLabel("Vender un vehículo", 0xCB3126FF, -2090.4336, 446.9664, 2982.7620, 15.0, .testlos = 1, .worldid = 0, .interiorid = 0);
    Key_Alert(-2090.4336, 446.9664, 2982.7620, 1.5, KEYNAME_YES, .world = 0, .interior = 0, .callback_on_press = __addressof(SellVeh_OnPress));

    EnterExit_Create(19902, "{CB3126}Ayuntamiento", "{DADADA}Salida", 1480.9773, -1771.9276, 18.7958, 357.3669, 0, 0, -2058.3188, 448.1226, 2975.7590, 90.6303, 0, 0);
    CreateDynamicMapIcon(1480.9773, -1771.9276, 18.7958, 8, -1, .worldid = 0, .interiorid = 0);

    #if defined THALL_OnScriptInit
        return THALL_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit THALL_OnScriptInit
#if defined THALL_OnScriptInit
    forward THALL_OnScriptInit();
#endif
