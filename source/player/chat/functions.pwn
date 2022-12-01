#if defined _CHAT_FUNCTIONS_
    #endinput
#endif
#define _CHAT_FUNCTIONS_

Chat_Clear(playerid, lines = 20)
{
	for(new i; i != lines; i++)
        SendClientMessage(playerid, -1, "");

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

    new msg[eMessageData];
    msg[e_iColor] = color;
    strcat(msg[e_szMessage], message);
    //Circular_Push_(sizeof(g_rgeChatBuffer[]) * cellbytes, sizeof(g_rgeChatBuffer[][]), g_rgeChatBuffer[playerid], msg);

    return 1;
}

Chat_Resend(playerid)
{
    if(FCNPC_IsValid(playerid))
        return 0;

    return 1;
}

Chat_SendAction(playerid, const message[])
{
    new string[156];
    format(string, sizeof(string), "* %s %s.", Player_RPName(playerid), message);
    Chat_SendMessageToRange(playerid, 0xB39B6BFF, 30.0, string);
    return 1;
}

Chat_SendDoubt(playerid, const message[])
{
    new string[144];
    format(
        string, sizeof(string), "[Dudas]{DADADA} %s %s (%d): %s",
        g_rgszRankLevelNames[ Player_AdminLevel(playerid) ][ Player_Sex(playerid) ],
        Player_RPName(playerid),
        playerid,
        message
    );

    static 
        Regex:tag_regex,
        Regex:command_regex;
    
    if(!tag_regex)
        tag_regex = Regex_New("\\B@(\\w+)");

    if(!command_regex)
        command_regex = Regex_New("\\B/(\\w+)");

    Regex_Replace(string, tag_regex, "{91B787}@$1{DADADA}", string);
    Regex_Replace(string, command_regex, "{DAA838}/$1{DADADA}", string);

    foreach(new i : LoggedIn)
    {
        if (!Bit_Get(Player_Flags(i), PFLAG_IN_GAME) || !Bit_Get(Player_Config(i), CONFIG_SHOW_DOUBT_CHANNEL))
            continue;

        SendClientMessage(i, 0x91B787FF, string);
    }
    return 1;
}