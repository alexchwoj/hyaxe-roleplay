#if defined _chat_commands_
    #endinput
#endif
#define _chat_commands_

command b(playerid, const params[], "Envia un mensaje fuera de rol")
{
    if (isnull(params))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/b {DADADA}<texto>");
        return 1;
    }

    new string[200];
    format(string, sizeof(string), "{DAA838}[OOC]{DADADA} %s (%d): (( %s ))", Player_RPName(playerid), playerid, params);
    Chat_SendMessageToRange(playerid, 0xDADADAFF, 30.0, string);

    return 1;
}

command me(playerid, const params[], "Envia un mensaje de acción")
{
    if (isnull(params))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/me {DADADA}<texto>");
        return 1;
    }

    Chat_SendAction(playerid, params);
    return 1;
}
alias:me("y")

command intentar(playerid, const params[], "Rolear un intento")
{
    if (isnull(params))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/intentar {DADADA}<texto>");
        return 1;
    }

    new string[200];
    format(string, sizeof(string), "* %s intenta %s y %s.", Player_RPName(playerid), params, random(2) ? "lo logra" : "falla");
    Chat_SendMessageToRange(playerid, 0xB39B6BFF, 30.0, string);

    return 1;
}

command do(playerid, const params[], "Envia un mensaje de entorno")
{
    if (isnull(params))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/do {DADADA}<texto>");
        return 1;
    }

    new string[170];
    format(string, sizeof(string), "* %s (( %s ))", Player_RPName(playerid), params);
    Chat_SendMessageToRange(playerid, 0xB39B6BFF, 30.0, string);

    return 1;
}
alias:do("entorno")

command gritar(playerid, const params[], "Grita")
{
    if(isnull(params))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/gritar {DADADA}<texto>");
        return 1;
    }

    new string[150];
    format(string, sizeof(string), "%s grita: %s", Player_RPName(playerid), params);

    Chat_SendMessageToRange(playerid, 0xDADADAFF, 60.0, string);
    SetPlayerChatBubble(playerid, params, 0xDADADAFF, 15.0, 15000);

    return 1;
}
alias:gritar("g")

command susurrar(playerid, const params[], "Susurra")
{
    if(isnull(params))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/susurrar {DADADA}<texto>");
        return 1;
    }

    new string[150];
    format(string, sizeof(string), "%s susurra: %s", Player_RPName(playerid), params);

    Chat_SendMessageToRange(playerid, 0xDADADAFF, 10.0, string);
    SetPlayerChatBubble(playerid, params, 0xDADADAFF, 10.0, 15000);

    return 1;
}
alias:susurrar("s")

command duda(playerid, const params[], "Envia un mensaje al canal de dudas")
{
    if (isnull(params))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/duda {DADADA}<texto>");
        return 1;
    }

    if (!Bit_Get(Player_Config(playerid), CONFIG_SHOW_DOUBT_CHANNEL))
        return SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} Activa el canal de dudas para poder usarlo.");

    if (Player_MutedTime(playerid) > gettime())
        return SendClientMessage(playerid, 0xED2B2BFF, va_return("›{DADADA} Estás silenciado durante %d segundos.", Player_MutedTime(playerid) - gettime()));

    if (g_rgePlayerTempData[playerid][e_iDoubtSentTime] > gettime() && !Player_AdminLevel(playerid))
        return SendClientMessage(playerid, 0xED2B2BFF, va_return("›{DADADA} Hay que esperar %d segundos para poder enviar otra pregunta.", g_rgePlayerTempData[playerid][e_iDoubtSentTime] - gettime()));

    Chat_SendDoubt(playerid, params);
    g_rgePlayerTempData[playerid][e_iDoubtSentTime] = gettime() + 15;
    return 1;
}
alias:duda("n", "d")

command mutear(playerid, const params[], "Silenciar a un usuario del canal de dudas.")
{
    new destination, time, time_unit, reason[51];
    if (sscanf(params, "rI(1)K<time_unit>(0)S(No especificada)[50]", destination, time, time_unit, reason))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/mutear {DADADA}<jugador> {969696}[tiempo = 1] [unidad de tiempo (horas, minutos, segundos) = minutos] [razón = \"No especificada\"]");
        return 1;
    }

    switch(time_unit)
    {
        case 1: {}
        case 2: time *= 60;
        case 3: time *= 3600;
        default:
        {
            SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} Unidad de tiempo inválida. Debe ser {ED2B2B}horas{DADADA}, {ED2B2B}minutos{DADADA}, o {ED2B2B}segundos{DADADA}.");
            return 1;
        }
    }

    if (!IsPlayerConnected(destination))
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} Usuario no encontrado.");
        return 1;
    }

    if (Player_AdminLevel(destination) > Player_AdminLevel(playerid))
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} No puedes mutear a alguien superior a ti.");
        return 1;
    }

    Player_MutedTime(destination) = gettime() + time;
    Chat_SendDoubt(playerid, va_return("silenció a {91B787}%s (%d){DADADA} por {91B787}%d{DADADA} segundos, motivo: %s.", Player_RPName(destination), destination, time, reason));
    return 1;
}
alias:mutear("mute", "silenciar")
flags:mutear(CMD_FLAG<RANK_LEVEL_HELPER>)

command desmutear(playerid, const params[], "Desilenciar a un usuario del canal de dudas.")
{
    new destination;
    if (sscanf(params, "r", destination))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/desmutear {DADADA}<jugador>");
        return 1;
    }

    if (!IsPlayerConnected(destination))
    {
        SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} Usuario no encontrado.");
        return 1;
    }

    Player_MutedTime(destination) = 0;
    Chat_SendDoubt(playerid, va_return("desilenció a {91B787}%s (%d){DADADA}.", Player_RPName(destination), destination));
    return 1;
}
alias:desmutear("unmute", "desilenciar")
flags:desmutear(CMD_FLAG<RANK_LEVEL_HELPER>)

command id(playerid, const params[], "Ver los datos de un jugador")
{
    extract params -> new player:destination = 0xFFFF; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/id {DADADA}[jugador = tú]");
        return 1;
    }

    if (destination == INVALID_PLAYER_ID)
        destination = playerid;

    if (!IsPlayerConnected(destination))
        return SendClientMessage(playerid, 0xED2B2BFF, "›{DADADA} No hay un usuario que concuerde con el ID o nombre dados.");

    new const
        Float:max_packetloss_percentage = NetStats_PacketLossPercent(destination) / 10.0,
        Float:max_ping_percentage = float(GetPlayerPing(destination) / 500)    
    ;

    SendClientMessagef(
        playerid, 0xED2B2BFF,
        "›{DADADA} (ID %d) %s [{%x}%d{DADADA}ms, {%x}%.2f%{DADADA} packetloss, lvl %d]",
        destination,
        Player_RPName(destination),
        InterpolateColourLinear(0x64A752FF, 0xA83225FF, max_ping_percentage) >>> 8,
        GetPlayerPing(destination),
        InterpolateColourLinear(0x64A752FF, 0xA83225FF, max_packetloss_percentage) >>> 8,
        NetStats_PacketLossPercent(destination),
        Player_Level(destination)
    );

    SendClientMessagef(
        playerid, 0xED2B2BFF,
        "›{DADADA} Duración de la sesión actual: {ED2B2B}%d minuto(s)",
        (NetStats_GetConnectedTime(destination) / 60000)
    );

    if (Player_AdminLevel(playerid) > RANK_LEVEL_USER && Player_AdminLevel(playerid) >= Player_AdminLevel(destination))
    {
        SendClientMessagef(
            playerid, 0x415BA2FF,
            "›{DADADA} Admin:{BBBBBB} IP: %s, Cuenta: %d, %dB sent, %dB received",
            RawIpToString(Player_IP(destination)),
            Player_AccountID(destination),
            NetStats_BytesSent(destination),
            NetStats_BytesReceived(destination)
        );
    }
    return 1;
}
alias:id("jugador")

command mypos(playerid, const params[], "")
{
    SendClientMessagef(
        playerid, 0xED2B2BFF,
        "›{DADADA} Virtual World = %d, Interior = %d",
        GetPlayerVirtualWorld(playerid),
        GetPlayerInterior(playerid)
    );
    return 1;
}

command clearmychat(playerid, const params[], "Limpia el chat local")
{
    Chat_Clear(playerid);
    return 1;
}
alias:clearmychat("limpiarchat")