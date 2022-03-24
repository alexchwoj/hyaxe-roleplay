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