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

	Bit_Set(Player_Flags(playerid), PFLAG_USING_INV, false);
	return 1;
}

Inventory_Show(playerid)
{
	// Backgrounds
	for(new i; i < sizeof(g_tdInventoryBG); ++i)
		TextDrawShowForPlayer(playerid, g_tdInventoryBG[i]);

	// Username
	TextDrawShowForPlayer(playerid, g_tdInventoryUsername);

	// Experience bars
	for(new i; i < sizeof(g_tdInventoryExp); ++i)
		TextDrawShowForPlayer(playerid, g_tdInventoryExp[i]);

	// Toys view
	for(new i; i < 6; ++i)
		PlayerTextDrawShow(playerid, p_tdToyView[playerid]{i});

	// Item slots
	for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	{
		if (InventorySlot_IsValid(playerid, i))
		{
			PlayerTextDrawSetPreviewModel(playerid, p_tdItemView[playerid]{i}, Item_ModelID( InventorySlot_Type(playerid, i) ));
			
			if (!Item_SingleSlot( InventorySlot_Type(playerid, i) ))
			{
				new string[8];
				format(string, sizeof(string), "%d", InventorySlot_Amount(playerid, i));
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

	// Set username
	TextDrawSetStringForPlayer(g_tdInventoryUsername, playerid, "%s (%i)", Player_RPName(playerid), playerid);

	// Skin
	PlayerTextDrawShow(playerid, p_tdInventorySkin{playerid});
	PlayerTextDrawSetPreviewModel(playerid, p_tdInventorySkin{playerid}, Player_Skin(playerid));

	// Set experience bars
	PlayerTextDrawShow(playerid, p_tdInventoryExpBar{playerid});
	TextDrawSetStringForPlayer(g_tdInventoryExp[2], playerid, "EXPERIENCIA: 65/100");
	TextDrawShowForPlayer(playerid, g_tdInventoryExp[2]);

	SelectTextDraw(playerid, 0xF7F7F7FF);
	Bit_Set(Player_Flags(playerid), PFLAG_USING_INV, true);
	return 1;
}