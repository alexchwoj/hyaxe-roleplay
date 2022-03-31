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

Inventory_Hide(playerid)
{
	for(new i; i < sizeof(g_tdInventoryBG); ++i)
		TextDrawHideForPlayer(playerid, g_tdInventoryBG[i]);

	for(new i; i < sizeof(g_tdInventoryExp); ++i)
		TextDrawHideForPlayer(playerid, g_tdInventoryExp[i]);

	for(new i; i < 6; ++i)
		PlayerTextDrawHide(playerid, p_tdToyView[playerid]{i});

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