#if defined _CHAT_FUNCTIONS_
    #endinput
#endif
#define _CHAT_FUNCTIONS_

Chat_Clear(playerid = INVALID_PLAYER_ID, lines = 20)
{
	if (playerid != INVALID_PLAYER_ID && !IsPlayerConnected(playerid))
	{
		return 0;
	}

	static const space[2] = " ";

	__emit 
    {
        push.c space
        push.c 1
    }

	if (playerid == INVALID_PLAYER_ID)
	{
		__emit push.c 12;

		while (lines-- != -1)
		{
			__emit sysreq.c SendClientMessageToAll;
		}

		__emit stack 12;
	}
	else
	{
		__emit 
        {
            push.s playerid
            push.c 16
        }

		while (lines-- != -1)
		{
			__emit sysreq.c SendClientMessage;
		}

		__emit stack 16;
	}

	return 1;
}

Chat_SendMessageToRange(playerid, color, Float:range, const string[])
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
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    new virtual_world = GetPlayerVirtualWorld(playerid);
    new interior = GetPlayerInterior(playerid);

    foreach(new i : StreamedPlayer[playerid])
    {
        if (!Bit_Get(Player_Flags(i), PFLAG_IN_GAME))
            continue;
            
        if (GetPlayerVirtualWorld(i) != virtual_world && GetPlayerInterior(i) != interior)
            continue;

        new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
        if(distance > range)
            continue;
        
        new color_relative = clamp(255 - floatround(distance * 3.0), 1, 255);
        new color_darkened = (color & 0xFFFFFF00) | color_relative;

        SendClientMessage(i, color_darkened, line_one);
        if (wrapped) 
            SendClientMessage(i, color_darkened, line_two);
    }

    SendClientMessage(playerid, color, line_one);
    if (wrapped) 
        SendClientMessage(playerid, color, line_two);

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

command testsound(playerid, params[], "")
{
	new sound;
	if (sscanf(params, "d", sound)) return 1;
	
	PlayerPlaySound(playerid, sound, 0.0, 0.0, 0.0);
	return 1;
}