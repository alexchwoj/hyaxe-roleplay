#if defined _inventory_functions_
    #endinput
#endif
#define _inventory_functions_

Server_RegisterItem(item_id, const name[], modelid, bool:single_slot = false)
{
    strcat(g_rgeItemData[item_id][e_szName], name);
    g_rgeItemData[item_id][e_iModelID] = modelid;
    g_rgeItemData[item_id][e_bSingleSlot] = single_slot;
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