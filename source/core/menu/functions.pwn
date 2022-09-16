#if defined _menu_functions_
    #endinput
#endif
#define _menu_functions_

Internal_UpdateListitemInfo(playerid)
{
	new listitemid = (playerMenu[playerid][E_PLAYER_MENU_LISTITEM] + (playerMenu[playerid][E_PLAYER_MENU_PAGE] * MENU_MAX_LISTITEMS_PERPAGE));
	if (playerMenuListitemsInfo[playerid][listitemid]{0})
	{
        PlayerTextDrawShow(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_INFO_BOX]]);
        PlayerTextDrawShow(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_INFO_ICON]]);

	    new string[MENU_MAX_LISTITEM_SIZE];
	    strunpack(string, playerMenuListitemsInfo[playerid][listitemid]);
	    PlayerTextDrawSetString(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_INFO_TEXT]], string);
        PlayerTextDrawShow(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_INFO_TEXT]]);
	}
	else
	{
        PlayerTextDrawHide(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_INFO_BOX]]);
        PlayerTextDrawHide(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_INFO_ICON]]);
		PlayerTextDrawHide(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_INFO_TEXT]]);
	}
}

Internal_UpdateListitems(playerid)
{
	new string[MENU_MAX_LISTITEM_SIZE];
	new listitem = ((playerMenu[playerid][E_PLAYER_MENU_LISTITEM] + (playerMenu[playerid][E_PLAYER_MENU_PAGE] * MENU_MAX_LISTITEMS_PERPAGE)) + 1);
    format(string, sizeof string, "%i/%i", listitem, playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS]);
	PlayerTextDrawSetString(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_LISTITEM_COUNT]], string);

	for (new i; i < MENU_MAX_LISTITEMS_PERPAGE; i++)
	{
	    listitem = (i + (playerMenu[playerid][E_PLAYER_MENU_PAGE] * MENU_MAX_LISTITEMS_PERPAGE));
 		if (listitem >= playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS])
		{
 			PlayerTextDrawHide(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_LISTITEMS][i]]);
	 		continue;
		}

		if (i == playerMenu[playerid][E_PLAYER_MENU_LISTITEM])
  		{
        	PlayerTextDrawColor(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_LISTITEMS][i]], 255);
        	PlayerTextDrawBoxColor(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_LISTITEMS][i]], -86);
		}
		else
		{
        	PlayerTextDrawColor(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_LISTITEMS][i]], -1);
        	PlayerTextDrawBoxColor(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_LISTITEMS][i]], 175);
		}

	    strunpack(string, playerMenuListitems[playerid][listitem]);
	    PlayerTextDrawSetString(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_LISTITEMS][i]], string);
        PlayerTextDrawShow(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_LISTITEMS][i]]);
	}

	Internal_UpdateListitemInfo(playerid);
}

/*
native ShowPlayerMenu(playerid, menuid[], caption[], type[] = "Interaction Menu", captionTextColor = -926365441, captionBoxColor = -1522452536);
*/
#define ShowPlayerMenu(%0,%1, \
	Internal_ShowPlayerMenu(%0, #%1,

stock Internal_ShowPlayerMenu(playerid, menuid[], caption[], type[] = "SELECCIONE UNA OPCIÓN", captionTextColor = 0x1B1B1BFF, captionBoxColor = 0xAC3E36FF, bool:clearChat = false)
{
	if (playerid < 0 || playerid >= MAX_PLAYERS)
	{
	    return 0;
	}

	PlayerPlaySound(playerid, SOUND_BUTTON);

	if (clearChat)
		Chat_Clear(playerid);

	Notification_DestroyAll(playerid);

	for (new i; i < menuPlayerTextDrawsCount[playerid]; i++)
	{
	    PlayerTextDrawDestroy(playerid, menuPlayerTextDraws[playerid][i]);
	}
    menuPlayerTextDrawsCount[playerid] = 0;

    /*menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,12.000000, 141.000000, "");
	PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 255);
	PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 4);
	PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.000000, 4.000000);
	PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0xFFFFFF00);
	PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawUseBox(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawBoxColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawTextSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 139.000000, 40.000000);
	PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawShow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]++]);*/

	menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,13.000000, 143.000000, "_box");
	PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 255);
	PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.000000, 4.000000);
	PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], -1);
	PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawUseBox(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawBoxColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], captionBoxColor);
	PlayerTextDrawTextSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 150.000000, 0.000000);
	PlayerTextDrawShow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]]);
	PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]++], 0);

	menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,16.000000, 151.000000, caption);
	PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.399998, 2.299998);
	PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], captionTextColor);
	PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawShow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]++]);

	menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,13.000000, 182.000000, "_box");
	PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.000000, 1.200000);
	PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawUseBox(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawBoxColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0x1B1B1BFF);
	PlayerTextDrawTextSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 150.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawShow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]++]);

	for (new i; type[i] != EOS; i++)
	{
	    toupper(type[i]);
	}
	menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,14.000000, 183.000000, Str_FixEncoding(type));
	PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.189998, 1.000000);
	PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0xf7f7f7ff);
	PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawShow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]++]);

	menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,149.000000, 183.000000, "-/-");
	PlayerTextDrawAlignment(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 3);
	PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.189998, 1.000000);
	PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0xf7f7f7ff);
	PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawShow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]]);
	menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_LISTITEM_COUNT] = menuPlayerTextDrawsCount[playerid]++;

	menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,13.000000, 196.000000, "_box");
	PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.159999, (1.999999 + (1.6 * (MENU_MAX_LISTITEMS_PERPAGE - 1))));
	PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawUseBox(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawBoxColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 421075400);
	PlayerTextDrawTextSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 150.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawShow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]++]);

	for (new i; i < MENU_MAX_LISTITEMS_PERPAGE; i++)
	{
		menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,13.000000, (196.000000 + (15 * i)), "_");
		PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
		PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
		PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.230000, 1.399999);
		PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], -1);
		PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
		PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
		PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
		PlayerTextDrawUseBox(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
		PlayerTextDrawBoxColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 175);
		PlayerTextDrawTextSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 150.000000, 0.000000);
		PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
		menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_LISTITEMS][i] = menuPlayerTextDrawsCount[playerid]++;
	}

	menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,13.000000, 319.000000, "_box");
	PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.159999, 1.999999);
	PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawUseBox(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawBoxColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 421075400);
	PlayerTextDrawTextSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 150.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_INFO_BOX] = menuPlayerTextDrawsCount[playerid]++;

	menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,13.000000, 319.000000, "_model");
	PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 5);
	PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.159999, 0.899999);
	PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], -1);
	PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawUseBox(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawBoxColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawTextSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 10.000000, 10.000000);
	PlayerTextDrawSetPreviewModel(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1239);
	PlayerTextDrawSetPreviewRot(playerid, menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_INFO_ICON] = menuPlayerTextDrawsCount[playerid]++;

	menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]] = CreatePlayerTextDraw(playerid,23.000000, 319.000000, "Write listitem info here");
	PlayerTextDrawBackgroundColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawFont(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawLetterSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0.159999, 0.899999);
	PlayerTextDrawColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], -1);
	PlayerTextDrawSetOutline(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawSetProportional(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawSetShadow(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawUseBox(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 1);
	PlayerTextDrawBoxColor(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	PlayerTextDrawTextSize(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 150.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,menuPlayerTextDraws[playerid][menuPlayerTextDrawsCount[playerid]], 0);
	menuPlayerTextDrawsID[playerid][E_MENU_TEXTDRAW_INFO_TEXT] = menuPlayerTextDrawsCount[playerid]++;

	format(playerMenu[playerid][E_PLAYER_MENU_ID], 32, menuid);
	playerMenu[playerid][E_PLAYER_MENU_PAGE] = 0;
	playerMenu[playerid][E_PLAYER_MENU_LISTITEM] = 0;
	playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS] = 0;
	playerMenu[playerid][E_PLAYER_MENU_TICKCOUNT] = 0;
	return 1;
}

/*
native AddPlayerMenuItem(playerid, text[], info[] = "");
*/
stock AddPlayerMenuItem(playerid, text[], info[] = "")
{
	if (playerid < 0 || playerid >= MAX_PLAYERS)
	{
	    return 0;
	}

	if (!playerMenu[playerid][E_PLAYER_MENU_ID][0])
	{
	    return 0;
	}

	if (playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS] == MENU_MAX_LISTITEMS)
	{
	    return 0;
	}

	strpack(playerMenuListitems[playerid][playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS]], text, MENU_MAX_LISTITEM_SIZE);
	strpack(playerMenuListitemsInfo[playerid][playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS]], info, MENU_MAX_LISTITEM_SIZE);
    playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS]++;

    Internal_UpdateListitems(playerid);
    return 1;
}

/*
native HidePlayerMenu(playerid);
*/
stock HidePlayerMenu(playerid)
{
	if (playerid < 0 || playerid >= MAX_PLAYERS)
	{
	    return 0;
	}

    for (new i; i < menuPlayerTextDrawsCount[playerid]; i++)
	{
	    PlayerTextDrawDestroy(playerid, menuPlayerTextDraws[playerid][i]);
	}
    menuPlayerTextDrawsCount[playerid] = 0;

    playerMenu[playerid][E_PLAYER_MENU_ID][0] = EOS;
	return 1;
}