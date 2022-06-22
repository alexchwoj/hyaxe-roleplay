#if defined _inventory_functions_
    #endinput
#endif
#define _inventory_functions_

Item_SetPreviewRot(type, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fZoom = 1.0)
{
	g_rgeItemData[type][e_fRotX] = fRotX;
	g_rgeItemData[type][e_fRotY] = fRotY;
	g_rgeItemData[type][e_fRotZ] = fRotZ;
	g_rgeItemData[type][e_fZoom] = fZoom;
	return 1;
}

Inventory_GetFreeSlot(playerid)
{
    for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	{
		if (!g_rgePlayerInventory[playerid][i][e_bValid])
		    return i;
	}
    return HYAXE_MAX_INVENTORY_SLOTS + 1;
}

Inventory_Update(playerid)
{
	if (Bit_Get(Player_Flags(playerid), PFLAG_USING_INV))
    {
		for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
		{
			if (InventorySlot_IsValid(playerid, i))
			{
				if (InventorySlot_Type(playerid, i) >= ITEM_INVALID)
				{
					printf("[inventory]: Invalid item > playerid: %d, slot: %d, type: %d, db_id: %d", playerid, i, InventorySlot_Type(playerid, i), InventorySlot_ID(playerid, i));
					Inventory_ResetSlot(playerid, i);
					printf("[MIERDAS8] slot: %d, type: %d", i, g_rgePlayerInventory[playerid][i][e_iType]);
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
	g_rgePlayerInventory[playerid][slot][e_bValid] = 
	bool:(g_rgePlayerInventory[playerid][slot][e_iID] = 
	g_rgePlayerInventory[playerid][slot][e_iType] = 
	g_rgePlayerInventory[playerid][slot][e_iAmount] = 
	g_rgePlayerInventory[playerid][slot][e_iExtra] = 0);
	return 1;
}

Inventory_UpdateDropCount(playerid)
{
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
	for(new i; i < sizeof(g_tdInventoryBG); ++i)
		TextDrawHideForPlayer(playerid, g_tdInventoryBG[i]);

	for(new i; i < sizeof(g_tdInventoryExp); ++i)
		TextDrawHideForPlayer(playerid, g_tdInventoryExp[i]);

	for(new i; i < 6; ++i)
	{
		PlayerTextDrawHide(playerid, p_tdToyView[playerid]{i});
		PlayerTextDrawHide(playerid, p_tdItemOptions[playerid]{i});
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
	CancelSelectTextDraw(playerid);
	return 1;
}

Inventory_Show(playerid)
{
	Bit_Set(Player_Flags(playerid), PFLAG_USING_INV, true);

	// Backgrounds
	for(new i; i < sizeof(g_tdInventoryBG); ++i)
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

	SelectTextDraw(playerid, 0xDAA838FF);
	return 1;
}

InventorySlot_Delete(playerid, slot)
{
	mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "DELETE FROM `PLAYER_INVENTORY` WHERE `ID` = %d;", InventorySlot_ID(playerid, slot));
	mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
	printf("[MIERDAS6] slot: %d, type: %d", slot, g_rgePlayerInventory[playerid][slot][e_iType]);
	Inventory_ResetSlot(playerid, slot);
	printf("[MIERDAS7] slot: %d, type: %d", slot, g_rgePlayerInventory[playerid][slot][e_iType]);

	Inventory_Update(playerid);
	return 1;
}

Inventory_DeleteItemByType(playerid, type)
{
	for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	{
		if (InventorySlot_IsValid(playerid, i))
		{
			if (InventorySlot_Type(playerid, i) == type)
			{
				mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "DELETE FROM `PLAYER_INVENTORY` WHERE `ID` = %d;", InventorySlot_ID(playerid, i));
				mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING);
				printf("[MIERDAS5] slot: %d, type: %d", i, g_rgePlayerInventory[playerid][i][e_iType]);
				Inventory_ResetSlot(playerid, 0);
				printf("[MIERDAS4] slot: %d, type: %d", i, g_rgePlayerInventory[playerid][i][e_iType]);
			}
		}
	}

	//Inventory_Update(playerid);
	return 1;
}

InventorySlot_Subtract(playerid, slot, amount = 1)
{
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
	new slot = Inventory_GetFreeSlot(playerid);
    if (slot < HYAXE_MAX_INVENTORY_SLOTS)
	{
		printf("[MIERDAS10] slot: %d, type: %d", slot, g_rgePlayerInventory[playerid][slot][e_iType]);
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
	new slot = Inventory_GetFreeSlot(playerid);
    if (slot < HYAXE_MAX_INVENTORY_SLOTS)
	{
		printf("[MIERDAS9] slot: %d, type: %d", slot, g_rgePlayerInventory[playerid][slot][e_iType]);
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

Inventory_AddFixedItem(playerid, type, amount, extra)
{
	if (!Inventory_AddItem(playerid, type, amount, extra))
	{
		DroppedItem_CreateFrontPlayer(playerid, type, amount, extra);
		return 0;
	}
	
	return 1;
}

DroppedItem_CreateFrontPlayer(playerid, type, amount, extra)
{
	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	GetXYFromAngle(x, y, angle, 0.8);
	DroppedItem_Create(type, amount, extra, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
}

DroppedItem_Create(type, amount, extra, Float:x, Float:y, Float:z, world = 0, interior = 0, playerid = INVALID_PLAYER_ID)
{
	new objectid = CreateDynamicObject(
		Item_ModelID(type), x, y, z + 0.9,
		math_random_float(-180.0, 180.0), math_random_float(-180.0, 180.0), math_random_float(-180.0, 180.0),
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
	area_info[4] = (gettime() + 300); // Time
	area_info[5] = extra; // Extra

	new area_id = CreateDynamicSphere(x, y, dest_z + 0.9, 1.0, world, interior);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, area_id, E_STREAMER_CUSTOM(0x49544d), area_info);

	Iter_Add(DroppedItems, area_id);
	return 1;
}

DroppedItem_Delete(area_id)
{
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

Item_TypeToWeapon(type)
{
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

command dropitem(playerid, const params[], "Crea un item en el suelo")
{
	 extract params -> new item_id, amount = 1, extra = 0; else {
        SendClientMessage(playerid, 0xDADADAFF, "USO: {ED2B2B}/dropitem {DADADA}<item> {969696}[cantidad = 100] [extra = 0]");
        return 1;
    }
	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	GetXYFromAngle(x, y, angle, 0.8);
	DroppedItem_Create(item_id, amount, extra, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
	return 1;
}
flags:dropitem(CMD_FLAG<RANK_LEVEL_SUPERADMIN>)