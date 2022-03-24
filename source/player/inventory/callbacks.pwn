#if defined _inventory_callbacks_
    #endinput
#endif
#define _inventory_callbacks_


forward INV_LoadFromDatabase(playerid);
public INV_LoadFromDatabase(playerid)
{
    new row_count;
    cache_get_row_count(row_count);

    for(new i = 0; i < row_count; ++i)
    {
        new slot = Inventory_GetFreeSlot(playerid);
        if (slot < HYAXE_MAX_INVENTORY_SLOTS)
        {
            g_rgePlayerInventory[playerid][slot][e_bValid] = true;
            cache_get_value_name_int(i, "ITEM_TYPE", g_rgePlayerInventory[playerid][slot][e_iType]); 
            cache_get_value_name_int(i, "AMOUNT", g_rgePlayerInventory[playerid][slot][e_iAmount]); 
            cache_get_value_name_int(i, "EXTRA", g_rgePlayerInventory[playerid][slot][e_iExtra]);

            DEBUG_PRINT("type: %d (%s)", g_rgePlayerInventory[playerid][slot][e_iType], g_rgeItemData[ g_rgePlayerInventory[playerid][slot][e_iType] ][e_szName]);
            DEBUG_PRINT("amount: %d", g_rgePlayerInventory[playerid][slot][e_iAmount]);
            DEBUG_PRINT("extra: %d", g_rgePlayerInventory[playerid][slot][e_iExtra]);
        }
        else
        {
            DEBUG_PRINT("full inventory: %d", playerid);
        }
    }
    return 1;
}

public OnPlayerAuthenticate(playerid)
{
    mysql_format(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "\
        SELECT * FROM `PLAYER_INVENTORY` WHERE `ACCOUNT_ID` = %i;\
    ", Player_AccountID(playerid));
    mysql_tquery(g_hDatabase, HYAXE_UNSAFE_HUGE_STRING, "INV_LoadFromDatabase", "i", playerid);

    #if defined INV_OnPlayerAuthenticate
        return INV_OnPlayerAuthenticate(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerAuthenticate
    #undef OnPlayerAuthenticate
#else
    #define _ALS_OnPlayerAuthenticate
#endif
#define OnPlayerAuthenticate INV_OnPlayerAuthenticate
#if defined INV_OnPlayerAuthenticate
    forward INV_OnPlayerAuthenticate(playerid);
#endif



public OnPlayerDisconnect(playerid, reason)
{
    g_rgePlayerInventory[playerid] = g_rgePlayerInventory[MAX_PLAYERS];

    #if defined INV_OnPlayerDisconnect
        return INV_OnPlayerDisconnect(playerid, reason);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect INV_OnPlayerDisconnect
#if defined INV_OnPlayerDisconnect
    forward INV_OnPlayerDisconnect(playerid, reason);
#endif
