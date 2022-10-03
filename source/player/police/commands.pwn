#if defined _police_commands_
    #endinput
#endif
#define _police_commands_

command policias(playerid, const params[], "Muestra el panel de policías")
{
    if(!Player_IsPolice(playerid) && Player_AdminLevel(playerid) < RANK_LEVEL_ADMINISTRATOR)
    {
        SendClientMessagef(playerid, 0x3A86FFFF, "{DADADA}Solo la {3A86FF}policía{DADADA} puede acceder al panel de administración policial.");
        return 1;
    }

    MemSet(g_rgszSelectedOfficer[playerid], 0);

    inline const QueryDone()
    {
        new rowc;
        cache_get_row_count(rowc);

        if(!rowc)
        {
            SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} No hay ningún policía.");
            return 1;
        }

        strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Oficial\t{DADADA}Rango\t{DADADA}Reclutado por\t{DADADA}Última conexión{DADADA}\n");

        new line[256];
        for(new i; i < rowc; ++i)
        {
            new officer_id, officer_name[25], rank, recruiter_id, recruiter_name[25], officer_current_playerid, last_connection[24];
            cache_get_value_name_int(i, "ACCOUNT_ID", officer_id);
            cache_get_value_name(i, "OFFICER_NAME", officer_name);
            cache_get_value_name_int(i, "RANK", rank);
            cache_get_value_name_int(i, "RECRUITED_BY", recruiter_id);

            new bool:isnt_recruited;
            cache_is_value_name_null(i, "RECRUITER_NAME", isnt_recruited);
            if(isnt_recruited)
            {
                strcat(recruiter_name, "Desconocido");
                recruiter_id = 0;
            }
            else
            {
                cache_get_value_name(i, "RECRUITER_NAME", recruiter_name);
            }

            cache_get_value_name_int(i, "CURRENT_PLAYERID", officer_current_playerid);
            cache_get_value_name(i, "LAST_CONNECTION", last_connection);
            
            format(line, sizeof(line), "{DADADA}%s ({3A86FF}%i{DADADA})\t{DADADA}%s\t{DADADA}%s ({3A86FF}%i{DADADA})\t{%x}%s\n", officer_name, officer_id, Police_GetRankName(rank), recruiter_name, recruiter_id, (officer_current_playerid == -1 ? 0xDADADA : 0x64A752), (officer_current_playerid == -1 ? last_connection : "En línea"));
            strcat(HYAXE_UNSAFE_HUGE_STRING, line);
        }

        Dialog_ShowCallback(playerid, using public _hydg@police_manage<iiiis>, DIALOG_STYLE_TABLIST_HEADERS, "{3A86FF}Hyaxe {DADADA}- Policía", HYAXE_UNSAFE_HUGE_STRING, "Seleccionar", "Salir");
    }
    MySQL_TQueryInline(g_hDatabase, using inline QueryDone, 
        "\
            SELECT `POLICE_OFFICERS`.*, `RECRUITEE`.`NAME` AS `OFFICER_NAME`, `RECRUITEE`.`CURRENT_PLAYERID`, `RECRUITER`.`NAME` AS `RECRUITER_NAME`, MAX(`CONNECTION_LOG`.`DATE`) AS `LAST_CONNECTION` \
            FROM `POLICE_OFFICERS` \
                LEFT JOIN `ACCOUNT` RECRUITER ON \
                    `POLICE_OFFICERS`.`RECRUITED_BY` = `RECRUITER`.`ID` \
                LEFT JOIN `ACCOUNT` RECRUITEE ON \
                    `POLICE_OFFICERS`.`ACCOUNT_ID` = `RECRUITEE`.`ID` \
                INNER JOIN `CONNECTION_LOG` \
                    ON `POLICE_OFFICERS`.`ACCOUNT_ID` = `CONNECTION_LOG`.`ACCOUNT_ID` \
            GROUP BY `POLICE_OFFICERS`.`ACCOUNT_ID` \
            ORDER BY `POLICE_OFFICERS`.`RANK` DESC;\
        "
    );

    return 1;
}

dialog police_manage(playerid, dialogid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    if(Police_Rank(playerid) < _:POLICE_RANK_COMMISSIONER && Player_AdminLevel(playerid) < RANK_LEVEL_ADMINISTRATOR)
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Solo los comisarios pueden hacer esto");
        return 1;
    }

    if(sscanf(inputtext, "s[24]P<()>{s[2]}i", g_rgszSelectedOfficer[playerid], g_rgszSelectedOfficer[playerid][25]))
        return 1;

    g_rgszSelectedOfficer[playerid][24] = '\0';

    Dialog_ShowCallback(playerid, using public _hydg@police_manage_officer<iiiis>, DIALOG_STYLE_LIST, va_return("Opciones para {3A86FF}%s", g_rgszSelectedOfficer[playerid]), "{DADADA}Ascender o descender\n{A83225}Expulsar", "Seleccionar", "Atrás");

    return 1;
}

dialog police_manage_officer(playerid, dialogid, response, listitem, inputtext[])
{
    if(!response)
    {
        PC_EmulateCommand(playerid, "/policias");
        return 1;
    }

    switch(listitem)
    {
        case 0: // Ascender o descender
        {
            HYAXE_UNSAFE_HUGE_STRING[0] = '\0';
            
            new line[64];
            for(new i = sizeof(g_rgszPoliceRankNames) - 2; i != 0; --i)
            {
                format(line, sizeof(line), "{3A86FF}%2i.{DADADA} %s\n", i, g_rgszPoliceRankNames[i]);
                strcat(HYAXE_UNSAFE_HUGE_STRING, line);
            }

            format(line, sizeof(line), "Selecciona el nuevo rango de {3A86FF}%s", g_rgszSelectedOfficer[playerid]);
            Dialog_ShowCallback(playerid, using public _hydg@police_change_rank<iiiis>, DIALOG_STYLE_LIST, line, HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Atrás");
        }
        case 1: // Expulsar
        {

        }
    }

    return 1;
}

dialog police_change_rank(playerid, dialogid, response, listitem, inputtext[])
{
    if(response)
    {
        new new_rank = _:POLICE_RANK_GEN_COMMISSIONER - listitem;
        if(new_rank > Police_Rank(playerid))
        {
            Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Debes asignar un rango menor o igual al tuyo");
            
            HYAXE_UNSAFE_HUGE_STRING[0] = '\0';
            
            new line[64];
            for(new i = sizeof(g_rgszPoliceRankNames) - 2; i != 0; --i)
            {
                format(line, sizeof(line), "{3A86FF}%2i.{DADADA} %s\n", i, g_rgszPoliceRankNames[i]);
                strcat(HYAXE_UNSAFE_HUGE_STRING, line);
            }

            format(line, sizeof(line), "Selecciona el nuevo rango de {3A86FF}%s", g_rgszSelectedOfficer[playerid]);
            Dialog_ShowCallback(playerid, using public _hydg@police_change_rank<iiiis>, DIALOG_STYLE_LIST, line, HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Atrás");
            
            return 1;
        }

        mysql_tquery(g_hDatabase, va_return("UPDATE `POLICE_OFFICERS` SET `RANK` = %i WHERE `ACCOUNT_ID` = %i;", new_rank, g_rgszSelectedOfficer[playerid][25]));
        
        new bool:reported = false;
        
        foreach(new i : LoggedIn)
        {
            if(g_rgszSelectedOfficer[playerid][25] == Player_AccountID(i))
            {
                if(Police_Rank(i) != new_rank)
                {
                    new const bool:is_lower = (Police_Rank(i) > new_rank);
                    Police_Rank(i) = new_rank;

                    new message[40];
                    format(message, sizeof(message), "Has sido %s a %s.", (is_lower ? "descendido" : "ascendido"), Police_GetRankName(new_rank));
                    Notification_Show(i, message, 10000, 0x3A86FFFF);
                    Police_SendMessage(POLICE_RANK_NONE, 0x3A86FFFF, va_return("[Policía] ›{DADADA} %s ahora es {3A86FF}%s{DADADA}.", Player_RPName(i), Police_GetRankName(new_rank)));
                }

                reported = true;

                break;
            }
        }

        if(!reported)
        {
            Police_SendMessage(POLICE_RANK_NONE, 0x3A86FFFF, va_return("[Policía] ›{DADADA} %s ahora es {415BA2}%s{DADADA}.", g_rgszSelectedOfficer[playerid], g_rgszPoliceRankNames[new_rank]));
        }
    }

    PC_EmulateCommand(playerid, "/policias");
    return 1;
}

command cargos(playerid, const params[], "Dale cargos a un jugador")
{
    if(!Police_OnDuty(playerid))
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No estas de servicio como policía");
        return 1;
    }

    extract params -> new player:target, charges; else {
        SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} USO: {3A86FF}/cargos{DADADA} <jugador> <cantidad>");
        return 1;
    }

    if(!IsPlayerConnected(target))
    {
        SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} Jugador inválido");
        return 1;
    }

    if(target == playerid)
    {
        SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} No puedes darte cargos a ti mismo.");
        return 1;
    }

    if(Police_OnDuty(target))
    {
        SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} No puedes darle cargos a un policía en servicio.");
        return 1;
    }

    if(Player_WantedLevel(target) == charges)
    {
        SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} El jugador ya tiene esa cantidad de cargos.");
        return 1;
    }

    if(!charges && Player_WantedLevel(target))
    {
        Police_SendMessage(POLICE_RANK_OFFICER, 0xED2B2BFF, 
            va_return(
                "[Arresto] ›{DADADA} %s oficial %s canceló la orden de arresto contra {ED2B2B}%s{DADADA}.", 
                (Player_Sex(playerid) == SEX_MALE ? "El" : "La"), Player_RPName(playerid), Player_RPName(target)
            ),
        10, target);
    }
    else if(!Player_WantedLevel(target))
    {
        Police_SendMessage(POLICE_RANK_OFFICER, 0xED2B2BFF, 
            va_return(
                "[Arresto] ›{DADADA} %s oficial %s puso una orden de arresto de nivel %d contra {ED2B2B}%s{DADADA}.", 
                (Player_Sex(playerid) == SEX_MALE ? "El" : "La"), Player_RPName(playerid), charges, Player_RPName(target)
            ),
        10, target);
    }
    else if(Player_WantedLevel(target) > charges)
    {
        Police_SendMessage(POLICE_RANK_OFFICER, 0xED2B2BFF, 
            va_return(
                "[Arresto] ›{DADADA} %s oficial %s aumentó el nivel de la orden de arresto contra {ED2B2B}%s{DADADA} a nivel %d.", 
                (Player_Sex(playerid) == SEX_MALE ? "El" : "La"), Player_RPName(playerid), Player_RPName(target), charges
            ),
        10, target);
    }
    else
    {
        Police_SendMessage(POLICE_RANK_OFFICER, 0xED2B2BFF, 
            va_return(
                "[Arresto] ›{DADADA} %s oficial %s disminuyó el nivel de la orden de arresto contra {ED2B2B}%s{DADADA} a nivel %d.", 
                (Player_Sex(playerid) == SEX_MALE ? "El" : "La"), Player_RPName(playerid), Player_RPName(target), charges
            ),
        10, target);
    }

    Player_SetWantedLevel(target, charges);

    return 1;
}

command reclutar(playerid, const params[], "Recluta a alguien como policía")
{
    if(Police_Rank(playerid) < _:POLICE_RANK_COMMISSIONER && Player_AdminLevel(playerid) < RANK_LEVEL_ADMINISTRATOR)
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No tienes permiso para hacer esto");
        return 1;
    }

    extract params -> new player:target; else {
        SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} USO: {3A86FF}/reclutar{DADADA} <jugador>");
        return 1;
    }

    if(!IsPlayerConnected(target))
    {
        SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} Jugador inválido.");
        return 1;
    }

    if(Player_IsPolice(target))
    {
        SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} Este jugador ya es policía.");
        return 1;
    }

    inline const Response(response, listitem, string:inputtext[])
    {
        #pragma unused listitem, inputtext

        if(!response)
        {
            SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} %s rechazó unirse a LSPD.", Player_RPName(target));
            return 1;
        }

        Police_Rank(target) = POLICE_RANK_OFFICER;
        Iter_Add(Police, target);

        mysql_format(g_hDatabase, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "INSERT INTO `POLICE_OFFICERS` (`ACCOUNT_ID`, `RECRUITED_BY`) VALUES (%d, %d);", Player_AccountID(target), Player_AccountID(playerid));
        mysql_tquery(g_hDatabase, YSI_UNSAFE_HUGE_STRING);

        new message[144];
        format(message, sizeof(message), 
            "[Policía] ›{DADADA} %s %s se unió a LSPD con el rango de %s.",
            (Player_Sex(target) == SEX_MALE ? "El jugador" : "La jugadora"), Player_RPName(target), Police_GetRankName(POLICE_RANK_OFFICER)
        );

        Police_OnDuty(target) = true;
        Police_SendMessage(POLICE_RANK_OFFICER, 0x3A86FFFF, message);
        Police_OnDuty(target) = false;

        if(!Police_OnDuty(playerid))
            SendClientMessage(playerid, 0x3A86FFFF, message);
    }
    Dialog_ShowCallback(target, using inline Response, DIALOG_STYLE_MSGBOX, "{3A86FF}Hyaxe{DADADA} - Policía", va_return("{3A86FF}%s{DADADA} ofrecio unirte a LSPD con el rango de %s.", Player_RPName(playerid), Police_GetRankName(POLICE_RANK_OFFICER)), "Aceptar", "Cancelar");

    SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} Invitación enviada.");
    return 1;
}

static
    s_rgiPoliceArrestingPlayer[MAX_PLAYERS] = { INVALID_PLAYER_ID, ... };

command arrestar(playerid, const params[], "Arresta a un jugador")
{
    new target = GetPlayerCameraTargetPlayer(playerid);
    if(!IsPlayerConnected(target))
    {
        SendClientMessage(playerid, 0x3A86FFFF, "›{DADADA} Necesitas estar viendo a un jugador para arrestarlo.");
        return 1;
    }

    if(!Player_WantedLevel(target))
    {
        SendClientMessagef(playerid, 0x3A86FFFF, "›{DADADA} %s no tiene nivel de búsqueda.", Player_Sex(target) == SEX_MALE ? "Este jugador" : "Esta jugadora");
        return 1;
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(target, x, y, z);
    if(!IsPlayerInRangeOfPoint(playerid, 2.0, x, y, z))
    {
        SendClientMessagef(playerid, 0x3A86FFFF, "›{DADADA} Necesitas estar más cerca de%s", (Player_Sex(target) == SEX_MALE ? "l jugador" : " la jugadora"));
        return 1;
    }

    Player_RemoveAllWeapons(target);

    if(Bit_Get(Player_Flags(target), PFLAG_INJURED))
    {
        Player_Revive(target);
    }

    Bit_Set(Player_Flags(target), PFLAG_ARRESTED, true);
    s_rgiPoliceArrestingPlayer[playerid] = target;

    TogglePlayerControllable(target, false);
    SetPlayerSpecialAction(target, SPECIAL_ACTION_CUFFED);

    Notification_Show(playerid, va_return("Arrestaste a %s. Sube a una patrulla para trasladarl%c.", Player_RPName(target), (Player_Sex(target) == SEX_MALE ? 'o' : 'a')), 5000, 0x3A86FFFF);
    Police_SendMessage(POLICE_RANK_OFFICER, 0xED2B2BFF, va_return("[Policía] {DADADA}%s {ED2B2B}›{DADADA} Sospechos%c %s arrestad%c.", Player_RPName(playerid), (Player_Sex(target) == SEX_MALE ? 'o' : 'a'), Player_RPName(target), (Player_Sex(target) == SEX_MALE ? 'o' : 'a')), 12, target);

    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER && s_rgiPoliceArrestingPlayer[playerid] != INVALID_PLAYER_ID)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(IsValidVehicle(vehicleid) && Vehicle_Type(vehicleid) == VEHICLE_TYPE_POLICE)
        {
            new occupied_seats = 0;
            foreach(new i : VehicleOccupant(vehicleid, .includeDriver = false))
            {
                occupied_seats = (1 << GetPlayerVehicleSeat(i));
            }

            if(occupied_seats >= 0b1100)
            {
                Notification_Show(playerid, "No se pudo subir al sospechoso a la patrulla. Libera uno de los asientos traseros.", 5000);
            }
            else
            {
                occupied_seats |= 0b11;
                Cell_GetLowestBlank(occupied_seats);
                PutPlayerInVehicle(s_rgiPoliceArrestingPlayer[playerid], GetPlayerVehicleID(playerid), Cell_GetLowestBlank(occupied_seats));
                Notification_Show(playerid, "Lleva al sospechoso a la comisaría para procesarlo.", 5000);
                TogglePlayerDynamicCP(playerid, g_iArrestCheckpoint, true);
            }
        }
    }

    #if defined ARREST_OnPlayerStateChange
        return ARREST_OnPlayerStateChange(playerid, newstate, oldstate);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerStateChange
    #undef OnPlayerStateChange
#else
    #define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange ARREST_OnPlayerStateChange
#if defined ARREST_OnPlayerStateChange
    forward ARREST_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    if(checkpointid == g_iArrestCheckpoint)
    {
        TogglePlayerDynamicCP(playerid, g_iArrestCheckpoint, false);

        new target = s_rgiPoliceArrestingPlayer[playerid];
        s_rgiPoliceArrestingPlayer[playerid] = INVALID_PLAYER_ID;
        
        Bit_Set(Player_Flags(target), PFLAG_IN_JAIL, true);
        RemovePlayerFromVehicle(target);
        TogglePlayerControllable(target, true);
        SetPlayerSpecialAction(target, SPECIAL_ACTION_NONE);

        Player_GiveMoney(playerid, 500);
        Notification_Show(playerid, va_return("Arrestaste a %s y se te dio un bono de ~g~500$", Player_RPName(target)), 5000);

        new jailtime = (Player_WantedLevel(target) * 2) * 60;
        Player_Data(target, e_iJailTime) = gettime() + jailtime;
        Player_Timer(target, e_iPlayerJailTimer) = SetTimerEx("ARREST_ReleaseFromPrison", jailtime * 1000, false, "i", target);

        new pos = random(sizeof(g_rgfJailPositions));
        SetPlayerVirtualWorld(target, 0);
        SetPlayerInterior(target, 0);
        SetPlayerPos(target, g_rgfJailPositions[pos][0], g_rgfJailPositions[pos][1], g_rgfJailPositions[pos][2]);
        Notification_Show(target, va_return("Estás en prisión y cumples una condena de ~r~%d minutos~w~. Para ver el tiempo restante usa ~r~/tiempo~w~.", Player_WantedLevel(target) * 2), 10000);
        
        mysql_format(g_hDatabase, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `WANTED_LEVEL` = 0, `JAIL_TIME` = %d WHERE `ID` = %d;", jailtime, Player_AccountID(target));
        mysql_tquery(g_hDatabase, YSI_UNSAFE_HUGE_STRING);
    }

    #if defined ARREST_OnPlayerEnterDynamicCP
        return ARREST_OnPlayerEnterDynamicCP(playerid, checkpointid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicCP
    #undef OnPlayerEnterDynamicCP
#else
    #define _ALS_OnPlayerEnterDynamicCP
#endif
#define OnPlayerEnterDynamicCP ARREST_OnPlayerEnterDynamicCP
#if defined ARREST_OnPlayerEnterDynamicCP
    forward ARREST_OnPlayerEnterDynamicCP(playerid, checkpointid);
#endif

public OnPlayerDisconnect(playerid, reason)
{
    if(Bit_Get(Player_Flags(playerid), PFLAG_ARRESTED))
    {
        foreach(new i : Police)
        {
            if(s_rgiPoliceArrestingPlayer[i] == playerid)
            {
                Notification_Show(i, "El jugador al que arrestabas se desconecto. Se te dio una bonificación de ~r~500$~w~ por su arresto.", 10000);
                s_rgiPoliceArrestingPlayer[i] = INVALID_PLAYER_ID;
                TogglePlayerDynamicCP(playerid, g_iArrestCheckpoint, false);
                break;
            }
        }
    }

    #if defined ARREST_OnPlayerDisconnect
        return ARREST_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect ARREST_OnPlayerDisconnect
#if defined ARREST_OnPlayerDisconnect
    forward ARREST_OnPlayerDisconnect(playerid, reason);
#endif
