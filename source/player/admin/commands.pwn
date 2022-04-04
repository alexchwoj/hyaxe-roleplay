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

    Admins_SendMessage_s(RANK_LEVEL_HELPER, 0x415BA2FF, 
        @f("{DADADA}%s {415BA2}%s{DADADA} ({415BA2}%i{DADADA}-{415BA2}%i{DADADA}) fue vetado por %s %s {415BA2}%s{DADADA}.", 
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

    Dialog_Show_s(playerid, "kick", DIALOG_STYLE_MSGBOX, @("{CB3126}Hyaxe {DADADA}- Expulsión"),
        @f(
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

    KickTimed(playerid, 500);

    Admins_SendMessage_s(RANK_LEVEL_HELPER, 0x415BA2FF, 
        @f("› {DADADA}%s {415BA2}%s {DADADA}(ID {415BA2}%i{DADADA}) fue expulsado por %s %s {415BA2}%s{DADADA}.", 
            (Player_Sex(kicked) == SEX_MALE ? "El jugador" : "La jugadora"), Player_RPName(kicked), kicked, (Player_Sex(playerid) == SEX_MALE ? "el" : "la"), Player_GetRankName(playerid), Player_RPName(playerid)
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

        new Cache:c = await<Cache> MySQL_QueryAsync_s(g_hDatabase, @f("SELECT `NAME` FROM `ACCOUNT` WHERE `ID` = %i LIMIT 1;", account_id));
        
        new rowc;
        cache_get_row_count(rowc);
        if(!rowc)
        {
            SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} No hay una cuenta asociada a la ID {ED2B2B}%i{DADADA}.", account_id);
            return 1;
        }

        cache_get_value_name(0, !"NAME", account_name);
    }
    else if(sscanf(params, "s[24]I(-1)S(No especificada)[50]", account_name, time_seconds, reason))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/ban_account {DADADA}<id o nombre> {969696}[tiempo en segundos = -1 (permanente)] [razón = \"No especificada\"]");
        return 1;
    }

    if(!account_id)
    {
        new Cache:c = await<Cache> MySQL_QueryAsync_s(g_hDatabase, @f("SELECT `ID` FROM `ACCOUNT` WHERE `NAME` = '%e' LIMIT 1;", account_name));

        new rowc;
        cache_get_row_count(rowc);
        if(!rowc)
        {
            SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} No hay una cuenta asociada al nombre {ED2B2B}%s{DADADA}.", account_name);
            return 1;
        }

        cache_get_value_name_int(0, !"ID", account_id);
    }

    Account_Ban(account_name, playerid, reason, time_seconds);

    Admins_SendMessage_s(RANK_LEVEL_HELPER, 0x415BA2FF, 
        @f("{DADADA}La cuenta {415BA2}%s{DADADA} ({415BA2}%i{DADADA}) fue vetada por %s %s {415BA2}%s{DADADA}.", 
            account_name, account_id, (Player_Sex(playerid) == SEX_MALE ? "el" : "la"), Player_GetRankName(playerid), Player_RPName(playerid)
        )
    );

    return 1;
}
alias:ban_account("banoff")
flags:ban_account(CMD_FLAG<RANK_LEVEL_MODERATOR> | CMD_DONT_LOG_COMMAND)

command manage_admins(playerid, const params[], "Abre el panel de administradores")
{
    new Task<Cache>:t = MySQL_QueryAsync(g_hDatabase, 
        "SELECT `ACCOUNT`.`NAME`, `ACCOUNT`.`CURRENT_PLAYERID`, `ACCOUNT`.`SEX`, `ACCOUNT`.`ADMIN_LEVEL`, GROUP_CONCAT(`CONNECTION_LOG`.`DATE` ORDER BY `CONNECTION_LOG`.`DATE` DESC) AS `DATE`\
            FROM `ACCOUNT` \
                LEFT JOIN `CONNECTION_LOG` \
                    ON `ACCOUNT`.`ID` = `CONNECTION_LOG`.`ACCOUNT_ID` \
            WHERE `ADMIN_LEVEL` > 0 \
            ORDER BY `ACCOUNT`.`ADMIN_LEVEL` DESC;\
    ");

    new Cache:c = await<Cache> t;

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
        new admin_name[25], admin_playerid, admin_level, admin_sex, last_connection[24];
        cache_get_value_name(i, "NAME", admin_name);
        cache_get_value_name_int(i, "CURRENT_PLAYERID", admin_playerid);
        cache_get_value_name_int(i, "ADMIN_LEVEL", admin_level);
        cache_get_value_name_int(i, "SEX", admin_sex);
        cache_get_value_name(i, "DATE", last_connection);

        format(line, sizeof(line), 
            "{DADADA}%s\t{DADADA}%s\t{%x}%s\n", 
            admin_name, g_rgszRankLevelNames[admin_level][admin_sex], (admin_playerid == -1 ? 0xDADADA : 0x64A752), (admin_playerid == -1 ? last_connection : "En línea")
        );

        strcat(HYAXE_UNSAFE_HUGE_STRING, line);
    }

    Dialog_Show(playerid, "manage_admins", DIALOG_STYLE_TABLIST_HEADERS, "{415BA2}Hyaxe {DADADA}- Administradores", HYAXE_UNSAFE_HUGE_STRING, "Seleccionar", "Salir");

    return 1;
}