#if defined _phone_callbacks_
    #endinput
#endif
#define _phone_callbacks_

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (Bit_Get(Player_Flags(playerid), PFLAG_USING_PHONE))
	{
		new menu_id[32] = "phone_";
		strcat(menu_id, g_rgePlayerMenu[playerid][e_szID]);

		if (newkeys == KEY_SECONDARY_ATTACK && (GetTickCount() - g_rgePlayerMenu[playerid][e_iLastTick]) >= 160) // Enter
		{
			PlayerPlaySound(playerid, SOUND_BUTTON);
			CallLocalFunction(menu_id, "iii", playerid, 0, (g_rgePlayerMenu[playerid][e_iListitem] + (g_rgePlayerMenu[playerid][e_iPage] * 5)));
            Phone_Hide(playerid);
		}
		else if (newkeys == KEY_SPRINT && (GetTickCount() - g_rgePlayerMenu[playerid][e_iLastTick]) >= 160) // Space
		{
			PlayerPlaySound(playerid, SOUND_BUTTON);
			CallLocalFunction(menu_id, "iii", playerid, 1, (g_rgePlayerMenu[playerid][e_iListitem] + (g_rgePlayerMenu[playerid][e_iPage] * 5)));
    	}
	}

	if (Bit_Get(Player_Flags(playerid), PFLAG_USING_CAMERA))
	{
		if (newkeys == KEY_SECONDARY_ATTACK)
		{
			ClearAnimations(playerid, 1);
			Bit_Set(Player_Flags(playerid), PFLAG_USING_CAMERA, false);
            Phone_Hide(playerid);
			SetCameraBehindPlayer(playerid);
			ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 1, 1, 1, 0, 1000, 1);
		}
	}

	#if defined PHONE_OnPlayerKeyStateChange
		return PHONE_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange PHONE_OnPlayerKeyStateChange
#if defined PHONE_OnPlayerKeyStateChange
	forward PHONE_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


forward PHONE_ProcessKey(playerid);
public PHONE_ProcessKey(playerid)
{
	if (Bit_Get(Player_Flags(playerid), PFLAG_USING_PHONE))
	{
		new keys, updown, leftright;
		GetPlayerWrappedKeys(playerid, keys, updown, leftright);

		#pragma unused leftright
		#pragma unused keys

		if (updown == KEY_DOWN && (GetTickCount() - g_rgePlayerMenu[playerid][e_iLastTick]) >= 160)
		{
			new listitem = (g_rgePlayerMenu[playerid][e_iListitem] + (g_rgePlayerMenu[playerid][e_iPage] * 5));

			g_rgePlayerMenu[playerid][e_iLastTick] = GetTickCount();
			PlayerPlaySound(playerid, SOUND_NEXT);

			if ((listitem + 1) == g_rgePlayerMenu[playerid][e_iTotalListitems])
			{
				g_rgePlayerMenu[playerid][e_iListitem] = 0;
				g_rgePlayerMenu[playerid][e_iPage] = 0;
			}
			else if ((g_rgePlayerMenu[playerid][e_iListitem] + 1) >= 5)
			{
				g_rgePlayerMenu[playerid][e_iListitem] = 0;
				++g_rgePlayerMenu[playerid][e_iPage];
			}
			else
				++g_rgePlayerMenu[playerid][e_iListitem];

			Phone_UpdateListitems(playerid);
		}
		else if (updown == KEY_UP && (GetTickCount() - g_rgePlayerMenu[playerid][e_iLastTick]) >= 160)
		{
			g_rgePlayerMenu[playerid][e_iLastTick] = GetTickCount();
			PlayerPlaySound(playerid, SOUND_BACK);

			if ((g_rgePlayerMenu[playerid][e_iListitem] - 1) == -1)
			{
			    if (g_rgePlayerMenu[playerid][e_iPage] == 0)
			    {
					g_rgePlayerMenu[playerid][e_iListitem] = ((5 - ((MENU_COUNT_PAGES(g_rgePlayerMenu[playerid][e_iTotalListitems], 5) * 5) - g_rgePlayerMenu[playerid][e_iTotalListitems])) - 1);
					g_rgePlayerMenu[playerid][e_iPage] = (MENU_COUNT_PAGES(g_rgePlayerMenu[playerid][e_iTotalListitems], 5) - 1);
				}
				else
				{
					g_rgePlayerMenu[playerid][e_iListitem] = (5 - 1);
					--g_rgePlayerMenu[playerid][e_iPage];
				}
			}
			else
				--g_rgePlayerMenu[playerid][e_iListitem];

			Phone_UpdateListitems(playerid);
		}
	}

    return 1;
}

phone_menu main(playerid, response, listitem)
{
	switch (listitem)
	{
		case 0: Player_ShowGPS(playerid);
		case 1:
		{
			if (IsPlayerInAnyVehicle(playerid))
			{
				PhoneMenu_Main(playerid);
				Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No puedes hacer esto mientras estás en un vehículo");
				return 0;
			}

			Phone_Hide(playerid);

			Bit_Set(Player_Flags(playerid), PFLAG_USING_CAMERA, true);
			TogglePlayerControllable(playerid, false);

			ApplyAnimation(playerid, "PED", "gang_gunstand", 4.1, 1, 1, 1, 1, 1, 1);

			new Float:x, Float:y, Float:z, Float:angle;
			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, angle);
			GetXYFromAngle(x, y, angle, 0.8);

			SetPlayerCameraPos(playerid, x, y, z + 0.8);

			GetPlayerPos(playerid, x, y, z);
      		SetPlayerCameraLookAt(playerid, x, y, z + 0.8);

			Sound_PlayInRange(1132, 10.0, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
		}
		case 2:
		{
			if (!Iter_Count(PlayerVehicles[playerid]))
			{
				PhoneMenu_Main(playerid);
				Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No tienes vehículos");
				return 0;
			}

			Phone_Show(playerid, "my_vehicles");

			foreach(new vehicleid : PlayerVehicles[playerid])
			{
				if (!g_rgeVehicles[vehicleid][e_bValid])
					continue;

				GetVehiclePos(vehicleid, g_rgeVehicles[vehicleid][e_fPosX], g_rgeVehicles[vehicleid][e_fPosY], g_rgeVehicles[vehicleid][e_fPosZ]);
				new Float:distance = GetPlayerDistanceFromPoint(playerid, g_rgeVehicles[vehicleid][e_fPosX], g_rgeVehicles[vehicleid][e_fPosY], g_rgeVehicles[vehicleid][e_fPosZ]);

				new line[32];
				format(line, sizeof(line), "%s (%.0fKm)", g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_szModelName], distance * 0.01);
				Phone_AddItem(playerid, line, .extra = vehicleid);
			}
		}
		case 3:
		{
			if (!Iter_Count(PlayerVehicles[playerid]))
			{
				PhoneMenu_Main(playerid);
				Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No tienes vehículos");
				return 0;
			}

			Phone_Show(playerid, "crane");

			foreach(new vehicleid : PlayerVehicles[playerid])
			{
				if (!g_rgeVehicles[vehicleid][e_bValid])
					continue;

				new line[32];
				format(line, sizeof(line), "%s", g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_szModelName]);
				Phone_AddItem(playerid, line, .extra = vehicleid);
			}
		}
		case 4:
		{
			Phone_Hide(playerid);

			inline const FixedShow()
			{
				ATM_ShowMenu(playerid);
			}
			Timer_CreateCallback(using inline FixedShow, GetPlayerPing(playerid), 1);
			
		}
	}
	return 1;
}

phone_menu crane(playerid, response, listitem)
{
	if (!response)
		return Player_ShowGPS(playerid);

	if (!Iter_Count(PlayerVehicles[playerid]))
	{
		PhoneMenu_Main(playerid);
		Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No tienes vehículos");
		return 0;
	}

	new vehicleid = Listitem_Extra(listitem);
	if (!IsValidVehicle(vehicleid))
	{
		PhoneMenu_Main(playerid);
		Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "El vehículo se encuentra destruido");
		return 0;
	}

	if (Player_VIP(playerid) < 3)
	{
		if (Player_Money(playerid) < 500)
		{
			PhoneMenu_Main(playerid);
			Notification_ShowBeatingText(playerid, 5000, 0xED2B2B, 100, 255, "No tienes dinero para remolcar tu vehículo ($500)");
			return 1;
		}
		Player_GiveMoney(playerid, -500);
	}
	else
		Notification_Show(playerid, "¡No te han cobrado la grúa porque eres VIP Super!", 5000, 0xDAA838FF);

	Vehicle_Respawn(vehicleid);
	Vehicle_Repair(vehicleid);
	UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, 0);

	new pos = random(sizeof(g_rgfParkingSlots));
	SetVehiclePos(vehicleid, g_rgfParkingSlots[pos][0], g_rgfParkingSlots[pos][1], g_rgfParkingSlots[pos][2]);
	SetVehicleZAngle(vehicleid, g_rgfParkingSlots[pos][3]);
	Vehicle_Locked(vehicleid) = true;

	new Float:distance = GetPlayerDistanceFromPoint(playerid, g_rgfParkingSlots[pos][0], g_rgfParkingSlots[pos][1], g_rgfParkingSlots[pos][2]);

	new city[45], zone[45];
	GetPointZone(g_rgeVehicles[vehicleid][e_fPosX], g_rgeVehicles[vehicleid][e_fPosY], city, zone);

	format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Tu %s fue remolcado a %s, %s (%.2f kilómetros de distancia).", g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_szModelName], zone, city, distance * 0.01);
	Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 5000, 0xDAA838FF);

	Phone_Hide(playerid);
	return 1;
}

phone_menu my_vehicles(playerid, response, listitem)
{
	if (!response)
		return PhoneMenu_Main(playerid);

	if (!Iter_Count(PlayerVehicles[playerid]))
	{
		PhoneMenu_Main(playerid);
		Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "No tienes vehículos");
		return 0;
	}

	new vehicleid = Listitem_Extra(listitem);
	if (!IsValidVehicle(vehicleid))
	{
		PhoneMenu_Main(playerid);
		Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "El vehículo se encuentra destruido");
		return 0;
	}

	GetVehiclePos(vehicleid, g_rgeVehicles[vehicleid][e_fPosX], g_rgeVehicles[vehicleid][e_fPosY], g_rgeVehicles[vehicleid][e_fPosZ]);
	Player_SetGPSCheckpoint(playerid, g_rgeVehicles[vehicleid][e_fPosX], g_rgeVehicles[vehicleid][e_fPosY], g_rgeVehicles[vehicleid][e_fPosZ]);
	
	new Float:distance = GetPlayerDistanceFromPoint(playerid, g_rgeVehicles[vehicleid][e_fPosX], g_rgeVehicles[vehicleid][e_fPosY], g_rgeVehicles[vehicleid][e_fPosZ]);

	new city[45], zone[45];
	GetPointZone(g_rgeVehicles[vehicleid][e_fPosX], g_rgeVehicles[vehicleid][e_fPosY], city, zone);

	format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Tu %s se encuentra en %s, %s. A %.2f kilómetros de distancia.", g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_szModelName], zone, city, distance * 0.01);
	Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 5000, 0xDAA838FF);
	return 1;
}