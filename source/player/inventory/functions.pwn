#if defined _inventory_functions_
    #endinput
#endif
#define _inventory_functions_

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
				PlayerTextDrawSetPreviewModel(playerid, p_tdItemView[playerid]{i}, Item_ModelID( InventorySlot_Type(playerid, i) ));
				
				if (!Item_SingleSlot( InventorySlot_Type(playerid, i) ))
				{
					new string[8];
					valstr(string, InventorySlot_Amount(playerid, i));
					PlayerTextDrawSetString(playerid, p_tdItemCount[playerid]{i}, string);
				}
				else PlayerTextDrawSetString(playerid, p_tdItemCount[playerid]{i}, "_");
			}
			else
			{
				PlayerTextDrawSetString(playerid, p_tdItemCount[playerid]{i}, "_");
				PlayerTextDrawSetPreviewModel(playerid, p_tdItemView[playerid]{i}, 19482);
			}

			PlayerTextDrawShow(playerid, p_tdItemView[playerid]{i});
			PlayerTextDrawShow(playerid, p_tdItemCount[playerid]{i});
		}

		for(new i; i < 5; ++i)
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
		PlayerTextDrawHide(playerid, p_tdToyView[playerid]{i});

	for(new i; i < 5; ++i)
		PlayerTextDrawHide(playerid, p_tdItemOptions[playerid]{i});

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
	memset(g_rgePlayerInventory[playerid][slot], 0);

	Inventory_Update(playerid);
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

DroppedItem_Create(type, amount, extra, Float:x, Float:y, Float:z, world = 0, interior = 0, playerid = INVALID_PLAYER_ID)
{
	new objectid = CreateDynamicObject(
		Item_ModelID(type), x, y, z + 0.9,
		0.0, 0.0, 0.0,
		world, interior, .streamdistance = 50.0, .drawdistance = 50.0
	);

	if (playerid != INVALID_PLAYER_ID)
		Streamer_UpdateEx(playerid, x, y, z, world, interior, .freezeplayer = 0);

	new Float:dest_z = z;
	if (!interior)
	{
		CA_FindZ_For2DCoord(x, y, dest_z);
		if ( dest_z > z )
			dest_z = z - 0.9;
	}

	format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "%s (%d)", Item_Name(type), amount);
	new Text3D:labelid = CreateDynamic3DTextLabel(HYAXE_UNSAFE_HUGE_STRING, 0xF7F7F7AA, x, y, dest_z + 0.4, 5.0, .testlos = 1, .worldid = world, .interiorid = interior);

	MoveDynamicObject(objectid, x, y, dest_z, 10.0, 0.0, 0.0, 0.0);

	new info[7];
	info[0] = 0x49544d; // ITM
	info[1] = type; // Item type
	info[2] = amount; // Amount
	info[3] = objectid; // Object ID
	info[4] = _:labelid; // Label ID
	info[5] = (gettime() + 300); // Time
	info[6] = extra; // Extra

	new area_id = CreateDynamicSphere(x, y, z, 1.0, world, interior);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, area_id, E_STREAMER_EXTRA_ID, info);

	Iter_Add(DroppedItems, area_id);
	return 1;
}

DroppedItem_Delete(area_id)
{
	new info[7];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, area_id, E_STREAMER_EXTRA_ID, info);

	DestroyDynamicObject(info[3]);
	DestroyDynamic3DTextLabel(Text3D:info[4]);
	DestroyDynamicArea(area_id);

	Iter_Remove(DroppedItems, area_id);
	return 1;
}

command burger(playerid, const params[], "")
{
	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	GetXYFromAngle(x, y, angle, 0.8);
	DroppedItem_Create(ITEM_BURGER, 1, 0, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
	return 1;
}

command medicine(playerid, const params[], "")
{
	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	GetXYFromAngle(x, y, angle, 0.8);
	DroppedItem_Create(ITEM_MEDICINE, 5, 0, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
	return 1;
}