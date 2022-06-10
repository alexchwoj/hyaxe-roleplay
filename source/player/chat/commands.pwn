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

command id(playerid, const params[], "Ver los datos de un jugador")
{
    extract params -> new player:destination = 0xFFFF; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/id {DADADA}[jugador = tú]");
        return 1;
    }

    if (destination == INVALID_PLAYER_ID)
        destination = playerid;

    if (!IsPlayerConnected(destination))
        return SendClientMessagef(playerid, 0xED2B2BFF, "›{DADADA} No hay un usuario que concuerde con el ID: {ED2B2B}%s{DADADA}.", destination);

    new
        Float:max_packetloss_percentage = NetStats_PacketLossPercent(destination) / 10.0,
        Float:max_ping_percentage = GetPlayerPing(destination) / 500
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

    if (Player_AdminLevel(playerid) >= 4)
    {
        SendClientMessagef(
            playerid, 0xED2B2BFF,
            "›{DADADA} información privilegiada: IP: %s, %dB sent, %dB received",
            RawIpToString(Player_IP(destination)),
            NetStats_BytesSent(destination),
            NetStats_BytesReceived(destination)
        );
    }

    SendClientMessagef(
        playerid, 0xED2B2BFF,
        "›{DADADA} Duración de la sesión actual: {ED2B2B}%d minuto(s)",
        (NetStats_GetConnectedTime(destination) / 60000)
    );
    return 1;
}
alias:id("jugador")
