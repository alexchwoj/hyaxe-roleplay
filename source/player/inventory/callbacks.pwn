#if defined _inventory_callbacks_
    #endinput
#endif
#define _inventory_callbacks_


public OnPlayerCancelTDSelection(playerid)
{
    if (Bit_Get(Player_Flags(playerid), PFLAG_USING_INV) || Bit_Get(Player_Flags(playerid), PFLAG_USING_SECONDARY_INV))
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

forward TRUNK_CloseVehicleBoot(playerid, vehicleid);
public TRUNK_CloseVehicleBoot(playerid, vehicleid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);
    g_rgePlayerTempData[playerid][e_bPassingItems] = false;
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_SPRINT) && (newkeys & KEY_NO) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !g_rgePlayerTempData[playerid][e_bPassingItems] && !Bit_Get(Player_Flags(playerid), PFLAG_INJURED))
    {
        new vehicleid = GetPlayerCameraTargetVehicle(playerid);
        if (IsValidVehicle(vehicleid))
        {
            new Float:x, Float:y, Float:z;
            GetVehiclePos(vehicleid, x, y, z);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
            {
                if (Vehicle_OwnerId(vehicleid) == playerid)
                {
                    new weaponid = GetPlayerWeapon(playerid);
                    if (weaponid)
                    {
                        if (Trunk_InsertItem(vehicleid, Item_WeaponToType(weaponid), 1, 1))
                        {
                            Player_RemoveWeaponSlot(playerid, GetWeaponSlot(weaponid));
                            SetPlayerArmedWeapon(playerid, 0);

                            new engine, lights, alarm, doors, bonnet, boot, objective;
	                        GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	                        SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);

                            PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
                            ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 2000, 1);

                            SetTimerEx("TRUNK_CloseVehicleBoot", 1500, false, "ii", playerid, vehicleid);
                            g_rgePlayerTempData[playerid][e_bPassingItems] = true;
                        }
                        else
                            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "El maletero está lleno.");
                    }
                    else
                        Trunk_Show(playerid, vehicleid);
                }
            }
        }
    }
    else if ((newkeys & KEY_NO) != 0 && !g_rgePlayerTempData[playerid][e_bPassingItems])
    {
        if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !Bit_Get(Player_Flags(playerid), PFLAG_IN_KEYGAME) && !Bit_Get(Player_Flags(playerid), PFLAG_ARRESTED))
            Inventory_Show(playerid);
    }
    else if ((newkeys & KEY_WALK) != 0 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        new areas = GetPlayerNumberDynamicAreas(playerid);
        if (areas)
        {
            YSI_UNSAFE_HUGE_STRING[areas] = INVALID_STREAMER_ID;
            GetPlayerDynamicAreas(playerid, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH);

            for(new i; YSI_UNSAFE_HUGE_STRING[i] != INVALID_STREAMER_ID; ++i)
            {
                new areaid = YSI_UNSAFE_HUGE_STRING[i];
                if (Streamer_HasArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x49544d)))
                {
                    new info[6];
                    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x49544d), info);
                    
                    new weapon = Item_TypeToWeapon(info[0]);
                    if (weapon)
                    {
                        Player_GiveWeapon(playerid, weapon);

                        DroppedItem_Delete(areaid);
                        PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
                        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 1000, 1);
                    }
                    else if (Inventory_AddItem(playerid, info[0], info[1], info[5]))
                    {
                        DroppedItem_Delete(areaid);
                        PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
                        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 1000, 1);
                    }
                    else return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Tienes el inventario lleno.");

                    return 1;
                }
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

    printf("===== Loading inventory from playerid %d =====", playerid);
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
    printf("=====================================");
    return 1;
}

forward TRUNK_LoadFromDatabase(vehicleid);
public TRUNK_LoadFromDatabase(vehicleid)
{
    new row_count;
    cache_get_row_count(row_count);

    printf("===== Loading trunk from vehicleid %d =====", vehicleid);
    for(new i = 0; i < row_count; ++i)
    {
        new slot = Trunk_GetFreeSlot(vehicleid);
        if (slot < HYAXE_MAX_TRUNK_SLOTS)
        {
            g_rgeVehicleTrunk[vehicleid][slot][e_bValid] = true;
            cache_get_value_name_int(i, "ID", g_rgeVehicleTrunk[vehicleid][slot][e_iID]);
            cache_get_value_name_int(i, "ITEM_TYPE", g_rgeVehicleTrunk[vehicleid][slot][e_iType]);
            cache_get_value_name_int(i, "AMOUNT", g_rgeVehicleTrunk[vehicleid][slot][e_iAmount]);
            cache_get_value_name_int(i, "EXTRA", g_rgeVehicleTrunk[vehicleid][slot][e_iExtra]);
        }
        else
        {
            DEBUG_PRINT("full trunk: %d", vehicleid);
        }
    }
    printf("=====================================");
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
    for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
    {
        Inventory_ResetSlot(playerid, i);
    }

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
        // Select item
        for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	    {
            if (playertextid == p_tdItemView[playerid]{i})
            {
                if (i == g_rgePlayerTempData[playerid][e_iPlayerItemSlot] && InventorySlot_IsValid(playerid, i))
                {
                    g_rgePlayerTempData[playerid][e_iPlayerItemSlot] = i;
                    g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] = 1;
                    OnPlayerClickPlayerTextDraw(playerid, p_tdItemOptions[playerid]{1});
                }
                else
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
        }

        if (playertextid == p_tdItemOptions[playerid]{4}) // Increase drop count
        {
            ++g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount];
            if (g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] > InventorySlot_Amount(playerid, g_rgePlayerTempData[playerid][e_iPlayerItemSlot]))
                g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] = InventorySlot_Amount(playerid, g_rgePlayerTempData[playerid][e_iPlayerItemSlot]);
        
            Inventory_UpdateDropCount(playerid);
            PlayerPlaySound(playerid, SOUND_BACK);
        }

        if (playertextid == p_tdItemOptions[playerid]{3}) // Reduce drop count
        {
            --g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount];
            if (g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] < 1)
                g_rgePlayerTempData[playerid][e_iPlayerDropItemAmount] = 1;

            Inventory_UpdateDropCount(playerid);
            PlayerPlaySound(playerid, SOUND_NEXT);
        }

        if (playertextid == p_tdItemOptions[playerid]{1}) // Use item
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

        if (playertextid == p_tdItemOptions[playerid]{0}) // Drop item
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

    if (Bit_Get(Player_Flags(playerid), PFLAG_USING_SECONDARY_INV))
    {
        new vehicleid = g_rgePlayerTempData[playerid][e_iLastTrunk];
        if (!IsValidVehicle(vehicleid))
            return Inventory_Hide(playerid);

        // Inventory slots
        for(new i; i < HYAXE_MAX_INVENTORY_SLOTS; ++i)
	    {
            if (playertextid == p_tdItemView[playerid]{i})
            {
                if ( InventorySlot_IsValid(playerid, i) )
                {
                    if (Trunk_InsertItem(vehicleid, InventorySlot_Type(playerid, i), InventorySlot_Amount(playerid, i), InventorySlot_Extra(playerid, i), playerid))
                    {
                        InventorySlot_Delete(playerid, i);
                        PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
                    }
                    break;
                }
            }
        }

        // Trunk slots
        for(new i; i < HYAXE_MAX_TRUNK_SLOTS; ++i)
	    {
            if (playertextid == p_tdTrunkItemView[playerid]{i})
            {
                if ( TrunkSlot_IsValid(vehicleid, i) )
                {
                    new weaponid = Item_TypeToWeapon(TrunkSlot_Type(vehicleid, i));
                    if (weaponid)
                    {
                        new slot = GetWeaponSlot(weaponid);
                        if (g_rgiPlayerWeapons[playerid][slot])
                        {
                            new name[32];
                            GetWeaponName(g_rgiPlayerWeapons[playerid][slot], name);

                            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "No puedes quitar esta arma porque tienes otra que ocupa su lugar (%s).", name);
                            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, HYAXE_UNSAFE_HUGE_STRING);
                            return 1;
                        }

                        Player_GiveWeapon(playerid, weaponid);
                        SetPlayerArmedWeapon(playerid, 0);

                        TrunkSlot_Delete(vehicleid, i);
                        Trunk_Update(playerid, vehicleid);

                        PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
                    }
                    else if (Inventory_AddItem(playerid, TrunkSlot_Type(vehicleid, i), TrunkSlot_Amount(vehicleid, i), TrunkSlot_Extra(vehicleid, i)))
                    {
                        TrunkSlot_Delete(vehicleid, i);
                        Trunk_Update(playerid, vehicleid);

                        PlayerPlaySound(playerid, g_rgeDressingSounds[ random(sizeof(g_rgeDressingSounds)) ]);
                    }
                    break;
                }
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


forward INV_RefreshDroppedItems();
public INV_RefreshDroppedItems()
{
    foreach(new i : DroppedItems)
    {
        new info[6];
        Streamer_GetArrayData(STREAMER_TYPE_AREA, i, E_STREAMER_CUSTOM(0x49544D), info);

        if (gettime() > info[4])
            i = DroppedItem_Delete(i);
    }
    return 1;
}


public OnScriptInit()
{
    SetTimer("INV_RefreshDroppedItems", 180000, true);

    #if defined INV_OnScriptInit
        return INV_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit INV_OnScriptInit
#if defined INV_OnScriptInit
    forward INV_OnScriptInit();
#endif


forward INV_OnItemInserted(playerid, slot, type, amount, extra);
public INV_OnItemInserted(playerid, slot, type, amount, extra)
{
    printf("INV_OnItemInserted(playerid = %d, slot = %d, type = %d, amount = %d, extra = %d)", playerid, slot, type, amount, extra);

    g_rgePlayerInventory[playerid][slot][e_bValid] = true;
    g_rgePlayerInventory[playerid][slot][e_iID] = cache_insert_id();
    g_rgePlayerInventory[playerid][slot][e_iType] = type;
    g_rgePlayerInventory[playerid][slot][e_iAmount] = amount;
    g_rgePlayerInventory[playerid][slot][e_iExtra] = extra;

    Inventory_Update(playerid);
    return 1;
}

forward TRUNK_OnItemInserted(vehicleid, slot, type, amount, extra, playerid);
public TRUNK_OnItemInserted(vehicleid, slot, type, amount, extra, playerid)
{
    printf("TRUNK_OnItemInserted(vehicleid = %d, slot = %d, type = %d, amount = %d, extra = %d, playerid = %d)", vehicleid, slot, type, amount, extra, playerid);
    g_rgeVehicleTrunk[vehicleid][slot][e_bValid] = true;
    g_rgeVehicleTrunk[vehicleid][slot][e_iID] = cache_insert_id();
    g_rgeVehicleTrunk[vehicleid][slot][e_iType] = type;
    g_rgeVehicleTrunk[vehicleid][slot][e_iAmount] = amount;
    g_rgeVehicleTrunk[vehicleid][slot][e_iExtra] = extra;

    if (IsPlayerConnected(playerid))
    {
        if (Bit_Get(Player_Flags(playerid), PFLAG_USING_INV) || Bit_Get(Player_Flags(playerid), PFLAG_USING_SECONDARY_INV))
        {
            Trunk_Update(playerid, g_rgePlayerTempData[playerid][e_iLastTrunk]);
        }
    }
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
