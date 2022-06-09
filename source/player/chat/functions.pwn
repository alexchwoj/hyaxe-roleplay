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

	if (playerid == INVALID_PLAYER_ID)
	{
		while (lines-- != -1)
		{
			SendClientMessageToAll(0, " ");
		}
	}
	else
	{
		while (lines-- != -1)
		{
			SendClientMessage(playerid, 0, " ");
		}
	}

	return 1;
}

Chat_SendMessageToRange(playerid, color, Float:range, const string[])
{
    // Wrap chat message
    static messages[10][144];
    new count = SplitChatMessageInLines(string, messages);

    new const bool:is_npc = FCNPC_IsValid(playerid);

    // Distance check
    new virtual_world = (is_npc ? FCNPC_GetVirtualWorld(playerid) : GetPlayerVirtualWorld(playerid));
    new interior = (is_npc ? FCNPC_GetInterior(playerid) : GetPlayerInterior(playerid));

    new Float:x, Float:y, Float:z;
    if(is_npc)
    {
        FCNPC_GetPosition(playerid, x, y, z);

        foreach(new i : LoggedIn)
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

            for(new j; j < count; ++j)
                SendClientMessage(i, color_darkened, messages[j]);
        }
    }
    else
    {
        GetPlayerPos(playerid, x, y, z);

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

            for(new j; j < count; ++j)
                SendClientMessage(i, color_darkened, messages[j]);
        }
    }

    for(new j; j < count; ++j)
        SendClientMessage(playerid, color, messages[j]);

    return 1;
}

ChatBuffer_Push(playerid, color, const message[])
{    
    if(FCNPC_IsValid(playerid))
        return 0;

    if(list_size(g_rglChatBuffer[playerid]) == CHAT_BUFFER_SIZE)
    {
        list_remove(g_rglChatBuffer[playerid], 0);
    }

    new msg[eMessageData];
    msg[e_iColor] = color;
    strcat(msg[e_szMessage], message);
    list_add_arr(g_rglChatBuffer[playerid], msg);

    return 1;
}

Chat_Resend(playerid)
{
    if(FCNPC_IsValid(playerid))
        return 0;

    g_rgbRegisterChatMessages{playerid} = false;

    new msg[eMessageData];
    for_list(i : g_rglChatBuffer[playerid])
    {
        iter_get_arr_safe(i, msg);
        SendClientMessage(playerid, msg[e_iColor], msg[e_szMessage]);
    }

    g_rgbRegisterChatMessages{playerid} = true;

    return 1;
}

Chat_SendAction(playerid, const message[])
{
    new string[156];
    format(string, sizeof(string), "* %s %s", Player_RPName(playerid), message);
    Chat_SendMessageToRange(playerid, 0xB39B6BFF, 30.0, string);
    return 1;
}

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
