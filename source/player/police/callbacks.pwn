#if defined _police_callbacks_
    #endinput
#endif
#define _police_callbacks_

static PoliceLocker_OnKeyPress(playerid)
{
    static const male_skins[] = { 280, 281, 265, 266, 267, 300, 301 };

    if(!Police_Rank(playerid))
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No eres policía");
        return 1;
    }

    if(Police_OnDuty(playerid))
    {
        Police_SendMessage(POLICE_RANK_OFFICER, 0x3A86FFFF, va_return("[Policía] ›{DADADA} %s oficial %s ahora está fuera de servicio.", (Player_Sex(playerid) == SEX_MALE ? "El" : "La"), Player_RPName(playerid)), 21, playerid);

        SetPlayerSkin(playerid, Player_Skin(playerid));
        ResetPlayerWeapons(playerid);
        Player_ClearWeaponsArray(playerid);
        Police_OnDuty(playerid) = false;

        Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "Saliste de tu jornada como policía");

        return 1;
    }

    if(Player_VIP(playerid) >= 2)
    {
        inline const Response(response, listitem, string:inputtext[])
        {
            #pragma unused inputtext

            if(response)
            {
                Police_OnDuty(playerid) = true;

                if(listitem == 1)
                {
                    SetPlayerSkin(playerid, 285);
                    Player_GiveWeapon(playerid, 3, false);  // Nightstick
                    Player_GiveWeapon(playerid, 24, false); // Desert Eagle
                    Player_GiveWeapon(playerid, 27, false); // Combat Shotgun

                    Police_SendMessage(POLICE_RANK_OFFICER, 0x3A86FFFF, va_return("[Policía] ›{DADADA} %s oficial %s ahora está de servicio como Operaciones Especiales.", (Player_Sex(playerid) == SEX_MALE ? "El" : "La"), Player_RPName(playerid)));
                }
                else
                {
                    SetPlayerSkin(playerid, (Player_Sex(playerid) == SEX_MALE ? (male_skins[random(sizeof(male_skins))]) : (306 + _:TryPercentage(50))));
                    Player_GiveWeapon(playerid, 3, false);  // Nightstick
                    Player_GiveWeapon(playerid, 24, false); // Desert Eagle
                    Player_GiveWeapon(playerid, 31, false); // M4

                    Police_SendMessage(POLICE_RANK_OFFICER, 0x3A86FFFF, va_return("[Policía] ›{DADADA} %s oficial %s ahora está de servicio como %s.", (Player_Sex(playerid) == SEX_MALE ? "El" : "La"), Player_RPName(playerid), Police_GetRankName(Police_Rank(playerid))));
                }

                SetPlayerArmedWeapon(playerid, 0);
            }
        }
        Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "{DADADA}Selección de {3A86FF}rango policial", va_return("{3A86FF}›{DADADA}%s\n{3A86FF}›{DADADA}Operaciones Especiales {CB3126}(VIP)", Police_GetRankName(Police_Rank(playerid))), "Seleccionar", "Cancelar");
    }
    else
    {
        Police_OnDuty(playerid) = true;
        SetPlayerSkin(playerid, (Player_Sex(playerid) == SEX_MALE ? (male_skins[random(sizeof(male_skins))]) : (306 + _:TryPercentage(50))));
        Player_GiveWeapon(playerid, 3, false);  // Nightstick
        Player_GiveWeapon(playerid, 24, false); // Desert Eagle
        Player_GiveWeapon(playerid, 31, false); // M4
        SetPlayerArmedWeapon(playerid, 0);

        Police_SendMessage(POLICE_RANK_OFFICER, 0x3A86FFFF, va_return("[Policía] ›{DADADA} %s oficial %s ahora está de servicio como %s.", (Player_Sex(playerid) == SEX_MALE ? "El" : "La"), Player_RPName(playerid), Police_GetRankName(Police_Rank(playerid))));
    }

    return 1;
}

public OnScriptInit()
{
    g_iArrestCheckpoint = CreateDynamicCP(1568.1835, -1695.7062, 5.8906, 5.0, 0, 0, .streamdistance = 5000.0);

    Key_Alert(1569.2075, -1688.7084, 20.6049, 1.0, KEYNAME_YES, .callback_on_press = __addressof(PoliceLocker_OnKeyPress));    
    CreateDynamicPickup(1275, 1, 1569.2075, -1688.7084, 20.6049, 0, 0);
    CreateDynamicPickup(2044, 1, 1568.6139,-1694.9478, 20.6049, 0, 0);

    EnterExit_Create(19902, "{ED2B2B}LSPD", "{DADADA}Salida", 1554.9965, -1675.5953, 16.1953, 82.5943, 0, 0, 1560.6276, -1675.4996, 20.5919, 271.2696, 0, 0);
    CreateDynamicMapIcon(1554.9965, -1675.5953, 16.1953, 30, -1, 0, 0);

    for(new i = sizeof(g_rgeCopCars) - 1; i != -1; --i)
    {
        new vehicleid = Vehicle_Create(g_rgeCopCars[i][e_iModel], g_rgeCopCars[i][e_fPosX], g_rgeCopCars[i][e_fPosY], g_rgeCopCars[i][e_fPosZ], g_rgeCopCars[i][e_fAngle], 0, 1, 600, .addsiren = true);
        Vehicle_Type(vehicleid) = VEHICLE_TYPE_POLICE;
    }

    #if defined POLICE_OnScriptInit
        return POLICE_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit POLICE_OnScriptInit
#if defined POLICE_OnScriptInit
    forward POLICE_OnScriptInit();
#endif

public OnPlayerAuthenticate(playerid)
{
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "SELECT `RANK` FROM `POLICE_OFFICERS` WHERE `ACCOUNT_ID` = %i LIMIT 1;", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "POLICE_UserLoaded", "i", playerid);

    #if defined POLICE_OnPlayerAuthenticate
        return POLICE_OnPlayerAuthenticate(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerAuthenticate
    #undef OnPlayerAuthenticate
#else
    #define _ALS_OnPlayerAuthenticate
#endif
#define OnPlayerAuthenticate POLICE_OnPlayerAuthenticate
#if defined POLICE_OnPlayerAuthenticate
    forward POLICE_OnPlayerAuthenticate(playerid);
#endif

public POLICE_UserLoaded(playerid)
{
    new rowc;
    cache_get_row_count(rowc);

    if(rowc)
    {
        new rank;
        cache_get_value_name_int(0, "RANK", rank);
        if(rank > _:POLICE_RANK_NONE)
        {
            Police_Rank(playerid) = rank;
            Iter_Add(Police, playerid);
        }
    }

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    Police_OnDuty(playerid) = false;
    Police_Rank(playerid) = POLICE_RANK_NONE;

    if(Iter_Contains(Police, playerid))
        Iter_Remove(Police, playerid);

    #if defined POLICE_OnPlayerDisconnect
        return POLICE_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect POLICE_OnPlayerDisconnect
#if defined POLICE_OnPlayerDisconnect
    forward POLICE_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(Vehicle_Type(vehicleid) == VEHICLE_TYPE_POLICE && !Police_OnDuty(playerid))
    {
        ClearAnimations(playerid, 1);

        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPos(playerid, x, y, z);
        TogglePlayerControllable(playerid, false);

        Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Necesitas estar de servicio como policía");

        inline const Due()
        {
            TogglePlayerControllable(playerid, true);
        }
        Timer_CreateCallback(using inline Due, 2000, 1);

        return 1;
    }

    #if defined POLICE_OnPlayerEnterVehicle
        return POLICE_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterVehicle
    #undef OnPlayerEnterVehicle
#else
    #define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle POLICE_OnPlayerEnterVehicle
#if defined POLICE_OnPlayerEnterVehicle
    forward POLICE_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
#endif

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(IsValidVehicle(vehicleid))
        {
            if(Vehicle_Type(vehicleid) == VEHICLE_TYPE_POLICE && !Police_OnDuty(playerid))
            {
                Anticheat_Trigger(playerid, CHEAT_CARJACK, 2);
                return 1;
            }
        }
    }

    #if defined POLICE_OnPlayerStateChange
        return POLICE_OnPlayerStateChange(playerid, newstate, oldstate);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange POLICE_OnPlayerStateChange
#if defined POLICE_OnPlayerStateChange
    forward POLICE_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

forward ARREST_ReleaseFromPrison(playerid);
public ARREST_ReleaseFromPrison(playerid)
{
    Bit_Set(Player_Flags(playerid), PFLAG_IN_JAIL, false);
    Player_Data(playerid, e_iJailTime) = 0;

    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    SetPlayerPos(playerid, 1561.5903, -1669.4990, 20.6049);
    SetPlayerFacingAngle(playerid, 193.2624);

    ClearAnimations(playerid);

    Notification_Show(playerid, "Fuiste liberado de prisión.", 5000);

    mysql_format(g_hDatabase, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `JAIL_TIME` = 0 WHERE `ID` = %d;", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, YSI_UNSAFE_HUGE_STRING);
    
    return 1;
}