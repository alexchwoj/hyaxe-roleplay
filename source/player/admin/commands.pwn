#if defined _admin_commands_
    #endinput
#endif
#define _admin_commands_

command ban(playerid, const params[], "Veta a un jugador")
{
    new banned, time, reason[51];
    if(sscanf(params, "rI(-1)S(No especificada)[50]", banned, time, reason))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/ban {DADADA}<jugador> {969696}[tiempo en segundos = -1 (permanente)] [razón = \"No especificada\"]");
        return 1;
    }

    if(banned == playerid)
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} No puedes vetarte a ti mismo.");
        return 1;
    }

    if(Player_AdminLevel(banned) > Player_AdminLevel(playerid))
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} No puedes vetar a alguien superior a ti.");
        return 1;
    }

    Player_Ban(banned, playerid, reason, time);

    Admins_SendMessage(RANK_LEVEL_HELPER, 0x415BA2FF, 
        va_return("{DADADA}%s {415BA2}%s{DADADA} ({415BA2}%i{DADADA}-{415BA2}%i{DADADA}) fue vetado por %s %s {415BA2}%s{DADADA}.", 
            (Player_Sex(banned) == SEX_MALE ? "El jugador" : "La jugadora"), Player_RPName(banned), banned, Player_AccountID(banned), (Player_Sex(playerid) == SEX_MALE ? "el" : "la"), Player_GetRankName(playerid), Player_RPName(playerid)
        )
    );

    return 1;
}
alias:ban("vetar", "banear")
flags:ban(CMD_FLAG<RANK_LEVEL_MODERATOR> | CMD_DONT_LOG_COMMAND)

command kick(playerid, const params[], "Expulsa a un jugador")
{
    new kicked, reason[51];
    if(sscanf(params, "rS(No especificada)[50]", kicked, reason))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/kick {DADADA}<jugador> {969696}[razón = \"No especificada\"]");
        return 1;
    }

    if(kicked == playerid)
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} No puedes expulsarte a ti mismo.");
        return 1;
    }

    if(Player_AdminLevel(kicked) > Player_AdminLevel(playerid))
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} No puedes expulsar a alguien superior a ti.");
        return 1;
    }

    new year, month, day, hour, minute, second;
    gettime(hour, minute, second);
    getdate(year, month, day);

    Dialog_ShowCallback(kicked, using public _hydg@kick<iiiis>, DIALOG_STYLE_MSGBOX, "{CB3126}Hyaxe {DADADA}- Expulsión",
        va_return(
            "{DADADA}Fuiste expulsad%c del servidor.\n\n\
            {CB3126}Razón de la expulsión\n\
                \t{DADADA}%s\n\n\
            {CB3126}Administrador encargado\n\
                \t{DADADA}%s ({CB3126}%i{DADADA})\n\n\
            {CB3126}Fecha\n\
                \t{DADADA}%i/%i/%i %i:%i:%i\
        ",
            (Player_Sex(kicked) == SEX_MALE ? 'o' : 'a'), reason, Player_RPName(playerid), Player_AccountID(playerid),
            day, month, year, hour, minute, second
        ),
        "Salir"
    );

    KickTimed(kicked, 500);

    Admins_SendMessage(RANK_LEVEL_HELPER, 0x415BA2FF, 
        va_return("› {DADADA}%s {415BA2}%s {DADADA}(ID {415BA2}%i{DADADA}) fue expulsad%c por %s %s {415BA2}%s{DADADA}.", 
            (Player_Sex(kicked) == SEX_MALE ? "El jugador" : "La jugadora"), Player_RPName(kicked), kicked, (Player_Sex(kicked) == SEX_MALE ? 'o' : 'a'), (Player_Sex(playerid) == SEX_MALE ? "el" : "la"), Player_GetRankName(playerid), Player_RPName(playerid)
        )
    );

    return 1;
}
alias:kick("expulsar")
flags:kick(CMD_FLAG<RANK_LEVEL_MODERATOR> | CMD_DONT_LOG_COMMAND)

command ban_account(playerid, const params[], "Veta a una cuenta offline")
{
    new account_id, account_name[25], reason[51], time_seconds;
    if(!sscanf(params, "iI(-1)S(No especificada)[50]", account_id, time_seconds, reason))
    {
        if(account_id < 1)
        {
            SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} Para banear una cuenta offline por ID, la ID proveída debe ser mayor a 0.");
            return 1;
        }

        inline const QueryDone()
        {
            new rowc;
            cache_get_row_count(rowc);
            if(!rowc)
            {
                SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} No hay una cuenta asociada a la ID {ED2B2B}%i{DADADA}.", account_id);
                return 1;
            }

            new sex;
            cache_get_value_name(0, !"NAME", account_name);
            cache_get_value_name_int(0, !"SEX", sex);

            Account_Ban(account_name, playerid, reason, time_seconds);

            Admins_SendMessage(RANK_LEVEL_HELPER, 0x415BA2FF, 
                va_return("{DADADA}%s {415BA2}%s{DADADA} ({415BA2}%i{DADADA}) fue vetad%c por %s %s {415BA2}%s{DADADA}.", 
                    (sex == SEX_MALE ? "El jugador" : "La jugadora"), account_name, account_id, (sex == SEX_MALE ? 'o' : 'a'), 
                    (Player_Sex(playerid) == SEX_MALE ? "el" : "la"), Player_GetRankName(playerid), Player_RPName(playerid)
                )
            );
        }
        MySQL_TQueryInline(g_hDatabase, using inline QueryDone, "SELECT `NAME`, `SEX` FROM `ACCOUNT` WHERE `ID` = %i LIMIT 1;", account_id);

        return 1;
    }
    else if(sscanf(params, "s[24]I(-1)S(No especificada)[50]", account_name, time_seconds, reason))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/ban_account {DADADA}<id o nombre> {969696}[tiempo en segundos = -1 (permanente)] [razón = \"No especificada\"]");
        return 1;
    }

    inline const QueryDone()
    {
        new rowc;
        cache_get_row_count(rowc);
        if(!rowc)
        {
            SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} No hay una cuenta asociada al nombre {ED2B2B}%s{DADADA}.", account_name);
            return 1;
        }

        new sex;
        cache_get_value_name_int(0, !"ID", account_id);
        cache_get_value_name_int(0, !"SEX", sex);

        Account_Ban(account_name, playerid, reason, time_seconds);

        Admins_SendMessage(RANK_LEVEL_HELPER, 0x415BA2FF, 
            va_return("{DADADA}%s {415BA2}%s{DADADA} ({415BA2}%i{DADADA}) fue vetad%c por %s %s {415BA2}%s{DADADA}.", 
                (sex == SEX_MALE ? "El jugador" : "La jugadora"), account_name, account_id, (sex == SEX_MALE ? 'o' : 'a'), (Player_Sex(playerid) == SEX_MALE ? "el" : "la"), Player_GetRankName(playerid), Player_RPName(playerid)
            )
        );
    }

    MySQL_TQueryInline(g_hDatabase, using inline QueryDone, "SELECT `ID`, `SEX` FROM `ACCOUNT` WHERE `NAME` = '%e' LIMIT 1;", account_name);

    return 1;
}
alias:ban_account("banoff")
flags:ban_account(CMD_FLAG<RANK_LEVEL_MODERATOR> | CMD_DONT_LOG_COMMAND)

static 
    bool:s_rgbHasBeenTeleported[MAX_PLAYERS char],
    Float:s_rgfPreviousPositions[MAX_PLAYERS][4],
    s_rgiPreviousInteriors[MAX_PLAYERS],
    s_rgiPreviousWorlds[MAX_PLAYERS]
;

command tp(playerid, const params[], "Teletransportate a la posición de un jugador")
{
    new destination, player_two;
    if(sscanf(params, "rR(-1)", destination, player_two) || !IsPlayerConnected(destination))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/tp{DADADA} <jugador de destino> {969696}[jugador]");
        return 1;
    }

    if(IsPlayerConnected(player_two))
        playerid = player_two;

    GetPlayerPos(playerid, s_rgfPreviousPositions[playerid][0], s_rgfPreviousPositions[playerid][1], s_rgfPreviousPositions[playerid][2]);
    GetPlayerFacingAngle(playerid, s_rgfPreviousPositions[playerid][3]);
    s_rgiPreviousInteriors[playerid] = GetPlayerInterior(playerid);
    s_rgiPreviousWorlds[playerid] = GetPlayerVirtualWorld(playerid);
    s_rgbHasBeenTeleported{playerid} = true;

    new Float:x, Float:y, Float:z;
    GetPlayerPos(destination, x, y, z);
    Player_SetPos(playerid, x, y, z);
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(destination));
    SetPlayerInterior(playerid, GetPlayerInterior(destination));

    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Te teletransportaste a la posición de {ED2B2B}%s{DADADA}.", Player_RPName(destination));
    return 1;
}
flags:tp(CMD_FLAG<RANK_LEVEL_HELPER>)

command back(playerid, const params[], "Devuelve a un jugador a su posición original")
{
    new destination = -1;
    sscanf(params, "R(-1)", destination);
    if(!IsPlayerConnected(destination))
        destination = playerid;

    if(!s_rgbHasBeenTeleported{destination})
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} El jugador no ha sido teletransportado por un administrador.");
        return 1;
    }

    s_rgbHasBeenTeleported{destination} = false;
    Player_SetPos(destination, s_rgfPreviousPositions[destination][0], s_rgfPreviousPositions[destination][1], s_rgfPreviousPositions[destination][2]);
    SetPlayerFacingAngle(destination, s_rgfPreviousPositions[destination][3]);
    SetPlayerInterior(destination, s_rgiPreviousInteriors[destination]);
    SetPlayerVirtualWorld(destination, s_rgiPreviousWorlds[destination]);

    if(destination != playerid)
        SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} %s fue devuelto a su posición original.", Player_RPName(playerid));

    SendClientMessagef(destination, 0xED2B2BFF, "›{DADADA} Fuiste devuelto a tu posición original.");
    return 1;
}
flags:back(CMD_FLAG<RANK_LEVEL_HELPER>)

command bring(playerid, const params[], "Trae a un jugador a tu posición")
{
    new destination;
    if(sscanf(params, "r", destination))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/bring{DADADA} <jugador>");
        return 1;
    }

    GetPlayerPos(destination, s_rgfPreviousPositions[destination][0], s_rgfPreviousPositions[destination][1], s_rgfPreviousPositions[destination][2]);
    GetPlayerFacingAngle(destination, s_rgfPreviousPositions[destination][3]);
    s_rgiPreviousInteriors[destination] = GetPlayerInterior(destination);
    s_rgiPreviousWorlds[destination] = GetPlayerVirtualWorld(destination);
    s_rgbHasBeenTeleported{destination} = true;

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    Player_SetPos(destination, x, y, z);
    SetPlayerInterior(destination, GetPlayerInterior(playerid));
    SetPlayerVirtualWorld(destination, GetPlayerVirtualWorld(playerid));

    SendClientMessage(destination, 0xED2B2BFF, "›{DADADA} Fuiste teletransportado a la posición de {ED2B2B}un administrador{DADADA}.");
    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Trajiste a {ED2B2B}%s{DADADA} a tu posición.", Player_RPName(destination));
    return 1;
}
flags:bring(CMD_FLAG<RANK_LEVEL_HELPER>)

command givemoney(playerid, const params[], "Le da dinero a un jugador")
{
    extract params -> new money = 422, player:destination = 0xFFFF; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/givemoney {DADADA}[dinero = 100] [jugador = tú]");
        return 1;
    }

	if (destination == INVALID_PLAYER_ID)
        destination = playerid;

	Player_GiveMoney(destination, money);

    if (playerid != destination)
    {
        SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Le diste {ED2B2B}$%d{DADADA} a {ED2B2B}%s{DADADA}.", money, Player_RPName(destination));
    }
    
    SendClientMessagef(destination, 0xED2B2BFF, "›{DADADA} Se te asignó {ED2B2B}$%d{DADADA}.", money);

    return 1;
}
flags:givemoney(CMD_FLAG<RANK_LEVEL_SUPERADMIN>)

static 
    s_rgszSelectedAdmin[MAX_PLAYERS][24];

command manage_admins(playerid, const params[], "Abre el panel de administradores")
{
    s_rgszSelectedAdmin[playerid][0] = '\0';

    inline const QueryDone()
    {
        new rowc;
        cache_get_row_count(rowc);

        if(!rowc)
        {
            SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} No se pudo encontrar a ningun administrador en la base de datos.");
            return 1;
        }

        strcpy(HYAXE_UNSAFE_HUGE_STRING, "{DADADA}Nombre\t{DADADA}Rango administrativo\t{DADADA}Última conexión\n");

        new line[128];
        for(new i; i < rowc; ++i)
        {
            new admin_name[25], admin_accountid, admin_playerid, admin_level, admin_sex, last_connection[24];
            cache_get_value_name(i, "NAME", admin_name);
            cache_get_value_name_int(i, "ID", admin_accountid);
            cache_get_value_name_int(i, "CURRENT_PLAYERID", admin_playerid);
            cache_get_value_name_int(i, "ADMIN_LEVEL", admin_level);
            cache_get_value_name_int(i, "SEX", admin_sex);
            cache_get_value_name(i, "DATE", last_connection);

            format(line, sizeof(line), 
                "{DADADA}%s ({415BA2}%i{DADADA})\t{DADADA}%s\t{%x}%s\n", 
                admin_name, admin_accountid, g_rgszRankLevelNames[admin_level][admin_sex], (admin_playerid == -1 ? 0xDADADA : 0x64A752), (admin_playerid == -1 ? last_connection : "En línea")
            );

            strcat(HYAXE_UNSAFE_HUGE_STRING, line);
        }

        Dialog_ShowCallback(playerid, using public _hydg@manage_admins<iiiis>, DIALOG_STYLE_TABLIST_HEADERS, "{415BA2}Hyaxe {DADADA}- Administradores", HYAXE_UNSAFE_HUGE_STRING, "Seleccionar", "Salir");
    }
    MySQL_TQueryInline(g_hDatabase, using inline QueryDone, 
        "\
            SELECT `ACCOUNT`.`NAME`, `ACCOUNT`.`ID`, `ACCOUNT`.`CURRENT_PLAYERID`, `ACCOUNT`.`SEX`, `ACCOUNT`.`ADMIN_LEVEL`, MAX(`CONNECTION_LOG`.`DATE`) AS `DATE` \
                FROM `ACCOUNT` \
                    INNER JOIN `CONNECTION_LOG` \
                        ON `ACCOUNT`.`ID` = `CONNECTION_LOG`.`ACCOUNT_ID` \
                WHERE `ADMIN_LEVEL` > 0 \
                GROUP BY `ACCOUNT`.`ID` \
                ORDER BY `ACCOUNT`.`ADMIN_LEVEL` DESC;\
        "
    );

    return 1;
}
flags:manage_admins(CMD_FLAG<RANK_LEVEL_MODERATOR>)

dialog manage_admins(playerid, dialogid, response, listitem, const inputtext[])
{
    if(!response)
        return 1;

    new space;
    for(; space < 24; ++space)
    {
        if(inputtext[space] == ' ')
            break;
    }

    strcat(s_rgszSelectedAdmin[playerid], inputtext, space + 1);
    Dialog_ShowCallback(playerid, using public _hydg@manage_admin_options<iiiis>, DIALOG_STYLE_LIST, va_return("Opciones para {415BA2}%s{DADADA}...", s_rgszSelectedAdmin[playerid]), "{DADADA}Cambiar rango administrativo", "Continuar", "Atrás");

    return 1;
}

dialog manage_admin_options(playerid, dialogid, response, listitem, const inputtext[])
{
    if(!response)
    {
        PC_EmulateCommand(playerid, "/manage_admins");
        return 1;
    }

    if(Player_AdminLevel(playerid) != RANK_LEVEL_SUPERADMIN)
    {
        PC_EmulateCommand(playerid, "/manage_admins");
        Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "No puedes hacer eso");
        return 1;
    }

    switch(listitem)
    {
        case 0:
        {
            HYAXE_UNSAFE_HUGE_STRING[0] = '\0';
            new line[64];
            for(new i = RANK_LEVEL_USER; i <= RANK_LEVEL_SUPERADMIN; ++i)
            {
                format(line, sizeof(line), "%s\n", g_rgszRankLevelNames[i][SEX_MALE]); // Assume it's a man because I won't save anything else than the name
                strcat(HYAXE_UNSAFE_HUGE_STRING, line);
            }

            format(line, sizeof(line), "Selecciona el nuevo rango de {415BA2}%s", s_rgszSelectedAdmin[playerid]);
            Dialog_ShowCallback(playerid, using public _hydg@manage_admin_new_rank<iiiis>, DIALOG_STYLE_LIST, line, HYAXE_UNSAFE_HUGE_STRING, "Cambiar", "Atrás");
        }
    }

    return 1;
}

dialog manage_admin_new_rank(playerid, dialogid, response, listitem, const inputtext[])
{
    if(response)
    {
        if(!(RANK_LEVEL_USER <= listitem <= RANK_LEVEL_SUPERADMIN))
            return 1;

        mysql_format(g_hDatabase, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `ADMIN_LEVEL` = %i WHERE `NAME` = '%e' LIMIT 1;", listitem, s_rgszSelectedAdmin[playerid]);
        mysql_tquery(g_hDatabase, YSI_UNSAFE_HUGE_STRING);
        
        new bool:reported = false;
        
        foreach(new i : LoggedIn)
        {
            if(!strcmp(s_rgszSelectedAdmin[playerid], Player_Name(i)))
            {
                if(Player_AdminLevel(i) != listitem)
                {
                    new const bool:is_lower = (Player_AdminLevel(i) > listitem);
                    Player_AdminLevel(i) = listitem;

                    SendClientMessagef(playerid, 0x415BA2FF, "›{DADADA} Tu nivel administrativo fue %s a {415BA2}%s{DADADA}.", (is_lower ? "descendido" : "ascendido"), Player_GetRankName(i));
                    Admins_SendMessage(RANK_LEVEL_HELPER, 0x415BA2FF, va_return("›{DADADA} %s ahora es %s {415BA2}%s{DADADA}.", Player_RPName(i), (Player_Sex(i) == SEX_MALE ? "un" : "una"), Player_GetRankName(i)));
                }

                reported = true;

                break;
            }
        }

        if(!reported)
        {
            Admins_SendMessage(RANK_LEVEL_HELPER, 0x415BA2FF, va_return("›{DADADA} %s ahora es un {415BA2}%s{DADADA}.", s_rgszSelectedAdmin[playerid], g_rgszRankLevelNames[listitem][SEX_MALE]));
        }
    }

    PC_EmulateCommand(playerid, "/manage_admins");
    return 1;
}

command pos(playerid, const params[], "Ir a unas coordenadas")
{
    extract params -> new Float:x, Float:y, Float:z, world, interior; else {
        return SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/pos {DADADA}<x> <y> <z> <world> <interior>");
    }

    SetPlayerInterior(playerid, interior);
    SetPlayerVirtualWorld(playerid, world);
    Player_SetPos(playerid, x, y, z);
    
    Player_SetImmunityForCheat(playerid, CHEAT_FLY, 3000);
    
    return 1;
}
flags:pos(CMD_FLAG<RANK_LEVEL_MODERATOR>)

command specoff(playerid, const params[], "Deja de spectear")
{
    Player_SetPos(playerid, s_rgfPreviousPositions[playerid][0], s_rgfPreviousPositions[playerid][1], s_rgfPreviousPositions[playerid][2]);
    SetPlayerFacingAngle(playerid, s_rgfPreviousPositions[playerid][3]);
    SetPlayerInterior(playerid, s_rgiPreviousInteriors[playerid]);
    SetPlayerVirtualWorld(playerid, s_rgiPreviousWorlds[playerid]);

	TogglePlayerSpectating(playerid, false);
    return 1;
}
flags:specoff(CMD_FLAG<RANK_LEVEL_MODERATOR>)

command spec(playerid, const params[], "Spectea a un jugador")
{
    new destination;
    if(sscanf(params, "r", destination) || !IsPlayerConnected(destination))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/spec {DADADA} <jugador>");
        return 1;
    }

    GetPlayerPos(playerid, s_rgfPreviousPositions[playerid][0], s_rgfPreviousPositions[playerid][1], s_rgfPreviousPositions[playerid][2]);
    GetPlayerFacingAngle(playerid, s_rgfPreviousPositions[playerid][3]);
    s_rgiPreviousInteriors[playerid] = GetPlayerInterior(playerid);
    s_rgiPreviousWorlds[playerid] = GetPlayerVirtualWorld(playerid);

    TogglePlayerSpectating(playerid, true);

	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(destination));
	SetPlayerInterior(playerid, GetPlayerInterior(destination));

	if (IsPlayerInAnyVehicle(destination)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(destination));
	else PlayerSpectatePlayer(playerid, destination);

    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Estas mirando a {ED2B2B}%s{DADADA}.", Player_RPName(destination));
    return 1;
}
flags:spec(CMD_FLAG<RANK_LEVEL_MODERATOR>)

command freeze(playerid, const params[], "Congela a un jugador")
{
    new destination;
    if(sscanf(params, "r", destination) || !IsPlayerConnected(destination))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/freeze {DADADA} <jugador>");
        return 1;
    }

    TogglePlayerControllable(destination, false);
    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Congelaste a {ED2B2B}%s{DADADA}.", Player_RPName(destination));
    return 1;
}
flags:freeze(CMD_FLAG<RANK_LEVEL_MODERATOR>)

command unfreeze(playerid, const params[], "Congela a un jugador")
{
    new destination;
    if(sscanf(params, "r", destination) || !IsPlayerConnected(destination))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/unfreeze {DADADA} <jugador>");
        return 1;
    }

    TogglePlayerControllable(destination, true);
    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Descongelaste a {ED2B2B}%s{DADADA}.", Player_RPName(destination));
    return 1;
}
flags:unfreeze(CMD_FLAG<RANK_LEVEL_MODERATOR>)

command clearchat(playerid, const params[], "Limpia el chat")
{
    for(new i = 0; i != 40; i ++) SendClientMessageToAll(-1, " ");
    return 1;
}
flags:clearchat(CMD_FLAG<RANK_LEVEL_MANAGER>)

command asay(playerid, const params[], "Envia un anuncio como admin")
{
	if (isnull(params))
        return SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/asay {DADADA} <texto>");

	format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "[Anuncio]{DADADA} %s %s (%d): %s",
        g_rgszRankLevelNames[ Player_AdminLevel(playerid) ][ Player_Sex(playerid) ],
        Player_RPName(playerid),
        playerid,
        params
    );
	SendClientMessageToAll(0xDAA838FF, HYAXE_UNSAFE_HUGE_STRING);
	return 1;
}
flags:asay(CMD_FLAG<RANK_LEVEL_MANAGER> | CMD_DONT_LOG_COMMAND)

command set_skin(playerid, const params[], "Asigna la ropa de un jugador")
{
    new destination, skin;
    if(sscanf(params, "ri", destination, skin))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/set_skin{DADADA} <jugador> <skin>");
        return 1;
    }

    if(!IsPlayerConnected(destination))
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} Jugador inválido.");
        return 1;
    }

    if(!Player_SetSkin(destination, skin))
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} La ID de la skin debe estar entre el 0 y 311, excluyendo el 74.");
        return 1;
    }

    if(playerid != destination)
    {
        SendClientMessage(destination, 0xED2B2BFF, "›{DADADA} Un administrador cambió tu skin.");
        SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} La skin de %s ahora es la %i.", Player_RPName(destination), skin);
    }
    else
    {
        SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Tu skin ahora es la %i.", skin);
    }

    return 1;
}
flags:set_skin(CMD_FLAG<RANK_LEVEL_MANAGER>)

command report(playerid, const params[], "Informar al personal sobre un usuario")
{
	extract params -> new player:destination = 0xFFFF, string:message[144]; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/reportar {DADADA}[jugador] [descripción]");
        return 1;
    }

    if (g_rgePlayerTempData[playerid][e_iReportSentTime] > gettime() && !Player_AdminLevel(playerid))
        return SendClientMessage(playerid, 0xED2B2BFF, va_return("›{DADADA} Hay que esperar %d segundos para poder enviar otra pregunta.", g_rgePlayerTempData[playerid][e_iReportSentTime] - gettime()));

	if (destination == INVALID_PLAYER_ID)
        destination = playerid;

	new messages[2][144];
	format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{AE2012}[Reporte] › {DADADA}%s (%d) reporta a %s (%d): %s", Player_RPName(playerid), playerid, Player_RPName(destination), destination, message);
	for(new i, j = SplitChatMessageInLines(HYAXE_UNSAFE_HUGE_STRING, messages); i < j; ++i)
        Admins_SendMessage(RANK_LEVEL_HELPER, 0xDADADAFF, messages[i]);
	
    Notification_Show(playerid, "Reporte enviado.", 3000, 0x64A752FF);
    g_rgePlayerTempData[playerid][e_iReportSentTime] = gettime() + 15;
	return 1;
}
alias:report("reportar", "re")

command ls(playerid, const params[], "Ir a Los Santos")
{
    new destination = -1;
    sscanf(params, "R(-1)", destination);
    if(!IsPlayerConnected(destination))
        destination = playerid;

    Player_SetHealth(destination, 100);

    Player_SetPos(destination, PLAYER_SPAWN_X, PLAYER_SPAWN_Y, PLAYER_SPAWN_Z);
    SetPlayerFacingAngle(destination, PLAYER_SPAWN_ANGLE);
    SetPlayerVirtualWorld(destination, 0);
    SetPlayerInterior(destination, 0);
    return 1;
}
flags:ls(CMD_FLAG<RANK_LEVEL_MODERATOR>)

command ife(playerid, const params[], "Da dinero a todos los jugadores")
{
    extract params -> new amount; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/ife{DADADA} <cantidad>");
        return 1;
    }

    foreach(new i : Player)
    {
        Player_GiveMoney(i, amount, false);
        SendClientMessagef(i, 0xED2B2BFF, "›{DADADA} Un administrador te dio {ED2B2B}%i$", amount);
    }

    mysql_format(g_hDatabase, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "UPDATE `ACCOUNT` SET `MONEY` = `MONEY` + %i WHERE `CURRENT_PLAYERID` != -1;", amount);
    mysql_tquery(g_hDatabase, YSI_UNSAFE_HUGE_STRING);

    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Le diste {ED2B2B}%i${DADADA} a todos los jugadores.", amount);

    return 1;
}
flags:ife(CMD_FLAG<RANK_LEVEL_SUPERADMIN>)

command unban(playerid, const params[], "Desbanear a un jugador")
{
    extract params -> new string:name[24]; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/unban {DADADA}[nombre]");
        return 1;
    }

    mysql_format(g_hDatabase, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH, "DELETE `BANS` WHERE `BANNED_USER` = '%s';", name);
    mysql_tquery(g_hDatabase, YSI_UNSAFE_HUGE_STRING);

    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Usuarios desbaneado: {ED2B2B}%s{DADADA}.", name);
    return 1;
}
flags:unban(CMD_FLAG<RANK_LEVEL_MODERATOR>)