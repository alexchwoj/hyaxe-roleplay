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

    Chat_SendDoubt(playerid, params);
    return 1;
}
alias:duda("n")

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

    SendClientMessagef(
        playerid, 0xED2B2BFF,
        "›{DADADA} Duración de la sesión actual: {ED2B2B}%d minuto(s)",
        (NetStats_GetConnectedTime(destination) / 60000)
    );

    if (Player_AdminLevel(playerid) > RANK_LEVEL_USER && Player_AdminLevel(playerid) >= Player_AdminLevel(destination))
    {
        SendClientMessagef(
            playerid, 0x415BA2FF,
            "›{DADADA} Admin:{BBBBBB} IP: %s, %dB sent, %dB received",
            RawIpToString(Player_IP(destination)),
            NetStats_BytesSent(destination),
            NetStats_BytesReceived(destination)
        );
    }
    return 1;
}
alias:id("jugador")
