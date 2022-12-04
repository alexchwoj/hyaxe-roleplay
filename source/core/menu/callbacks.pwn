#if defined _menu_callbacks_
    #endinput
#endif
#define _menu_callbacks_

public OnPlayerDisconnect(playerid, reason)
{
	KillTimer(g_rgePlayerMenu[playerid][e_iKeyProcessTimer]);
	g_rgePlayerMenu[playerid] = g_rgePlayerMenu[MAX_PLAYERS];
	g_rgiMenuTextDrawsID[playerid] = g_rgiMenuTextDrawsID[MAX_PLAYERS];

	for (new i; i < g_rgePlayerMenu[playerid][e_iTextdrawCount]; ++i)
		PlayerTextDrawDestroy(playerid, g_rgiMenuTextDraws[playerid][i]);

	g_rgiMenuTextDraws[playerid] = g_rgiMenuTextDraws[MAX_PLAYERS];

	#if defined MENU_OnPlayerDisconnect
		return MENU_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect MENU_OnPlayerDisconnect
#if defined MENU_OnPlayerDisconnect
	forward MENU_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (g_rgePlayerMenu[playerid][e_iEnabled])
	{
		if (newkeys == KEY_SECONDARY_ATTACK && (GetTickCount() - g_rgePlayerMenu[playerid][e_iLastTick]) >= 160) // Enter
		{
			g_rgePlayerMenu[playerid][e_iLastTick] = GetTickCount();
			PlayerPlaySound(playerid, SOUND_BUTTON);
			Menu_SendResponse(playerid, MENU_RESPONSE_CLOSE);
		}
		else if (newkeys == KEY_SPRINT && (GetTickCount() - g_rgePlayerMenu[playerid][e_iLastTick]) >= 160) // Space
		{
			g_rgePlayerMenu[playerid][e_iLastTick] = GetTickCount();
			PlayerPlaySound(playerid, SOUND_BUTTON);
			Menu_SendResponse(playerid, MENU_RESPONSE_SELECT);
    	}
	}

	#if defined MENU_OnPlayerKeyStateChange
		return MENU_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange MENU_OnPlayerKeyStateChange
#if defined MENU_OnPlayerKeyStateChange
	forward MENU_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


forward MENU_ProcessKey(playerid);
public MENU_ProcessKey(playerid)
{
	if (g_rgePlayerMenu[playerid][e_iEnabled])
	{
		new keys, updown, leftright;
		GetPlayerWrappedKeys(playerid, keys, updown, leftright);

		#pragma unused leftright
		#pragma unused keys

		if (updown == KEY_DOWN && (GetTickCount() - g_rgePlayerMenu[playerid][e_iLastTick]) >= 160)
		{
			new listitem = (g_rgePlayerMenu[playerid][e_iListitem] + (g_rgePlayerMenu[playerid][e_iPage] * MENU_MAX_LISTITEMS_PERPAGE));

			g_rgePlayerMenu[playerid][e_iLastTick] = GetTickCount();
			PlayerPlaySound(playerid, SOUND_NEXT);

			if ((listitem + 1) == g_rgePlayerMenu[playerid][e_iTotalListitems])
			{
				g_rgePlayerMenu[playerid][e_iListitem] = 0;
				g_rgePlayerMenu[playerid][e_iPage] = 0;
			}
			else if ((g_rgePlayerMenu[playerid][e_iListitem] + 1) >= MENU_MAX_LISTITEMS_PERPAGE)
			{
				g_rgePlayerMenu[playerid][e_iListitem] = 0;
				++g_rgePlayerMenu[playerid][e_iPage];
			}
			else
				++g_rgePlayerMenu[playerid][e_iListitem];

			Menu_UpdateListitems(playerid);
			Menu_SendResponse(playerid, MENU_RESPONSE_DOWN);
		}
		else if (updown == KEY_UP && (GetTickCount() - g_rgePlayerMenu[playerid][e_iLastTick]) >= 160)
		{
			g_rgePlayerMenu[playerid][e_iLastTick] = GetTickCount();
			PlayerPlaySound(playerid, SOUND_BACK);

			if ((g_rgePlayerMenu[playerid][e_iListitem] - 1) == -1)
			{
			    if (g_rgePlayerMenu[playerid][e_iPage] == 0)
			    {
					g_rgePlayerMenu[playerid][e_iListitem] = ((MENU_MAX_LISTITEMS_PERPAGE - ((MENU_COUNT_PAGES(g_rgePlayerMenu[playerid][e_iTotalListitems], MENU_MAX_LISTITEMS_PERPAGE) * MENU_MAX_LISTITEMS_PERPAGE) - g_rgePlayerMenu[playerid][e_iTotalListitems])) - 1);
					g_rgePlayerMenu[playerid][e_iPage] = (MENU_COUNT_PAGES(g_rgePlayerMenu[playerid][e_iTotalListitems], MENU_MAX_LISTITEMS_PERPAGE) - 1);
				}
				else
				{
					g_rgePlayerMenu[playerid][e_iListitem] = (MENU_MAX_LISTITEMS_PERPAGE - 1);
					--g_rgePlayerMenu[playerid][e_iPage];
				}
			}
			else
				--g_rgePlayerMenu[playerid][e_iListitem];

			Menu_UpdateListitems(playerid);
			Menu_SendResponse(playerid, MENU_RESPONSE_UP);
		}
	}

    return 1;
}