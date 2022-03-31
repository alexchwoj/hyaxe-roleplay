#if defined _inventory_callbacks_
    #endinput
#endif
#define _inventory_callbacks_


public OnPlayerCancelTDSelection(playerid)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_USING_INV))
        Inventory_Hide(playerid);

    #if defined INV_OnPlayerCancelTDSelection
        return INV_OnPlayerCancelTDSelection(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerCancelTDSelection
    #undef OnPlayerCancelTDSelection
#else
    #define _ALS_OnPlayerCancelTDSelection
#endif
#define OnPlayerCancelTDSelection INV_OnPlayerCancelTDSelection
#if defined INV_OnPlayerCancelTDSelection
    forward INV_OnPlayerCancelTDSelection(playerid);
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_NO) != 0 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        Inventory_Show(playerid);
    }

    #if defined INV_OnPlayerKeyStateChange
        return INV_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange INV_OnPlayerKeyStateChange
#if defined INV_OnPlayerKeyStateChange
    forward INV_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


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
            cache_get_value_name_int(i, "ID", g_rgePlayerInventory[playerid][slot][e_iID]);
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


public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_USING_INV))
    {
        for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	    {
            if (playertextid == p_tdItemView[playerid]{i})
            {
                new callback = Item_Callback( InventorySlot_Type(playerid, i) );
                if (callback != -1)
                {
                    __emit {
                        push.s i
                        push.s playerid
                        push.c 8
                        lctrl 6
                        add.c 0x24
                        lctrl 8
                        push.pri
                        load.s.pri callback
                        sctrl 6
                    }
                    
                }
                break;
            }
        }
    }

    #if defined INV_OnPlayerClickPlayerTD
        return INV_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerClickPlayerTD
    #undef OnPlayerClickPlayerTextDraw
#else
    #define _ALS_OnPlayerClickPlayerTD
#endif
#define OnPlayerClickPlayerTextDraw INV_OnPlayerClickPlayerTD
#if defined INV_OnPlayerClickPlayerTD
    forward INV_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
#endif