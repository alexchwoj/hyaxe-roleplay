#if defined _menu_functions_
    #endinput
#endif
#define _menu_functions_

Menu_Show(playerid, const menu_id[], const caption[], const type[] = "SELECCIONE UNA OPCIÓN", captionTextColor = 0x1B1B1BFF, captionBoxColor = 0xAC3E36FF)
{
	Chat_Clear(playerid);
	TogglePlayerControllable(playerid, false);
	PlayerPlaySound(playerid, SOUND_BUTTON);

	Player_DisableChat(playerid, true);
	Notification_DestroyAll(playerid);

	for (new i; i < g_rgePlayerMenu[playerid][e_iTextdrawCount]; ++i)
		PlayerTextDrawDestroy(playerid, g_rgiMenuTextDraws[playerid][i]);

    g_rgePlayerMenu[playerid][e_iTextdrawCount] = 0;

	// Title
	g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ] = CreatePlayerTextDraw(playerid, 13.000000, 15.000000, "_box");
	PlayerTextDrawBackgroundColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 255);
	PlayerTextDrawFont(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawLetterSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.000000, 4.000000);
	PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], -1);
	PlayerTextDrawSetOutline(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetProportional(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetShadow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawUseBox(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawBoxColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], captionBoxColor);
	PlayerTextDrawTextSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 150.000000, 0.000000);
	PlayerTextDrawShow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ]);
	PlayerTextDrawSetSelectable(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount]++ ], 0);

	g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ] = CreatePlayerTextDraw(playerid, 16.000000, 23.000000, Str_FixEncoding(caption));
	PlayerTextDrawBackgroundColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawFont(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawLetterSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.399998, 2.299998);
	PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], captionTextColor);
	PlayerTextDrawSetOutline(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetProportional(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetShadow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetSelectable(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawShow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount]++ ]);

	g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ] = CreatePlayerTextDraw(playerid, 13.000000, 55.000000, "_box");
	PlayerTextDrawBackgroundColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawFont(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawLetterSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.000000, 1.200000);
	PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetOutline(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetProportional(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetShadow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawUseBox(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawBoxColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0x000000AA);
	PlayerTextDrawTextSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 150.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawShow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount]++ ]);

	// Subtitle
	g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ] = CreatePlayerTextDraw(playerid, 14.000000, 55.000000, Str_FixEncoding(type));
	PlayerTextDrawBackgroundColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawFont(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawLetterSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.189998, 1.000000);
	PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0xf7f7f7ff);
	PlayerTextDrawSetOutline(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetProportional(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetShadow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetSelectable(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawShow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount]++ ]);

	g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ] = CreatePlayerTextDraw(playerid, 149.000000, 55.000000, "-/-");
	PlayerTextDrawAlignment(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 3);
	PlayerTextDrawBackgroundColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawFont(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawLetterSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.189998, 1.000000);
	PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0xf7f7f7ff);
	PlayerTextDrawSetOutline(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetProportional(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetShadow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetSelectable(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawShow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ]);
	g_rgiMenuTextDrawsID[playerid][e_tdListitemCount] = g_rgePlayerMenu[playerid][e_iTextdrawCount]++;

	g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ] = CreatePlayerTextDraw(playerid, 13.000000, 70.000000, "_box");
	PlayerTextDrawBackgroundColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawFont(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawLetterSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.159999, (1.999999 + (1.6 * (MENU_MAX_LISTITEMS_PERPAGE - 1))));
	PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetOutline(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetProportional(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetShadow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawUseBox(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawBoxColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0x00000088);
	PlayerTextDrawTextSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 150.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawShow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount]++ ]);

	for (new i; i < MENU_MAX_LISTITEMS_PERPAGE; i++)
	{
		g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ] = CreatePlayerTextDraw(playerid, 13.000000, (70.000000 + (15 * i)), "_");
		PlayerTextDrawBackgroundColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
		PlayerTextDrawFont(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
		PlayerTextDrawLetterSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.230000, 1.399999);
		PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], -1);
		PlayerTextDrawSetOutline(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
		PlayerTextDrawSetProportional(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
		PlayerTextDrawSetShadow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
		PlayerTextDrawUseBox(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
		PlayerTextDrawBoxColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0x00000000);
		PlayerTextDrawTextSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 150.000000, 0.000000);
		PlayerTextDrawSetSelectable(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
		g_rgiMenuTextDrawsID[playerid][e_tdListitems][i] = g_rgePlayerMenu[playerid][e_iTextdrawCount]++;
	}

	g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ] = CreatePlayerTextDraw(playerid, 13.000000, 195.000000, "_box");
	PlayerTextDrawBackgroundColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawFont(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawLetterSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.159999, 1.999999);
	PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetOutline(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetProportional(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetShadow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawUseBox(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawBoxColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0x00000088);
	PlayerTextDrawTextSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 150.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	g_rgiMenuTextDrawsID[playerid][e_tdInfoBox] = g_rgePlayerMenu[playerid][e_iTextdrawCount]++;

	g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ] = CreatePlayerTextDraw(playerid, 13.000000, 900.000000, "_model");
	PlayerTextDrawBackgroundColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawFont(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 5);
	PlayerTextDrawLetterSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.159999, 0.899999);
	PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], -1);
	PlayerTextDrawSetOutline(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetProportional(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetShadow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawUseBox(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawBoxColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawTextSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 10.000000, 10.000000);
	PlayerTextDrawSetPreviewModel(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1239);
	PlayerTextDrawSetPreviewRot(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	g_rgiMenuTextDrawsID[playerid][e_tdInfoIcon] = g_rgePlayerMenu[playerid][e_iTextdrawCount]++;

	g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ] = CreatePlayerTextDraw(playerid, 13.000000, 200.000000, "_");
	PlayerTextDrawBackgroundColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawFont(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawLetterSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0.159999, 0.899999);
	PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], -1);
	PlayerTextDrawSetOutline(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawSetProportional(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawSetShadow(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawUseBox(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 1);
	PlayerTextDrawBoxColor(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	PlayerTextDrawTextSize(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 150.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, g_rgiMenuTextDraws[playerid][ g_rgePlayerMenu[playerid][e_iTextdrawCount] ], 0);
	g_rgiMenuTextDrawsID[playerid][e_tdInfoText] = g_rgePlayerMenu[playerid][e_iTextdrawCount]++;

	// Reset menu
	KillTimer(g_rgePlayerMenu[playerid][e_iKeyProcessTimer]);
	format(g_rgePlayerMenu[playerid][e_szID], 32, menu_id);
	g_rgePlayerMenu[playerid][e_iPage] = 0;
	g_rgePlayerMenu[playerid][e_iListitem] = 0;
	g_rgePlayerMenu[playerid][e_iTotalListitems] = 0;
	g_rgePlayerMenu[playerid][e_iLastTick] = 0;

	g_rgePlayerMenu[playerid][e_iKeyProcessTimer] = SetTimerEx("MENU_ProcessKey", 100, true, "i", playerid);
	g_rgePlayerMenu[playerid][e_iEnabled] = true;
	return 1;
}

Menu_Hide(playerid)
{
	g_rgePlayerMenu[playerid][e_iEnabled] = false;

	Player_DisableChat(playerid, false);

	TogglePlayerControllable(playerid, true);
	KillTimer(g_rgePlayerMenu[playerid][e_iKeyProcessTimer]);

    for (new i; i < g_rgePlayerMenu[playerid][e_iTextdrawCount]; ++i)
		PlayerTextDrawDestroy(playerid, g_rgiMenuTextDraws[playerid][i]);

    g_rgePlayerMenu[playerid][e_iTextdrawCount] = 0;
    g_rgePlayerMenu[playerid] = g_rgePlayerMenu[MAX_PLAYERS];
	return 1;
}

Menu_AddItem(playerid, const text[], const info[] = "", color = 0xF7F7F7FF, extra = 0)
{
	if (g_rgePlayerMenu[playerid][e_iTotalListitems] >= MENU_MAX_LISTITEMS)
		return 0;

	strpack(g_rgeMenuListitem[playerid][ g_rgePlayerMenu[playerid][e_iTotalListitems] ][e_szText], text, 32);
	strpack(g_rgeMenuListitem[playerid][ g_rgePlayerMenu[playerid][e_iTotalListitems] ][e_szInfo], info, 32);

	g_rgeMenuListitem[playerid][ g_rgePlayerMenu[playerid][e_iTotalListitems] ][e_iColor] = color;
	g_rgeMenuListitem[playerid][ g_rgePlayerMenu[playerid][e_iTotalListitems] ][e_iExtra] = extra;

    ++g_rgePlayerMenu[playerid][e_iTotalListitems];
	return 1;
}

Menu_UpdateListitems(playerid)
{
	new
		string[64],
		listitem = ((g_rgePlayerMenu[playerid][e_iListitem] + (g_rgePlayerMenu[playerid][e_iPage] * MENU_MAX_LISTITEMS_PERPAGE)) + 1)
	;

    format(string, sizeof(string), "%d/%d", listitem, g_rgePlayerMenu[playerid][e_iTotalListitems]);
	PlayerTextDrawSetString(playerid, g_rgiMenuTextDraws[playerid][ g_rgiMenuTextDrawsID[playerid][e_tdListitemCount] ], string);

	// Main title
	for (new i; i < MENU_MAX_LISTITEMS_PERPAGE; i++)
	{
	    listitem = (i + (g_rgePlayerMenu[playerid][e_iPage] * MENU_MAX_LISTITEMS_PERPAGE));
 		if (listitem >= g_rgePlayerMenu[playerid][e_iTotalListitems])
		{
 			PlayerTextDrawHide(playerid, g_rgiMenuTextDraws[playerid][ g_rgiMenuTextDrawsID[playerid][e_tdListitems][i] ]);
	 		continue;
		}

		if (i == g_rgePlayerMenu[playerid][e_iListitem])
  		{
        	PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][g_rgiMenuTextDrawsID[playerid][e_tdListitems][i]], 255);
        	PlayerTextDrawBoxColor(playerid, g_rgiMenuTextDraws[playerid][g_rgiMenuTextDrawsID[playerid][e_tdListitems][i]], -86);
		}
		else
		{
			PlayerTextDrawColor(playerid, g_rgiMenuTextDraws[playerid][g_rgiMenuTextDrawsID[playerid][e_tdListitems][i]], g_rgeMenuListitem[playerid][listitem][e_iColor] );
        	PlayerTextDrawBoxColor(playerid, g_rgiMenuTextDraws[playerid][g_rgiMenuTextDrawsID[playerid][e_tdListitems][i]], 0x00000000);
		}

	    strunpack(string, g_rgeMenuListitem[playerid][listitem][e_szText]);
	    PlayerTextDrawSetString(playerid, g_rgiMenuTextDraws[playerid][g_rgiMenuTextDrawsID[playerid][e_tdListitems][i]], Str_FixEncoding(string));
        PlayerTextDrawShow(playerid, g_rgiMenuTextDraws[playerid][g_rgiMenuTextDrawsID[playerid][e_tdListitems][i]]);
	}

	// Sub title
	listitem = (g_rgePlayerMenu[playerid][e_iListitem] + (g_rgePlayerMenu[playerid][e_iPage] * MENU_MAX_LISTITEMS_PERPAGE));
	strunpack(string, g_rgeMenuListitem[playerid][listitem][e_szInfo]);

	if (strlen(string))
	{
        PlayerTextDrawShow(playerid, g_rgiMenuTextDraws[playerid][ g_rgiMenuTextDrawsID[playerid][e_tdInfoBox] ]);
        PlayerTextDrawShow(playerid, g_rgiMenuTextDraws[playerid][ g_rgiMenuTextDrawsID[playerid][e_tdInfoIcon] ]);

	    PlayerTextDrawSetString(playerid, g_rgiMenuTextDraws[playerid][ g_rgiMenuTextDrawsID[playerid][e_tdInfoText] ], Str_FixEncoding(string));
        PlayerTextDrawShow(playerid, g_rgiMenuTextDraws[playerid][ g_rgiMenuTextDrawsID[playerid][e_tdInfoText] ]);
	}
	else
	{
        PlayerTextDrawHide(playerid, g_rgiMenuTextDraws[playerid][ g_rgiMenuTextDrawsID[playerid][e_tdInfoBox] ]);
        PlayerTextDrawHide(playerid, g_rgiMenuTextDraws[playerid][ g_rgiMenuTextDrawsID[playerid][e_tdInfoIcon] ]);
		PlayerTextDrawHide(playerid, g_rgiMenuTextDraws[playerid][ g_rgiMenuTextDrawsID[playerid][e_tdInfoText] ]);
	}
	return 1;
}

Menu_SendResponse(playerid, response)
{
	if (!g_rgePlayerMenu[playerid][e_iEnabled])
		return 0;

	new menu_id[32] = "menu_";
	strcat(menu_id, g_rgePlayerMenu[playerid][e_szID]);

	if (response != MENU_RESPONSE_UP && response != MENU_RESPONSE_DOWN)
	{
		KillTimer(g_rgePlayerMenu[playerid][e_iKeyProcessTimer]);
		for (new i; i < g_rgePlayerMenu[playerid][e_iTextdrawCount]; ++i)
			PlayerTextDrawDestroy(playerid, g_rgiMenuTextDraws[playerid][i]);

		g_rgePlayerMenu[playerid][e_iTextdrawCount] = 0;
		g_rgePlayerMenu[playerid][e_iEnabled] = false;
		TogglePlayerControllable(playerid, true);

		Menu_Hide(playerid);
	}

	CallLocalFunction(menu_id, "iii", playerid, response, (g_rgePlayerMenu[playerid][e_iListitem] + (g_rgePlayerMenu[playerid][e_iPage] * MENU_MAX_LISTITEMS_PERPAGE)));
	return 1;
}