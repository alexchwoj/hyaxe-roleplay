#if defined _fisherman_callbacks_
    #endinput
#endif
#define _fisherman_callbacks_

static RodStore_OnKeyPress(playerid)
{
    Dialog_ShowCallback(playerid, using public _hydg@buy_fishing_rod<iiiis>, DIALOG_STYLE_MSGBOX, !"{CB3126}Caña de pescar", !"{DADADA}¿Quieres comprar una caña de pescar por {64A752}$75{DADADA}?", !"Comprar", !"Cerrar");
    return 1;
}

static FishMarket_OnKeyPress(playerid)
{
    if (!Inventory_GetItemCount(playerid, ITEM_FISH))
        return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Necesitas al menos 5 peces.");
        
    new amount = Inventory_GetItemAmount(playerid, ITEM_FISH);
    if (amount < 5)
        return Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Necesitas al menos 5 peces.");

    format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "{DADADA}¿Quieres vender %d %s por {64A752}$%d{DADADA}?", amount, (amount > 1 ? "peces" : "pez"), 10 * amount);
    Dialog_ShowCallback(playerid, using public _hydg@sell_fish<iiiis>, DIALOG_STYLE_MSGBOX, !"{CB3126}Pescadería", HYAXE_UNSAFE_HUGE_STRING, !"Vender", !"Cerrar");

    return 1;
}

public OnScriptInit()
{
    CreateDynamic3DTextLabel("{CB3126}Trabajo de pescador{DADADA}\nCompra una caña de pescar en la tienda de al lado para empezar\na trabajar. Puedes pescar en cualquier lugar con agua y luego\npuedes vender el pescado en la pescadería de al lado.", 0xDADADAFF, 2156.9067, -97.8114, 3.1911, 13.0, .testlos = 1, .worldid = 0, .interiorid = 0);

    // Rod store
    CreateDynamicActor(34, 2157.2991, -107.2062, 2.6883, 115.4688, .worldid = 0, .interiorid = 0);
    CreateDynamic3DTextLabel("{CB3126}Caña de pescar{DADADA}\nPresiona {CB3126}Y{DADADA} para comprar", 0xDADADAFF, 2154.5454, -108.4645, 2.6524, 10.0, .testlos = 1, .worldid = 0, .interiorid = 0);
    Key_Alert(2154.5454, -108.4645, 2.6524, 2.6, KEYNAME_YES, 0, 0, .callback_on_press = __addressof(RodStore_OnKeyPress));

    // Fish store
    CreateDynamicActor(44, 2154.6438, -102.8098, 2.6685, 128.2921, .worldid = 0, .interiorid = 0);
    CreateDynamic3DTextLabel("{CB3126}Pescadería{DADADA}\nPresiona {CB3126}Y{DADADA} para vender", 0xDADADAFF, 2152.4070, -104.5057, 2.6569, 10.0, .testlos = 1, .worldid = 0, .interiorid = 0);
    Key_Alert(2152.4070, -104.5057, 2.6569, 2.6, KEYNAME_YES, 0, 0, .callback_on_press = __addressof(FishMarket_OnKeyPress));

    CreateDynamicActor(222, 2137.2734, -49.2241, 3.3297, 103.5150, .worldid = 0, .interiorid = 0);
    CreateDynamicActor(77, 2134.7053, -42.9645, 3.0114, 111.9517, .worldid = 0, .interiorid = 0);
    
    #if defined FISH_OnScriptInit
        return FISH_OnScriptInit(); 
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit FISH_OnScriptInit
#if defined FISH_OnScriptInit
    forward FISH_OnScriptInit();
#endif

static Fisherman_KeyGameCallback(playerid, bool:success)
{
    TogglePlayerControllable(playerid, true);

    if (success)
    {
        Player_AddXP(playerid, 10);
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
        TogglePlayerControllable(playerid, false);
        SetPlayerAttachedObject(playerid, 9, 18632, 6, 0.0620, 0.0199, 0.0149, 9.1999, 171.9999, 103.0999, 0.8920, 0.9029, 1.0589, 0xFFFFFFFF, 0xFFFFFFFF);

        Player_StartKeyGame(playerid, __addressof(Fisherman_KeyGameCallback), 9.9, 2.5);

        ApplyAnimation(playerid, "SWORD", "SWORD_IDLE", 4.1, true, false, false, false, 0, true);
    }
    else
        Notification_ShowBeatingText(playerid, 4000, 0xED2B2B, 100, 255, "Tienes que estar frente al agua para poder pescar.");

    return 1;
}

dialog sell_fish(playerid, dialogid, response, listitem, inputtext[])
{
    if (response)
    {
        new amount = Inventory_GetItemAmount(playerid, ITEM_FISH);
        new pay = Job_ApplyPaycheckBenefits(playerid, 10 * amount);

        Player_AddXP(playerid, amount);
        Player_GiveMoney(playerid, pay);
        PlayerPlaySound(playerid, SOUND_SUCCESS);

        Inventory_DeleteItemByType(playerid, ITEM_FISH);

        if(amount > 1)
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Vendiste tus %d peces por $%d", amount, pay);
        else
            format(HYAXE_UNSAFE_HUGE_STRING, HYAXE_UNSAFE_HUGE_LENGTH, "Vendiste un pez por $%d", pay);

        Notification_Show(playerid, HYAXE_UNSAFE_HUGE_STRING, 4000, 0x64A752FF);
    }
    return 1;
}

dialog buy_fishing_rod(playerid, dialogid, response, listitem, inputtext[])
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

public OnPlayerConnect(playerid)
{
    ApplyAnimation(playerid, "OTB", "WTCHRACE_WIN", 4.1, false, false, false, false, 0, true);
    ApplyAnimation(playerid, "OTB", "WTCHRACE_LOSE", 4.1, false, false, false, false, 0, true);
    ApplyAnimation(playerid, "SWORD", "SWORD_IDLE", 4.1, true, false, false, false, 0, true);

    #if defined FISH_OnPlayerConnect
        return FISH_OnPlayerConnect(playerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect FISH_OnPlayerConnect
#if defined FISH_OnPlayerConnect
    forward FISH_OnPlayerConnect(playerid);
#endif
