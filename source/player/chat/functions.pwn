#if defined _CHAT_FUNCTIONS_
    #endinput
#endif
#define _CHAT_FUNCTIONS_

Chat_SendMessageToRange(playerid, color, Float:range, string[])
{
    // Wrap chat message
    new line_one[144], line_two[144], bool:wrapped;
    format(line_one, 96, "%s", string);
    if (strlen(string) > 96)
	{
		format(line_two, sizeof(line_two), "- %s", string[96]);
		wrapped = true;
	}

    // Distance check
    new Float:x, Float:y, Float:z, virtual_world, interior;
    GetPlayerPos(playerid, x, y, z);
    virtual_world = GetPlayerVirtualWorld(playerid);
    interior = GetPlayerInterior(playerid);

    foreach(new i : LoggedIn)
    {
        if (GetPlayerVirtualWorld(i) != virtual_world && GetPlayerInterior(i) != interior)
            continue;

        if (IsPlayerInRangeOfPoint(i, range, x, y, z))
        {
            SendClientMessage(i, color, line_one);
            if (wrapped) SendClientMessage(i, color, line_two);
        }
    }
    return 1;
}

command b(playerid, const params[], "Envia un mensaje fuera de rol")
{
    if (isnull(params))
    {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/b {DADADA}<texto>");
        return 1;
    }

    new string[288];
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

    new string[288];
    format(string, sizeof(string), "* %s %s", Player_RPName(playerid), params);
    Chat_SendMessageToRange(playerid, 0xB39B6BFF, 30.0, string);

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

    new string[288];
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

    new string[288];
    format(string, sizeof(string), "* %s (( %s ))", Player_RPName(playerid), params);
    Chat_SendMessageToRange(playerid, 0xB39B6BFF, 30.0, string);

    return 1;
}
alias:do("entorno")