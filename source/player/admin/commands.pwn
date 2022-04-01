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
    SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} Jugador {ED2B2B}%s{DADADA} (Cuenta ID {ED2B2B}%i{DADADA}) vetado.", Player_RPName(banned), Player_AccountID(banned));

    return 1;
}

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
            "{DADADA}Fuiste expulsado del servidor.\n\n\
            {CB3126}Razón de la expulsión\n\
                \t{DADADA}%s\n\n\
            {CB3126}Administrador encargado\n\
                \t{DADADA}%s ({CB3126}%i{DADADA})\n\n\
            {CB3126}Fecha\n\
                \t{DADADA}%i/%i/%i %i:%i:%i\
        ",
            reason, Player_RPName(playerid), Player_AccountID(playerid),
            day, month, year, hour, minute, second
        ),
        "Salir"
    );

    KickTimed(playerid, 500);

    Admins_SendMessage_s(RANK_LEVEL_HELPER, 0xED2B2BFF, 
        @f("› {DADADA}El jugador {ED2B2B}%s {DADADA}(ID {ED2B2B}%i{DADADA}) fue expulsado por el %s {ED2B2B}%s{DADADA}.", 
            Player_RPName(kicked), kicked, g_rgszRankLevelNames[Player_AdminLevel(playerid)], Player_RPName(playerid)
        )
    );

    return 1;
}
