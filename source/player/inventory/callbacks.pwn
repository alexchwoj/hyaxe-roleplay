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
    if ((newkeys & KEY_NO) != 0)
    {
        if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !Bit_Get(Player_Flags(playerid), PFLAG_IN_KEYGAME))
            Inventory_Show(playerid);
    }

    if ((newkeys & KEY_WALK) != 0 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        for_list(it : GetPlayerAllDynamicAreas(playerid))
        {
            if (Streamer_HasArrayData(STREAMER_TYPE_AREA, iter_get(it), E_STREAMER_CUSTOM(0x49544d)))
            {
                new info[6];
                printf("a2");
                Streamer_GetArrayData(STREAMER_TYPE_AREA, iter_get(it), E_STREAMER_CUSTOM(0x49544d), info);
                
                new weapon = Item_TypeToWeapon(info[0]);
                if (weapon)
                {
                    new ammo = 9999;
                    if (Weapon_IsExplosive(weapon))
                        ammo = info[1];

                    Player_GiveWeapon(playerid, weapon, ammo);

                    DroppedItem_Delete(iter_get(it));
                    PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
                    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 1000, 1);
                }
                else if (Inventory_AddItem(playerid, info[0], info[1], info[5]))
                {
                    DroppedItem_Delete(iter_get(it));
                    PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
                    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 1000, 1);
                }
                else return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Tienes el inventario lleno.");
            }
        }
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
            printf("[MIERDAS1] slot: %d, type: %d", slot, g_rgePlayerInventory[playerid][slot][e_iType]);
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
                g_rgePlayerTempData[playerid][e_iPlayerItemSlot] = i;
                g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] = 1;

                for(new j; j < 6; ++j)
                    PlayerTextDrawHide(playerid, p_tdItemOptions[playerid]{j});

                if ( InventorySlot_IsValid(playerid, i) )
                {
                    PlayerTextDrawShow(playerid, p_tdItemOptions[playerid]{0});
                    PlayerTextDrawShow(playerid, p_tdItemOptions[playerid]{1});

                    PlayerTextDrawShow(playerid, p_tdItemOptions[playerid]{5});
                    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "%s~n~~w~(%s~w~)", Item_Name( InventorySlot_Type(playerid, i) ), Item_RarityName( Item_Rarity( InventorySlot_Type(playerid, i) ) ));
                    Str_FixEncoding_Ref(HYAXE_UNSAFE_HUGE_STRING);
                    PlayerTextDrawSetString(playerid, p_tdItemOptions[playerid]{5}, HYAXE_UNSAFE_HUGE_STRING);

                    if (!Item_SingleSlot( InventorySlot_Type(playerid, i) ))
                    {
                        PlayerTextDrawSetString(playerid, p_tdItemOptions[playerid]{2}, "1");
                        PlayerTextDrawShow(playerid, p_tdItemOptions[playerid]{2});

                        PlayerTextDrawShow(playerid, p_tdItemOptions[playerid]{3});
                        PlayerTextDrawShow(playerid, p_tdItemOptions[playerid]{4});

                        Inventory_UpdateDropCount(playerid);
                    }
                    break;
                }
            }
        }

        if (playertextid == p_tdItemOptions[playerid]{4})
        {
            ++g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount];
            if (g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] > InventorySlot_Amount(playerid, g_rgePlayerTempData[playerid][e_iPlayerItemSlot]))
                g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] = InventorySlot_Amount(playerid, g_rgePlayerTempData[playerid][e_iPlayerItemSlot]);
        
            Inventory_UpdateDropCount(playerid);
            PlayerPlaySound(playerid, SOUND_BACK);
        }

        if (playertextid == p_tdItemOptions[playerid]{3})
        {
            --g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount];
            if (g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] < 1)
                g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] = 1;

            Inventory_UpdateDropCount(playerid);
            PlayerPlaySound(playerid, SOUND_NEXT);
        }

        if (playertextid == p_tdItemOptions[playerid]{1})
        {
            new
                callback = Item_Callback( InventorySlot_Type(playerid, g_rgePlayerTempData[playerid][e_iPlayerItemSlot]) ),
                slot = g_rgePlayerTempData[playerid][e_iPlayerItemSlot]
            ;
            
            if (callback != -1)
            {
                g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] = 1;
                Inventory_UpdateDropCount(playerid);

                __emit {
                    push.s slot
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
        }

        if (playertextid == p_tdItemOptions[playerid]{0})
        {
            for(new j; j < 6; ++j)
		        PlayerTextDrawHide(playerid, p_tdItemOptions[playerid]{j});

            PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
            ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 1000, 1);

            new Float:x, Float:y, Float:z, Float:angle;
            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, angle);

            GetXYFromAngle(x, y, angle, 0.8);
            DroppedItem_Create(
                InventorySlot_Type(playerid, g_rgePlayerTempData[playerid][e_iPlayerItemSlot]),
                g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount],
                InventorySlot_Extra(playerid, g_rgePlayerTempData[playerid][e_iPlayerItemSlot]),
                x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid
            );

            InventorySlot_Subtract(playerid, g_rgePlayerTempData[playerid][e_iPlayerItemSlot], g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount]);
        
            g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] = 1;
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


forward INV_RefreshDroppedItems();
public INV_RefreshDroppedItems()
{
    foreach(new i : DroppedItems)
    {
        new info[6];
        printf("a3");
        Streamer_GetArrayData(STREAMER_TYPE_AREA, i, E_STREAMER_CUSTOM(0x49544D), info);

        if (gettime() > info[4])
            i = DroppedItem_Delete(i);
    }
    return 1;
}


public OnGameModeInit()
{
    SetTimer("INV_RefreshDroppedItems", 180000, true);

    #if defined INV_OnGameModeInit
        return INV_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit INV_OnGameModeInit
#if defined INV_OnGameModeInit
    forward INV_OnGameModeInit();
#endif


forward INV_OnItemInserted(playerid, slot, type, amount, extra);
public INV_OnItemInserted(playerid, slot, type, amount, extra)
{
    printf("[MIERDAS11] slot: %d, type: %d", slot, type);
    g_rgePlayerInventory[playerid][slot][e_bValid] = true;
    g_rgePlayerInventory[playerid][slot][e_iID] = cache_insert_id();
    g_rgePlayerInventory[playerid][slot][e_iType] = type;
    printf("[MIERDAS2] slot: %d, type: %d", slot, g_rgePlayerInventory[playerid][slot][e_iType]);
    g_rgePlayerInventory[playerid][slot][e_iAmount] = amount;
    g_rgePlayerInventory[playerid][slot][e_iExtra] = extra;
    return 1;
}

public OnDynamicObjectMoved(objectid)
{
    if(Streamer_HasIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_CUSTOM(0x4449544D)))
    {
        new Float:x, Float:y, Float:z;
        GetDynamicObjectPos(objectid, x, y, z);
        Sound_PlayInRange(
            g_rgeDropSounds[ random(sizeof(g_rgeDropSounds)) ],
            50.0, x, y, z, 
            Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_WORLD_ID),
            Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_INTERIOR_ID)
        );
    }

    #if defined INV_OnDynamicObjectMoved
        return INV_OnDynamicObjectMoved(objectid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnDynamicObjectMoved
    #undef OnDynamicObjectMoved
#else
    #define _ALS_OnDynamicObjectMoved
#endif
#define OnDynamicObjectMoved INV_OnDynamicObjectMoved
#if defined INV_OnDynamicObjectMoved
    forward INV_OnDynamicObjectMoved(objectid);
#endif
