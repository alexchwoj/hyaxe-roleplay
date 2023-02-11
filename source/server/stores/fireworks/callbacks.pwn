#if defined _fireworks_store_callbacks_
    #endinput
#endif
#define _fireworks_store_callbacks_

static PYRO_OnPress(playerid)
{
    Menu_Show(playerid, "pyro_buy", "Pirotecnia");
    Menu_AddItem(playerid, "Lanzador", "Precio: ~g~$150");
    Menu_AddItem(playerid, "Carga Coconut", "Precio: ~g~$300");
    Menu_AddItem(playerid, "Carga Strobe", "Precio: ~g~$300");
    Menu_AddItem(playerid, "Carga Colored", "Precio: ~g~$300");
    Menu_AddItem(playerid, "Carga Fish", "Precio: ~g~$300");
    Menu_AddItem(playerid, "Carga Wave", "Precio: ~g~$300");
    Menu_AddItem(playerid, "Carga Ring", "Precio: ~g~$300");
    Menu_UpdateListitems(playerid);
    return 1;
}

player_menu pyro_buy(playerid, response, listitem)
{
    if (response == MENU_RESPONSE_SELECT)
    {
        printf("listitem = %d", listitem);
        switch (listitem)
        {
            case 0:
            {
                if (150 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -150);
                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste un lanzador.");
                Inventory_AddFixedItem(playerid, ITEM_FIREWORK_LAUNCHER, 1, 0);
            }

            case 1:
            {
                if (300 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -300);
                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una carga Coconut.");
                Inventory_AddFixedItem(playerid, ITEM_COCONUT_CHARGE, 1, 0);
            }

            case 2:
            {
                if (300 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -300);
                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una carga Strobe.");
                Inventory_AddFixedItem(playerid, ITEM_STROBE_CHARGE, 1, 0);
            }

            case 3:
            {
                if (300 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -300);
                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una carga Colored.");
                Inventory_AddFixedItem(playerid, ITEM_COLORED_CHARGE, 1, 0);
            }

            case 4:
            {
                if (300 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -300);
                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una carga Fish.");
                Inventory_AddFixedItem(playerid, ITEM_FISH_CHARGE, 1, 0);
            }

            case 5:
            {
                if (300 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -300);
                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una carga Wave.");
                Inventory_AddFixedItem(playerid, ITEM_WAVE_CHARGE, 1, 0);
            }

            case 6:
            {
                if (300 > Player_Money(playerid))
                {
                    PlayerPlaySound(playerid, SOUND_ERROR);
                    Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "No tienes el dinero suficiente.");
                    return 1;
                }

                Player_GiveMoney(playerid, -300);
                Notification_ShowBeatingText(playerid, 3000, 0x98D592, 100, 255, "Compraste una carga Ring.");
                Inventory_AddFixedItem(playerid, ITEM_RING_CHARGE, 1, 0);
            }
        }
    }
    return 1;
}

public OnScriptInit()
{
    new year, month, day;
    getdate(year, month, day);
    if ( (month == 11 && day >= 27) || (month == 12 && day >= 1) ) // Christmas
    {
        Key_Alert(
            1746.9813, -1130.0811, 24.0781, 3.5,
            KEYNAME_YES, 0, 0,
            .callback_on_press = __addressof(PYRO_OnPress)
        );

        new area = CreateDynamicSphere(1746.9813, -1130.0811, 24.0781, 20.0, 0, 0);
        Streamer_SetIntData(STREAMER_TYPE_AREA, area, E_STREAMER_CUSTOM(0x5059524f), 1); // PYRO

        new actor = CreateActor(33, 1746.9813, -1130.0811, 24.0781, 180.7610);
        CreateDynamicActor(33, 1746.9813, -1130.0811, 24.0781, 180.7610, .worldid = 0, .interiorid = 0);
        ApplyDynamicActorAnimation(actor, "SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0);
        CreateDynamic3DTextLabel("{DADADA}El Pepinero", 0xDADADA00, 1746.9813, -1130.0811, 24.0781 + 1.0, 5.0, .worldid = 0, .interiorid = 0);
    }

    #if defined PYRO_OnScriptInit
        return PYRO_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit PYRO_OnScriptInit
#if defined PYRO_OnScriptInit
    forward PYRO_OnScriptInit();
#endif

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
    if (Streamer_HasIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x5059524f)))
    {
        if (Bit_Get(Player_Config(playerid), CONFIG_MUSIC))
            StopAudioStreamForPlayer(playerid);
    }

    #if defined PYRO_OnPlayerLeaveDynamicArea
        return PYRO_OnPlayerLeaveDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerLeaveDynamicArea
    #undef OnPlayerLeaveDynamicArea
#else
    #define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea PYRO_OnPlayerLeaveDynamicArea
#if defined PYRO_OnPlayerLeaveDynamicArea
    forward PYRO_OnPlayerLeaveDynamicArea(playerid, areaid);
#endif


public OnPlayerEnterDynamicArea(playerid, areaid)
{
    if (Streamer_HasIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x5059524f)))
    {
        if (Bit_Get(Player_Config(playerid), CONFIG_MUSIC))
            PlayAudioStreamForPlayer(playerid, "https://samp.hyaxe.com/static/audio/pyro_store.mp3", 1746.9813, -1130.0811, 24.0781, 10.0, 1);
    }

    #if defined PYRO_OnPlayerEnterDynamicArea
        return PYRO_OnPlayerEnterDynamicArea(playerid, areaid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerEnterDynamicArea
    #undef OnPlayerEnterDynamicArea
#else
    #define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea PYRO_OnPlayerEnterDynamicArea
#if defined PYRO_OnPlayerEnterDynamicArea
    forward PYRO_OnPlayerEnterDynamicArea(playerid, areaid);
#endif