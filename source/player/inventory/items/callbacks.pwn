#if defined _medicine_callbacks_
    #endinput
#endif
#define _medicine_callbacks_

static Medicine_OnUse(playerid, slot)
{
    if (Player_Health(playerid) >= 50)
        Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Tienes 50 de salud, consigue un botiquín para curarte completamente.");

    Notification_ShowBeatingText(playerid, 2000, 0xF7F7F7, 100, 255, "Has usado un medicamento (~g~+10~w~ de salud)");
    Player_SetHealth(playerid, Player_Health(playerid) + 10);

    InventorySlot_Subtract(playerid, slot);
    Inventory_Update(playerid);
    return 1;
}

public OnGameModeInit()
{
    Item_Callback(ITEM_MEDICINE) = __addressof(Medicine_OnUse);

    #if defined ITEM_OnGameModeInit
        return ITEM_OnGameModeInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit ITEM_OnGameModeInit
#if defined ITEM_OnGameModeInit
    forward ITEM_OnGameModeInit();
#endif
