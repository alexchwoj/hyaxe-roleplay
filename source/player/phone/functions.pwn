#if defined _phone_functions_
    #endinput
#endif
#define _phone_functions_

Phone_Show(playerid, const menu_id[])
{
	Phone_Hide(playerid);
	
    for(new i = 5; i != -1; --i)
    {
        PlayerTextDrawShow(playerid, p_tdPhone[playerid]{i});
    }
    
    for(new i = sizeof(g_tdPhone) - 1; i != -1; --i)
    {
        TextDrawShowForPlayer(playerid, g_tdPhone[i]);
    }

	new hour, minute, year, month, day, weekday_name[3];
	gettime(hour, minute);
	getdate(year, month, day);
	Calendar_GetWeekdayShortName(Calendar_GetWeekDay(year, month, day), weekday_name);
	TextDrawSetStringForPlayer(g_tdPhone[21], playerid, "%s %02i:%02i", weekday_name, hour, minute);

	format(g_rgePlayerMenu[playerid][e_szID], 32, menu_id);
    TogglePlayerControllable(playerid, false);
    Bit_Set(Player_Flags(playerid), PFLAG_USING_PHONE, true);

	g_rgePlayerMenu[playerid][e_iKeyProcessTimer] = SetTimerEx("PHONE_ProcessKey", 100, true, "i", playerid);

	Needs_HideBars(playerid);
    Inventory_Hide(playerid);
	Speedometer_Hide(playerid);

	if (Bit_Get(Player_Config(playerid), CONFIG_ANDROID_MODE))
		Controller_Show(playerid);
		
    return 1;
}

Phone_AddItem(playerid, const text[], color = 0xF7F7F7FF, extra = 0)
{
	if (g_rgePlayerMenu[playerid][e_iTotalListitems] >= MENU_MAX_LISTITEMS)
		return 0;

	strpack(g_rgeMenuListitem[playerid][ g_rgePlayerMenu[playerid][e_iTotalListitems] ][e_szText], text, 32);

	g_rgeMenuListitem[playerid][ g_rgePlayerMenu[playerid][e_iTotalListitems] ][e_iColor] = color;
	g_rgeMenuListitem[playerid][ g_rgePlayerMenu[playerid][e_iTotalListitems] ][e_iExtra] = extra;

    ++g_rgePlayerMenu[playerid][e_iTotalListitems];

	Phone_UpdateListitems(playerid);
	return 1;
}

Phone_UpdateListitems(playerid)
{
	new
		string[64],
		listitem = ((g_rgePlayerMenu[playerid][e_iListitem] + (g_rgePlayerMenu[playerid][e_iPage] * 5)) + 1)
	;

	for (new i; i < 5; i++)
	{
	    listitem = (i + (g_rgePlayerMenu[playerid][e_iPage] * 5));
 		if (listitem >= g_rgePlayerMenu[playerid][e_iTotalListitems])
		{
 			PlayerTextDrawHide(playerid, p_tdPhone[playerid]{i});
	 		continue;
		}

		if (i == g_rgePlayerMenu[playerid][e_iListitem])
  		{
        	PlayerTextDrawColor(playerid, p_tdPhone[playerid]{i}, 255);
        	PlayerTextDrawBoxColor(playerid, p_tdPhone[playerid]{i}, -86);
		}
		else
		{
			PlayerTextDrawColor(playerid, p_tdPhone[playerid]{i}, g_rgeMenuListitem[playerid][listitem][e_iColor] );
        	PlayerTextDrawBoxColor(playerid, p_tdPhone[playerid]{i}, 0x00000000);
		}

	    strunpack(string, g_rgeMenuListitem[playerid][listitem][e_szText]);
	    PlayerTextDrawSetString(playerid, p_tdPhone[playerid]{i}, Str_FixEncoding(string));
        PlayerTextDrawShow(playerid, p_tdPhone[playerid]{i});
	}
	return 1;
}

Phone_Hide(playerid)
{
    TogglePlayerControllable(playerid, true);
    Bit_Set(Player_Flags(playerid), PFLAG_USING_PHONE, false);

    Menu_Hide(playerid);

    for(new i = 5; i != -1; --i)
    {
        PlayerTextDrawHide(playerid, p_tdPhone[playerid]{i});
    }
    
    for(new i = sizeof(g_tdPhone) - 1; i != -1; --i)
    {
        TextDrawHideForPlayer(playerid, g_tdPhone[i]);
    }

	if (Bit_Get(Player_Config(playerid), CONFIG_DISPLAY_SPEEDOMETER))
        Speedometer_Show(playerid);

    if (Bit_Get(Player_Config(playerid), CONFIG_DISPLAY_NEED_BARS))
        Needs_ShowBars(playerid);

	Controller_Hide(playerid);
    return 1;
}

PhoneMenu_Main(playerid)
{
	Phone_Show(playerid, "main");
	Phone_AddItem(playerid, "Mapa");
	Phone_AddItem(playerid, "Cámara");
	Phone_AddItem(playerid, "Mis vehículos");
	Phone_AddItem(playerid, "Remolcar");
	return 1;
}

command sms(playerid, const params[], "Enviar un mensaje SMS a un usuario")
{
	extract params -> new player:destination = 0xFFFF, string:message[144]; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/sms {DADADA}[jugador] [mensaje]");
        return 1;
    }

	if (destination == INVALID_PLAYER_ID || destination == playerid)
        return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Jugador no encontrado");

	if (!Inventory_GetItemCount(playerid, ITEM_PHONE))
		return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No puedes enviar SMS sin un teléfono celular");

	if (!Inventory_GetItemCount(destination, ITEM_PHONE))
		return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "El destinatario no tiene un teléfono celular para recibir el mensaje");

	new messages[2][144];
	format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{64A752}[SMS] › {DADADA}%s (%d) > %s (%d): %s", Player_RPName(playerid), playerid, Player_RPName(destination), destination, message);
	for(new i, j = SplitChatMessageInLines(HYAXE_UNSAFE_HUGE_STRING, messages); i < j; ++i)
	{
		SendClientMessage(destination, 0xDADADAFF, messages[i]);
		SendClientMessage(playerid, 0xDADADAFF, messages[i]);
	}
	
	PlayerPlaySound(destination, 40404);
	return 1;
}
alias:sms("pm", "md", "mp", "short_message_service")