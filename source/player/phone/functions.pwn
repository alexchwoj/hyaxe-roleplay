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

	format(g_rgePlayerMenu[playerid][e_szID], 32, menu_id);
    TogglePlayerControllable(playerid, false);
    Bit_Set(Player_Flags(playerid), PFLAG_USING_PHONE, true);

	g_rgePlayerMenu[playerid][e_iKeyProcessTimer] = SetTimerEx("PHONE_ProcessKey", 100, true, "i", playerid);
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
    return 1;
}

PhoneMenu_Main(playerid)
{
	Phone_Show(playerid, "main");
	Phone_AddItem(playerid, "Mapa");
	Phone_AddItem(playerid, "Cámara");
	Phone_AddItem(playerid, "Mis vehículos");
	return 1;
}