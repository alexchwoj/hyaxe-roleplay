#if defined _fisherman_callbacks_
    #endinput
#endif
#define _fisherman_callbacks_

static Fisherman_JobEvent(playerid, eJobEvent:event, data)
{
    #pragma unused event
    #pragma unused data

    Notification_Show(playerid, "Compra una caña de pescar en la tienda de al lado para empezar a trabajar. Puedes pescar en cualquier lugar con agua y luego puedes vender el pescado en la pescadería de al lado.", 7000);
    return 1;
}

public OnGameModeInit()
{
    Job_CreateSite(JOB_FISHERMAN, 2156.9067, -97.8114, 3.1911, 0, 0);
    Job_SetCallback(JOB_FISHERMAN, __addressof(Fisherman_JobEvent));

    new area_info[1], area_id;

    // Rod store
    CreateDynamicActor(34, 2157.2991, -107.2062, 2.6883, 115.4688, .worldid = 0, .interiorid = 0);
    CreateDynamic3DTextLabel("{CB3126}Caña de pescar{DADADA}\nPresiona {CB3126}Y{DADADA} para comprar", 0xDADADAFF, 2154.5454, -108.4645, 2.6524, 10.0, .testlos = 1, .worldid = 0, .interiorid = 0);
    Key_Alert(2154.5454, -108.4645, 2.6524, 2.6, KEYNAME_YES, 0, 0);
	
    area_info[0] = 0x726f64; // ROD
	area_id = CreateDynamicSphere(2154.5454, -108.4645, 2.6524, 2.5, 0, 0);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, area_id, E_STREAMER_EXTRA_ID, area_info);

    // Fish store
    CreateDynamicActor(44, 2154.6438, -102.8098, 2.6685, 128.2921, .worldid = 0, .interiorid = 0);
    CreateDynamic3DTextLabel("{CB3126}Pescadería{DADADA}\nPresiona {CB3126}Y{DADADA} para vender", 0xDADADAFF, 2152.4070, -104.5057, 2.6569, 10.0, .testlos = 1, .worldid = 0, .interiorid = 0);
    Key_Alert(2152.4070, -104.5057, 2.6569, 3.5, KEYNAME_YES, 0, 0);
	
    area_info[0] = 0x534653; // SFS
	area_id = CreateDynamicSphere(2154.5454, -108.4645, 2.6524, 3.5, 0, 0);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, area_id, E_STREAMER_EXTRA_ID, area_info);

    CreateDynamicActor(222, 2137.2734, -49.2241, 3.3297, 103.5150, .worldid = 0, .interiorid = 0);
    CreateDynamicActor(77, 2134.7053, -42.9645, 3.0114, 111.9517, .worldid = 0, .interiorid = 0);
    
    #if defined FISH_OnGameModeInit
        return FISH_OnGameModeInit(); 
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit FISH_OnGameModeInit
#if defined FISH_OnGameModeInit
    forward FISH_OnGameModeInit();
#endif

static Fisherman_KeyGameCallback(playerid, bool:success)
{
    TogglePlayerControllable(playerid, true);

    if (success)
    {
        Inventory_AddFixedItem(playerid, ITEM_FISH, 1, 0);

        Notification_Show(playerid, "¡Bien ahí! Has pescado un pez.", 3000, 0x64A752FF);
        ApplyAnimation(playerid, "OTB", "WTCHRACE_WIN", 4.1, false, false, false, false, 0, true);
    }
    else
    {
        ApplyAnimation(playerid, "OTB", "WTCHRACE_LOSE", 4.1, false, false, false, false, 0, true);
        Notification_Show(playerid, "¡Fallaste! el pez se te escapó", 3000);
    }

    RemovePlayerAttachedObject(playerid, 9);
    return 1;
}

FishingRod_OnUse(playerid, slot)
{
    #pragma unused slot
    Inventory_Hide(playerid);

    if ( CA_IsPlayerFacingWater(playerid) )
    {
        // Preload animations
        ApplyAnimation(playerid, "OTB", "null", 4.1, 0, 0, 0, 0, 0, 0);
        ApplyAnimation(playerid, "SWORD", "null", 4.1, 0, 0, 0, 0, 0, 0);

        TogglePlayerControllable(playerid, false);

        SetPlayerAttachedObject(playerid, 9, 18632, 6, 0.0620, 0.0199, 0.0149, 9.1999, 171.9999, 103.0999, 0.8920, 0.9029, 1.0589, 0xFFFFFFFF, 0xFFFFFFFF);

        ApplyAnimation(playerid, "SWORD", "SWORD_IDLE", 4.1, true, false, false, false, 0, true);

        Player_StartKeyGame(playerid, __addressof(Fisherman_KeyGameCallback), 9.9, 2.5);
    }
    else
        Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Tienes que estar frente al agua para poder pescar.");

    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if ((newkeys & KEY_YES) != 0)
    {
        if (GetPlayerNumberDynamicAreas(playerid) > 0)
        {
            new areas[3];
            GetPlayerDynamicAreas(playerid, areas);

            for(new i; i < sizeof(areas); ++i)
            {
                new info[1];
                Streamer_GetArrayData(STREAMER_TYPE_AREA, areas[i], E_STREAMER_EXTRA_ID, info);
                if (info[0] == 0x726f64)
                {
                    Dialog_Show(playerid, "buy_fishing_rod", DIALOG_STYLE_MSGBOX, !"{CB3126}Caña de pescar", !"{DADADA}¿Quieres comprar una caña de pescar por {64A752}$75{DADADA}?", !"Comprar", !"Cerrar");
                }

                if (info[0] == 0x534653)
                {
                    // fish
                }
            }
        }
    }

    #if defined FISH_OnPlayerKeyStateChange
        return FISH_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange FISH_OnPlayerKeyStateChange
#if defined FISH_OnPlayerKeyStateChange
    forward FISH_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

dialog buy_fishing_rod(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        if (75 > Player_Money(playerid))
        {
            PlayerPlaySound(playerid, SOUND_ERROR);
            Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
            return 1;
        }

        Inventory_AddFixedItem(playerid, ITEM_FISHING_ROD, 1, 0);

        Player_GiveMoney(playerid, -75);
        PlayerPlaySound(playerid, SOUND_SUCCESS);

        Notification_Show(playerid, "Has comprado una caña de pescar. Vaya a cualquier lugar con agua para usarla.", 4000, 0x64A752FF);
    }
    return 1;
}