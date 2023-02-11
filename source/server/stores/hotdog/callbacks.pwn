#if defined _hotdog_callbacks_
    #endinput
#endif
#define _hotdog_callbacks_

static HOTDOG_OnPress(playerid)
{
    Menu_Show(playerid, "hotdog_buy", "Comprar");
    Menu_AddItem(playerid, "Pancho", "Precio: ~g~$50");
    Menu_AddItem(playerid, "Cepita del Valle", "Precio: ~g~$75");
    Menu_UpdateListitems(playerid);
    return 1;
}

player_menu hotdog_buy(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_SELECT)
    {
        switch (listitem)
        {
            case 0:
            {
                if (50 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -50);
                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un pancho.");
                Inventory_AddFixedItem(playerid, ITEM_HOTDOG, 1, 0);
            }

            case 1:
            {
                if (75 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -75);
                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un Cepita del Valle.");
                Inventory_AddFixedItem(playerid, ITEM_CEPITA, 1, 0);
            }
        }
    }
    return 1;
}

public OnScriptInit()
{
    for (new i; i < sizeof(g_rgfHotdogPos); ++i)
    {
        CreateDynamicActor(168, g_rgfHotdogPos[i][0], g_rgfHotdogPos[i][1], g_rgfHotdogPos[i][2], g_rgfHotdogPos[i][3], .worldid = 0, .interiorid = 0);

        CreateDynamic3DTextLabel("{DADADA}Panchero", 0xDADADA00, g_rgfHotdogPos[i][0], g_rgfHotdogPos[i][1], g_rgfHotdogPos[i][2] + 1.0, 5.0, .worldid = 0, .interiorid = 0);

		GetXYFromAngle(g_rgfHotdogPos[i][0], g_rgfHotdogPos[i][1], g_rgfHotdogPos[i][3], 1.0);
		CreateDynamicObject(
			1340,
			g_rgfHotdogPos[i][0], g_rgfHotdogPos[i][1], g_rgfHotdogPos[i][2],
			0.0, 0.0, g_rgfHotdogPos[i][3] + 90.0, 0, 0
		);

        Key_Alert(
            g_rgfHotdogPos[i][0], g_rgfHotdogPos[i][1], g_rgfHotdogPos[i][2], 1.8,
            KEYNAME_YES, 0, 0,
            .callback_on_press = __addressof(HOTDOG_OnPress), .cb_data = i
        );
    }

    #if defined HOTDOG_OnScriptInit
        return HOTDOG_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit HOTDOG_OnScriptInit
#if defined HOTDOG_OnScriptInit
    forward HOTDOG_OnScriptInit();
#endif
