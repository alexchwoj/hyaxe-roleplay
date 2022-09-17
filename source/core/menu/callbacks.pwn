#if defined _menu_callbacks_
    #endinput
#endif
#define _menu_callbacks_

public OnPlayerConnect(playerid)
{
    menuPlayerTextDrawsCount[playerid] = 0;
	playerMenu[playerid][E_PLAYER_MENU_ID][0] = EOS;

    #if defined Menu_OnPlayerConnect
       	return Menu_OnPlayerConnect(playerid);
	#else
	   	return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Menu_OnPlayerConnect
#if defined Menu_OnPlayerConnect
    forward Menu_OnPlayerConnect(playerid);
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(playerMenu[playerid][E_PLAYER_MENU_ID][0] != EOS)
	{
		if (newkeys == KEY_SECONDARY_ATTACK && (GetTickCount() - playerMenu[playerid][E_PLAYER_MENU_TICKCOUNT]) >= 200)
		{
    		playerMenu[playerid][E_PLAYER_MENU_TICKCOUNT] = GetTickCount();
			PlayerPlaySound(playerid, MENU_SOUND_CLOSE, 0.0, 0.0, 0.0);

			new menuid[32] = "menu_";
			strcat(menuid, playerMenu[playerid][E_PLAYER_MENU_ID]);

			for (new i; i < menuPlayerTextDrawsCount[playerid]; i++)
			{
			    PlayerTextDrawDestroy(playerid, menuPlayerTextDraws[playerid][i]);
			}
		    menuPlayerTextDrawsCount[playerid] = 0;
		    playerMenu[playerid][E_PLAYER_MENU_ID][0] = EOS;

			CallLocalFunction(menuid, "iii", playerid, MENU_RESPONSE_CLOSE, (playerMenu[playerid][E_PLAYER_MENU_LISTITEM] + (playerMenu[playerid][E_PLAYER_MENU_PAGE] * MENU_MAX_LISTITEMS_PERPAGE)));
		}
		else if (newkeys == KEY_SPRINT && (GetTickCount() - playerMenu[playerid][E_PLAYER_MENU_TICKCOUNT]) >= 200)
		{
    		playerMenu[playerid][E_PLAYER_MENU_TICKCOUNT] = GetTickCount();
			PlayerPlaySound(playerid, MENU_SOUND_SELECT, 0.0, 0.0, 0.0);

			new menuid[32] = "menu_";
			strcat(menuid, playerMenu[playerid][E_PLAYER_MENU_ID]);

			for (new i; i < menuPlayerTextDrawsCount[playerid]; i++)
			{
			    PlayerTextDrawDestroy(playerid, menuPlayerTextDraws[playerid][i]);
			}
		    menuPlayerTextDrawsCount[playerid] = 0;
		    playerMenu[playerid][E_PLAYER_MENU_ID][0] = EOS;

			CallLocalFunction(menuid, "iii", playerid, MENU_RESPONSE_SELECT, (playerMenu[playerid][E_PLAYER_MENU_LISTITEM] + (playerMenu[playerid][E_PLAYER_MENU_PAGE] * MENU_MAX_LISTITEMS_PERPAGE)));
		}
	}
	
	#if defined Menu_OnPlayerKeyStateChange
       	return Menu_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
	   	return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange Menu_OnPlayerKeyStateChange
#if defined Menu_OnPlayerKeyStateChange
    forward Menu_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
		
public OnPlayerUpdate(playerid)
{
	if(playerMenu[playerid][E_PLAYER_MENU_ID][0] != EOS)
	{
	    new keys, updown, leftright;
		GetPlayerKeys(playerid, keys, updown, leftright);

		#pragma unused leftright
		#pragma unused keys

		if (updown == KEY_DOWN && (GetTickCount() - playerMenu[playerid][E_PLAYER_MENU_TICKCOUNT]) >= 200)
		{
		    new listitem = (playerMenu[playerid][E_PLAYER_MENU_LISTITEM] + (playerMenu[playerid][E_PLAYER_MENU_PAGE] * MENU_MAX_LISTITEMS_PERPAGE));

    		playerMenu[playerid][E_PLAYER_MENU_TICKCOUNT] = GetTickCount();
			PlayerPlaySound(playerid, SOUND_NEXT);

			if ((listitem + 1) == playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS])
			{
				playerMenu[playerid][E_PLAYER_MENU_LISTITEM] = 0;
				playerMenu[playerid][E_PLAYER_MENU_PAGE] = 0;
			}
			//else if ((playerMenu[playerid][E_PLAYER_MENU_LISTITEM] + 1) >= ((playerMenu[playerid][E_PLAYER_MENU_PAGE] + 1) * MENU_MAX_LISTITEMS_PERPAGE))
			else if ((playerMenu[playerid][E_PLAYER_MENU_LISTITEM] + 1) >= MENU_MAX_LISTITEMS_PERPAGE)
			{
				playerMenu[playerid][E_PLAYER_MENU_LISTITEM] = 0;
				playerMenu[playerid][E_PLAYER_MENU_PAGE]++;
			}
			else
			{
				playerMenu[playerid][E_PLAYER_MENU_LISTITEM]++;
			}

			Menu_UpdateListitems(playerid);

			new menuid[32] = "menu_";
			strcat(menuid, playerMenu[playerid][E_PLAYER_MENU_ID]);
			CallLocalFunction(menuid, "iii", playerid, MENU_RESPONSE_DOWN, listitem);
		}
		else if (updown == KEY_UP && (GetTickCount() - playerMenu[playerid][E_PLAYER_MENU_TICKCOUNT]) >= 200)
		{
    		playerMenu[playerid][E_PLAYER_MENU_TICKCOUNT] = GetTickCount();
			PlayerPlaySound(playerid, SOUND_BACK);

    		if ((playerMenu[playerid][E_PLAYER_MENU_LISTITEM] - 1) == -1)
			{
			    if (playerMenu[playerid][E_PLAYER_MENU_PAGE] == 0)
			    {
					playerMenu[playerid][E_PLAYER_MENU_LISTITEM] = ((MENU_MAX_LISTITEMS_PERPAGE - ((MENU_COUNT_PAGES(playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS], MENU_MAX_LISTITEMS_PERPAGE) * MENU_MAX_LISTITEMS_PERPAGE) - playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS])) - 1);
					playerMenu[playerid][E_PLAYER_MENU_PAGE] = (MENU_COUNT_PAGES(playerMenu[playerid][E_PLAYER_MENU_TOTAL_LISTITEMS], MENU_MAX_LISTITEMS_PERPAGE) - 1);
				}
				else
				{
					playerMenu[playerid][E_PLAYER_MENU_LISTITEM] = (MENU_MAX_LISTITEMS_PERPAGE - 1);
					playerMenu[playerid][E_PLAYER_MENU_PAGE]--;
				}
			}
			else
			{
				playerMenu[playerid][E_PLAYER_MENU_LISTITEM]--;
			}

			Menu_UpdateListitems(playerid);

			new menuid[32] = "menu_";
			strcat(menuid, playerMenu[playerid][E_PLAYER_MENU_ID]);
			CallLocalFunction(menuid, "iii", playerid, MENU_RESPONSE_DOWN, (playerMenu[playerid][E_PLAYER_MENU_LISTITEM] + (playerMenu[playerid][E_PLAYER_MENU_PAGE] * MENU_MAX_LISTITEMS_PERPAGE)));
		}
	}

	#if defined Menu_OnPlayerUpdate
       	return Menu_OnPlayerUpdate(playerid);
	#else
	   	return 1;
	#endif
}
#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#else
    #define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate Menu_OnPlayerUpdate
#if defined Menu_OnPlayerUpdate
    forward Menu_OnPlayerUpdate(playerid);
#endif