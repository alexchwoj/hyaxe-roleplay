#if defined _inventory_functions_
    #endinput
#endif
#define _inventory_functions_

// Items
Item_SetPreviewRot(type, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fZoom = 1.0)
{
	printf("Item_SetPreviewRot(type = %d, Float:fRotX = %f, Float:fRotY = %f, Float:fRotZ = %f, Float:fZoom = %f)", type, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fZoom);
	g_rgeItemData[type][e_fRotX] = fRotX;
	g_rgeItemData[type][e_fRotY] = fRotY;
	g_rgeItemData[type][e_fRotZ] = fRotZ;
	g_rgeItemData[type][e_fZoom] = fZoom;
	return 1;
}

Item_TypeToWeapon(type)
{
	printf("Item_TypeToWeapon(type = %d)", type);
	switch(type)
	{
		case ITEM_BRASSKNUCKLE: return 1;
		case ITEM_GOLFCLUB: return 2;
		case ITEM_NITESTICK: return 3;
		case ITEM_KNIFE: return 4;
		case ITEM_BAT: return 5;
		case ITEM_SHOVEL: return 6;
		case ITEM_POOLSTICK: return 7;
		case ITEM_KATANA: return 8;
		case ITEM_CHAINSAW: return 9;
		case ITEM_DILDO: return 10;
		case ITEM_DILDO2: return 11;
		case ITEM_VIBRATOR: return 12;
		case ITEM_VIBRATOR2: return 13;
		case ITEM_FLOWER: return 14;
		case ITEM_CANE: return 15;
		case ITEM_GRENADE: return 16;
		case ITEM_TEARGAS: return 17;
		case ITEM_MOLTOV: return 18;
		case ITEM_COLT45: return 22;
		case ITEM_SILENCED: return 23;
		case ITEM_DEAGLE: return 24;
		case ITEM_SHOTGUN: return 25;
		case ITEM_SAWEDOFF: return 26;
		case ITEM_SHOTGSPA: return 27;
		case ITEM_UZI: return 28;
		case ITEM_MP5: return 29;
		case ITEM_AK47: return 30;
		case ITEM_M4: return 31;
		case ITEM_TEC9: return 32;
		case ITEM_RIFLE: return 33;
		case ITEM_SNIPER: return 34;
		case ITEM_ROCKETLAUNCHER: return 35;
		case ITEM_HEATSEEKER: return 36;
		case ITEM_FLAMETHROWER: return 37;
		case ITEM_MINIGUN: return 38;
		case ITEM_SATCHEL: return 39;
		case ITEM_BOMB: return 40;
		case ITEM_SPRAYCAN: return 41;
		case ITEM_FIREEXTINGUISHER: return 42;
		case ITEM_CAMERA: return 43;
		case ITEM_PARACHUTE: return 46;
	}
	return 0;
}

Item_WeaponToType(type)
{
	printf("Item_WeaponToType(type = %d)", type);
	switch(type)
	{
		case 1: return ITEM_BRASSKNUCKLE;
		case 2: return ITEM_GOLFCLUB;
		case 3: return ITEM_NITESTICK;
		case 4: return ITEM_KNIFE;
		case 5: return ITEM_BAT;
		case 6: return ITEM_SHOVEL;
		case 7: return ITEM_POOLSTICK;
		case 8: return ITEM_KATANA;
		case 9: return ITEM_CHAINSAW;
		case 10: return ITEM_DILDO;
		case 11: return ITEM_DILDO2;
		case 12: return ITEM_VIBRATOR;
		case 13: return ITEM_VIBRATOR2;
		case 14: return ITEM_FLOWER;
		case 15: return ITEM_CANE;
		case 16: return ITEM_GRENADE;
		case 17: return ITEM_TEARGAS;
		case 18: return ITEM_MOLTOV;
		case 22: return ITEM_COLT45;
		case 23: return ITEM_SILENCED;
		case 24: return ITEM_DEAGLE;
		case 25: return ITEM_SHOTGUN;
		case 26: return ITEM_SAWEDOFF;
		case 27: return ITEM_SHOTGSPA;
		case 28: return ITEM_UZI;
		case 29: return ITEM_MP5;
		case 30: return ITEM_AK47;
		case 31: return ITEM_M4;
		case 32: return ITEM_TEC9;
		case 33: return ITEM_RIFLE;
		case 34: return ITEM_SNIPER;
		case 35: return ITEM_ROCKETLAUNCHER;
		case 36: return ITEM_HEATSEEKER;
		case 37: return ITEM_FLAMETHROWER;
		case 38: return ITEM_MINIGUN;
		case 39: return ITEM_SATCHEL;
		case 40: return ITEM_BOMB;
		case 41: return ITEM_SPRAYCAN;
		case 42: return ITEM_FIREEXTINGUISHER;
		case 43: return ITEM_CAMERA;
		case 46: return ITEM_PARACHUTE;
	}
	return 0;
}

// Inventory
Inventory_GetFreeSlot(playerid)
{
	printf("Inventory_GetFreeSlot(playerid = %d)", playerid);
    for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	{
		if (!g_rgePlayerInventory[playerid][i][e_bValid])
		    return i;
	}
    return HYAXE_MAX_INVENTORY_SLOTS + 1;
}

Inventory_Update(playerid)
{
	printf("Inventory_Update(playerid = %d)", playerid);
	if (Bit_Get(Player_Flags(playerid), PFLAG_USING_INV) || Bit_Get(Player_Flags(playerid), PFLAG_USING_SECONDARY_INV))
    {
		for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
		{
			if (InventorySlot_IsValid(playerid, i))
			{
				if (InventorySlot_Type(playerid, i) >= ITEM_INVALID)
				{
					printf("[inventory]: Invalid item > playerid: %d, slot: %d, type: %d, db_id: %d", playerid, i, InventorySlot_Type(playerid, i), InventorySlot_ID(playerid, i));
					Inventory_ResetSlot(playerid, i);
				}
				else
				{
					PlayerTextDrawSetPreviewModel(playerid, p_tdItemView[playerid]{i}, Item_ModelID( InventorySlot_Type(playerid, i) ));

					PlayerTextDrawSetPreviewRot(
						playerid, p_tdItemView[playerid]{i},
						g_rgeItemData[ InventorySlot_Type(playerid, i) ][e_fRotX],
						g_rgeItemData[ InventorySlot_Type(playerid, i) ][e_fRotY],
						g_rgeItemData[ InventorySlot_Type(playerid, i) ][e_fRotZ],
						g_rgeItemData[ InventorySlot_Type(playerid, i) ][e_fZoom]
					);

					if (!Item_SingleSlot( InventorySlot_Type(playerid, i) ))
					{
						new string[8];
						valstr(string, InventorySlot_Amount(playerid, i));
						PlayerTextDrawSetString(playerid, p_tdItemCount[playerid]{i}, string);
					}
					else PlayerTextDrawSetString(playerid, p_tdItemCount[playerid]{i}, "_");
				}
			}
			else
			{
				PlayerTextDrawSetString(playerid, p_tdItemCount[playerid]{i}, "_");
				PlayerTextDrawSetPreviewModel(playerid, p_tdItemView[playerid]{i}, 19482);
			}

			PlayerTextDrawShow(playerid, p_tdItemView[playerid]{i});
			PlayerTextDrawShow(playerid, p_tdItemCount[playerid]{i});
		}

		for(new i; i < 6; ++i)
			PlayerTextDrawHide(playerid, p_tdItemOptions[playerid]{i});
	}
	return 1;
}

Inventory_UpdateSlot(playerid, slot)
{
	printf("Inventory_UpdateSlot(playerid = %d, slot = %d)", playerid, slot);
	if (Bit_Get(Player_Flags(playerid), PFLAG_USING_INV))
    {
		if (InventorySlot_IsValid(playerid, slot))
		{
			if (!Item_SingleSlot( InventorySlot_Type(playerid, slot) ))
			{
				new string[8];
				valstr(string, InventorySlot_Amount(playerid, slot));
				PlayerTextDrawSetString(playerid, p_tdItemCount[playerid]{slot}, string);
			}
		}
	}
	return 1;
}

Inventory_ResetSlot(playerid, slot)
{
	printf("Inventory_ResetSlot(playerid = %d, slot = %d)", playerid, slot);

	g_rgePlayerInventory[playerid][slot][e_bValid] = false;
	g_rgePlayerInventory[playerid][slot][e_iID] = 0;
	g_rgePlayerInventory[playerid][slot][e_iType] = 0;
	g_rgePlayerInventory[playerid][slot][e_iAmount] = 0 ;
	g_rgePlayerInventory[playerid][slot][e_iExtra] = 0;
	return 1;
}

Inventory_UpdateDropCount(playerid)
{
	printf("Inventory_UpdateDropCount(playerid = %d)", playerid);
	new string[8];
	valstr(string, g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount]);
	PlayerTextDrawSetString(playerid, p_tdItemOptions[playerid]{2}, string);

	if (g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] == 1)
	{
		PlayerTextDrawBoxColor(playerid, p_tdItemOptions[playerid]{3}, 0x1B1B1B44);
		PlayerTextDrawShow(playerid, p_tdItemOptions[playerid]{3});
	}
	else
	{
		PlayerTextDrawBoxColor(playerid, p_tdItemOptions[playerid]{3}, 454761471);
		PlayerTextDrawShow(playerid, p_tdItemOptions[playerid]{3});
	}

	if (g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] == InventorySlot_Amount(playerid, g_rgePlayerTempData[playerid][e_iPlayerItemSlot]))
	{
		PlayerTextDrawBoxColor(playerid, p_tdItemOptions[playerid]{4}, 0x1B1B1B44);
		PlayerTextDrawShow(playerid, p_tdItemOptions[playerid]{4});
	}
	else
	{
		PlayerTextDrawBoxColor(playerid, p_tdItemOptions[playerid]{4}, 454761471);
		PlayerTextDrawShow(playerid, p_tdItemOptions[playerid]{4});
	}

	return 1;
}

Inventory_Hide(playerid)
{
	printf("Inventory_Hide(playerid = %d)", playerid);
	g_rgePlayerTempData[playerid][e_iPlayerItemSlot] = -1;

	if (IsValidVehicle(g_rgePlayerTempData[playerid][e_iLastTrunk]))
	{
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(g_rgePlayerTempData[playerid][e_iLastTrunk], engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(g_rgePlayerTempData[playerid][e_iLastTrunk], engine, lights, alarm, doors, bonnet, 0, objective);
	}

	for(new i; i < sizeof(g_tdInventoryBG); ++i)
		TextDrawHideForPlayer(playerid, g_tdInventoryBG[i]);

	for(new i; i < sizeof(g_tdInventoryExp); ++i)
		TextDrawHideForPlayer(playerid, g_tdInventoryExp[i]);

	for(new i; i < 6; ++i)
	{
		PlayerTextDrawHide(playerid, p_tdToyView[playerid]{i});
		PlayerTextDrawHide(playerid, p_tdItemOptions[playerid]{i});
	}

	TextDrawHideForPlayer(playerid, g_tdInveotrySections[0]);
	TextDrawHideForPlayer(playerid, g_tdInveotrySections[1]);

	for(new i; i < HYAXE_MAX_TRUNK_SLOTS; ++i)
	{
		PlayerTextDrawHide(playerid, p_tdTrunkItemView[playerid]{i});
		PlayerTextDrawHide(playerid, p_tdTrunkItemCount[playerid]{i});
	}

	/*
	for(new i; i < 6; ++i)
		PlayerTextDrawHide(playerid, p_tdItemOptions[playerid]{i});
	*/

	for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	{
		PlayerTextDrawHide(playerid, p_tdItemView[playerid]{i});
		PlayerTextDrawHide(playerid, p_tdItemCount[playerid]{i});
	}

	TextDrawHideForPlayer(playerid, g_tdInventoryUsername);
	PlayerTextDrawHide(playerid, p_tdInventorySkin{playerid});
	PlayerTextDrawHide(playerid, p_tdInventoryExpBar{playerid});
	PlayerTextDrawHide(playerid, p_tdInventoryExpText{playerid});

	Bit_Set(Player_Flags(playerid), PFLAG_USING_INV, false);
	Bit_Set(Player_Flags(playerid), PFLAG_USING_SECONDARY_INV, false);
	CancelSelectTextDraw(playerid);
	return 1;
}

Inventory_Show(playerid)
{
	printf("Inventory_Show(playerid = %d)", playerid);
	Bit_Set(Player_Flags(playerid), PFLAG_USING_INV, true);

	// Backgrounds
	for(new i; i < sizeof(g_tdInventoryBG) - 2; ++i)
		TextDrawShowForPlayer(playerid, g_tdInventoryBG[i]);

	// Username
	TextDrawShowForPlayer(playerid, g_tdInventoryUsername);

	// Toys view
	for(new i; i < 6; ++i)
		PlayerTextDrawShow(playerid, p_tdToyView[playerid]{i});

	// Item slots
	Inventory_Update(playerid);

	// Set username
	TextDrawSetStringForPlayer(g_tdInventoryUsername, playerid, "%s_(%i)", Player_Name(playerid), playerid);

	// Skin
	PlayerTextDrawSetPreviewModel(playerid, p_tdInventorySkin{playerid}, Player_Skin(playerid));
	PlayerTextDrawShow(playerid, p_tdInventorySkin{playerid});

	// Experience bars
	TextDrawShowForPlayer(playerid, g_tdInventoryExp[0]);
	TextDrawShowForPlayer(playerid, g_tdInventoryExp[1]);

	new exp_string[64];
	format(exp_string, sizeof(exp_string), "EXPERIENCIA: %d/%d", Player_XP(playerid), Level_GetRequiredXP(Player_Level(playerid)));
	PlayerTextDrawSetString(playerid, p_tdInventoryExpText{playerid}, exp_string);

	PlayerTextDrawTextSize(
		playerid, p_tdInventoryExpBar{playerid},
		lerp(EXP_BAR_MIN_X, EXP_BAR_MAX_X, floatdiv(Player_XP(playerid), Level_GetRequiredXP(Player_Level(playerid)))), 188.500000
	);

	PlayerTextDrawShow(playerid, p_tdInventoryExpBar{playerid});
	if(!IsPlayerTextDrawVisible(playerid, p_tdInventoryExpText{playerid}))
		PlayerTextDrawShow(playerid, p_tdInventoryExpText{playerid});

	PlayerTextDrawSetString(playerid, p_tdItemOptions[playerid]{0}, "TIRAR");
	PlayerTextDrawSetString(playerid, p_tdItemOptions[playerid]{1}, "USAR");

	SelectTextDraw(playerid, 0xDAA838FF);
	return 1;
}

InventorySlot_Delete(playerid, slot)
{
	printf("InventorySlot_Delete(playerid = %d, slot = %d)", playerid, slot);
	mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "DELETE FROM `PLAYER_INVENTORY` WHERE `ID` = %d;", InventorySlot_ID(playerid, slot));
	mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
	Inventory_ResetSlot(playerid, slot);

	Inventory_Update(playerid);
	return 1;
}

Inventory_DeleteItemByType(playerid, type)
{
	printf("Inventory_DeleteItemByType(playerid = %d, type = %d)", playerid, type);
	for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	{
		if (InventorySlot_IsValid(playerid, i))
		{
			if (InventorySlot_Type(playerid, i) == type)
			{
				mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "DELETE FROM `PLAYER_INVENTORY` WHERE `ID` = %d;", InventorySlot_ID(playerid, i));
				mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
				Inventory_ResetSlot(playerid, i);
			}
		}
	}

	//Inventory_Update(playerid);
	return 1;
}

InventorySlot_Subtract(playerid, slot, amount = 1)
{
	printf("InventorySlot_Subtract(playerid = %d, slot = %d, amount = %d)", playerid, slot, amount);
	if (InventorySlot_IsValid(playerid, slot))
	{
		if (!Item_SingleSlot( InventorySlot_Type(playerid, slot) ))
		{
			InventorySlot_Amount(playerid, slot) -= amount;
			if (InventorySlot_Amount(playerid, slot) <= 0)
				InventorySlot_Delete(playerid, slot);
			else
			{
				mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "UPDATE `PLAYER_INVENTORY` SET `AMOUNT` = '%d' WHERE `ID` = %d;", InventorySlot_Amount(playerid, slot), InventorySlot_ID(playerid, slot));
				mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
				Inventory_UpdateSlot(playerid, slot);
			}
		}
		else InventorySlot_Delete(playerid, slot);
	}
	return 1;
}

Inventory_InsertItem(playerid, type, amount, extra)
{
	printf("Inventory_InsertItem(playerid = %d, type = %d, amount = %d, extra = %d)", playerid, type, amount, extra);
	new slot = Inventory_GetFreeSlot(playerid);
    if (slot < HYAXE_MAX_INVENTORY_SLOTS)
	{
		g_rgePlayerInventory[playerid][slot][e_bValid] = true;
		
		mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
			INSERT INTO `PLAYER_INVENTORY` (`ITEM_TYPE`, `AMOUNT`, `EXTRA`, `ACCOUNT_ID`) VALUES (%d, %d, %d, %i);\
		", type, amount, extra, Player_AccountID(playerid));
		mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "INV_OnItemInserted", !"idddd", playerid, slot, type, amount, extra);
		return 1;
	}
	return 0;
}

Inventory_AddItem(playerid, type, amount, extra)
{
	printf("Inventory_AddItem(playerid = %d, type = %d, amount = %d, extra = %d)", playerid, type, amount, extra);
	new slot = Inventory_GetFreeSlot(playerid);
    if (slot < HYAXE_MAX_INVENTORY_SLOTS)
	{
		if (Item_SingleSlot(type))
			Inventory_InsertItem(playerid, type, amount, extra);
		else
		{
			for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
			{
				if (InventorySlot_IsValid(playerid, i))
				{
					if (InventorySlot_Type(playerid, i) == type)
					{
						InventorySlot_Amount(playerid, i) += amount;
						mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
						UPDATE `PLAYER_INVENTORY` SET `AMOUNT` = %d WHERE `ID` = %i;\
						", InventorySlot_Amount(playerid, i), InventorySlot_ID(playerid, i));
						mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
						Inventory_Update(playerid);
						return 1;
					}
				}
			}

			Inventory_InsertItem(playerid, type, amount, extra);
		}
		return 1;
	}
	return 0;
}

Inventory_GetItemAmount(playerid, type)
{
	printf("Inventory_GetItemAmount(playerid = %d, type = %d)", playerid, type);
	for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	{
		if (InventorySlot_IsValid(playerid, i))
		{
			if (InventorySlot_Type(playerid, i) == type)
				return InventorySlot_Amount(playerid, i);
		}
	}
	return 0;
}

Inventory_GetItemCount(playerid, type)
{
	printf("Inventory_GetItemCount(playerid = %d, type = %d)", playerid, type);
	new count;
	for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	{
		if (InventorySlot_IsValid(playerid, i))
		{
			if (InventorySlot_Type(playerid, i) == type)
				++count;
		}
	}
	return count;
}

Inventory_AddFixedItem(playerid, type, amount, extra)
{
	printf("Inventory_AddFixedItem(playerid = %d, type = %d, amount = %d, extra = %d)", playerid, type, amount, extra);
	if (!Inventory_AddItem(playerid, type, amount, extra))
	{
		DroppedItem_CreateFrontPlayer(playerid, type, amount, extra);
		return 0;
	}
	
	return 1;
}

// Dropped items
DroppedItem_CreateFrontPlayer(playerid, type, amount, extra)
{
	printf("DroppedItem_CreateFrontPlayer(playerid = %d, type = %d, amount = %d, extra = %d)", playerid, type, amount, extra);
	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	GetXYFromAngle(x, y, angle, 0.8);
	DroppedItem_Create(type, amount, extra, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
}

DroppedItem_Create(type, amount, extra, Float:x, Float:y, Float:z, world = 0, interior = 0, playerid = INVALID_PLAYER_ID, timeout = 300)
{
	printf("DroppedItem_Create(type = %d, amount = %d, extra = %d, Float:x = %f, Float:y = %f, Float:z = %f, world = %d, interior = %d, playerid = %d, timeout = %d)", type, amount, extra, Float:x, Float:y, Float:z, world, interior, playerid, timeout);
	new objectid = CreateDynamicObject(
		Item_ModelID(type), x, y, z + 0.9,
		RandomFloat(-180.0, 180.0), RandomFloat(-180.0, 180.0), RandomFloat(-180.0, 180.0),
		world, interior, .streamdistance = 50.0, .drawdistance = 50.0
	);

	if (playerid != INVALID_PLAYER_ID)
		Streamer_UpdateEx(playerid, x, y, z, world, interior, .freezeplayer = 0);

	Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_CUSTOM(0x4449544D), 1); // DITM

	new Float:dest_z = z, Float:rx, Float:ry, Float:rz;
	if (!interior)
	{
		CA_RayCastLineAngle(x, y, 700.0, x, y, -1000.0, x, y, dest_z, rx, ry, rz);
		if ( dest_z > z )
			dest_z = z - 0.9;
	}

	format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "%s (%d)", Item_Name(type), amount);
	new Text3D:labelid = CreateDynamic3DTextLabel(HYAXE_UNSAFE_HUGE_STRING, 0xF7F7F7AA, x, y, dest_z + 0.4, 5.0, .testlos = 1, .worldid = world, .interiorid = interior);

	MoveDynamicObject(objectid, x, y, dest_z, 10.0, rx, ry, rz);

	new area_info[6];
	area_info[0] = type; // Item type
	area_info[1] = amount; // Amount
	area_info[2] = objectid; // Object ID
	area_info[3] = _:labelid; // Label ID
	area_info[4] = (gettime() + timeout); // Time
	area_info[5] = extra; // Extra

	new area_id = CreateDynamicSphere(x, y, dest_z + 0.9, 1.0, world, interior);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, area_id, E_STREAMER_CUSTOM(0x49544d), area_info);

	Iter_Add(DroppedItems, area_id);
	return 1;
}

DroppedItem_Delete(area_id)
{
	printf("DroppedItem_Delete(area_id = %d)", area_id);
	if (!area_id || !IsValidDynamicArea(area_id))
		return 0;
		
	if(!Streamer_HasArrayData(STREAMER_TYPE_AREA, area_id, E_STREAMER_CUSTOM(0x49544D)))
		return 0;

	new info[6];
	Streamer_GetArrayData(STREAMER_TYPE_AREA, area_id, E_STREAMER_CUSTOM(0x49544d), info);

	DestroyDynamicArea(area_id);
	DestroyDynamicObject(info[2]);
	DestroyDynamic3DTextLabel(Text3D:info[3]);

	new next;
	Iter_SafeRemove(DroppedItems, area_id, next);
	return next;
}

// Trunk
Trunk_Show(playerid, vehicleid)
{
	if (!IsValidVehicle(vehicleid))
		return 0;

	Bit_Set(Player_Flags(playerid), PFLAG_USING_SECONDARY_INV, true);

	g_rgePlayerTempData[playerid][e_iLastTrunk] = vehicleid;

	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);

	TextDrawShowForPlayer(playerid, g_tdInventoryBG[3]);
	TextDrawShowForPlayer(playerid, g_tdInventoryBG[4]);
	TextDrawShowForPlayer(playerid, g_tdInventoryBG[1]);

	TextDrawShowForPlayer(playerid, g_tdInveotrySections[0]);
	TextDrawShowForPlayer(playerid, g_tdInveotrySections[1]);

	TextDrawSetStringForPlayer(g_tdInveotrySections[1], playerid, "%s", g_rgeVehicleModelData[GetVehicleModel(vehicleid) - 400][e_szModelName]);

	for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	{
		PlayerTextDrawShow(playerid, p_tdItemView[playerid]{i});
		PlayerTextDrawShow(playerid, p_tdItemCount[playerid]{i});
	}

	for(new i; i < HYAXE_MAX_TRUNK_SLOTS; ++i)
	{
		PlayerTextDrawShow(playerid, p_tdTrunkItemView[playerid]{i});
		PlayerTextDrawShow(playerid, p_tdTrunkItemCount[playerid]{i});
	}

	Inventory_Update(playerid);
	Trunk_Update(playerid, vehicleid);

	SelectTextDraw(playerid, 0xDAA838FF);
	return 1;
}

Trunk_GetFreeSlot(vehicleid)
{
    for(new i; i < HYAXE_MAX_TRUNK_SLOTS; ++i)
	{
		if (!g_rgeVehicleTrunk[vehicleid][i][e_bValid])
		    return i;
	}
    return HYAXE_MAX_TRUNK_SLOTS + 1;
}

Trunk_ResetSlot(vehicleid, slot)
{
	printf("Trunk_ResetSlot(vehicleid = %d, slot = %d)", vehicleid, slot);
	g_rgeVehicleTrunk[vehicleid][slot][e_bValid] = false;
	g_rgeVehicleTrunk[vehicleid][slot][e_iID] = 0;
	g_rgeVehicleTrunk[vehicleid][slot][e_iType] = 0;
	g_rgeVehicleTrunk[vehicleid][slot][e_iAmount] = 0 ;
	g_rgeVehicleTrunk[vehicleid][slot][e_iExtra] = 0;
	return 1;
}

Trunk_InsertItem(vehicleid, type, amount, extra, playerid = INVALID_PLAYER_ID)
{
	printf("Trunk_InsertItem(vehicleid = %d, type = %d, amount = %d, extra = %d, playerid = %d)", vehicleid, type, amount, extra, playerid);
	new slot = Trunk_GetFreeSlot(vehicleid);
    if (slot < HYAXE_MAX_TRUNK_SLOTS)
	{
		mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
			INSERT INTO `VEHICLE_TRUNK` (`ITEM_TYPE`, `AMOUNT`, `EXTRA`, `VEHICLE_ID`) VALUES (%d, %d, %d, %i);\
		", type, amount, extra, Vehicle_ID(vehicleid));
		mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "TRUNK_OnItemInserted", !"iddddd", vehicleid, slot, type, amount, extra, playerid);
		return 1;
	}
	return 0;
}

TrunkSlot_Delete(vehicleid, slot)
{
	printf("TrunkSlot_Delete(vehicleid = %d, slot = %d)", vehicleid, slot);
	mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "DELETE FROM `VEHICLE_TRUNK` WHERE `ID` = %d;", TrunkSlot_ID(vehicleid, slot));
	mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
	Trunk_ResetSlot(vehicleid, slot);
	return 1;
}

Trunk_Update(playerid, vehicleid)
{
	if (Bit_Get(Player_Flags(playerid), PFLAG_USING_SECONDARY_INV))
    {
		for(new i; i < HYAXE_MAX_TRUNK_SLOTS; ++i)
		{
			if (TrunkSlot_IsValid(vehicleid, i))
			{
				if (TrunkSlot_Type(vehicleid, i) >= ITEM_INVALID)
				{
					Trunk_ResetSlot(vehicleid, i);
				}
				else
				{
					PlayerTextDrawSetPreviewModel(playerid, p_tdTrunkItemView[playerid]{i}, Item_ModelID( TrunkSlot_Type(vehicleid, i) ));

					PlayerTextDrawSetPreviewRot(
						playerid, p_tdTrunkItemView[playerid]{i},
						g_rgeItemData[ TrunkSlot_Type(vehicleid, i) ][e_fRotX],
						g_rgeItemData[ TrunkSlot_Type(vehicleid, i) ][e_fRotY],
						g_rgeItemData[ TrunkSlot_Type(vehicleid, i) ][e_fRotZ],
						g_rgeItemData[ TrunkSlot_Type(vehicleid, i) ][e_fZoom]
					);

					if (!Item_SingleSlot( TrunkSlot_Type(vehicleid, i) ))
					{
						new string[8];
						valstr(string, TrunkSlot_Amount(vehicleid, i));
						PlayerTextDrawSetString(playerid, p_tdTrunkItemCount[playerid]{i}, string);
					}
					else PlayerTextDrawSetString(playerid, p_tdTrunkItemCount[playerid]{i}, "_");
				}
			}
			else
			{
				PlayerTextDrawSetString(playerid, p_tdTrunkItemCount[playerid]{i}, "_");
				PlayerTextDrawSetPreviewModel(playerid, p_tdTrunkItemView[playerid]{i}, 19482);
			}

			PlayerTextDrawShow(playerid, p_tdTrunkItemView[playerid]{i});
			PlayerTextDrawShow(playerid, p_tdTrunkItemCount[playerid]{i});
		}
	}
	return 1;
}