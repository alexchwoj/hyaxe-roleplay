#if defined _medicine_callbacks_
    #endinput
#endif
#define _medicine_callbacks_

static Medicine_OnUse(playerid, slot)
{
    if (Player_Health(playerid) >= 50)
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Tienes 50 de salud, consigue un botiquín para curarte completamente.");

    ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, false, true, true, false, 1000);
    PlayerPlaySound(playerid, SOUND_EAT);

    Notification_ShowBeatingText(playerid, 2000, 0xF7F7F7, 100, 255, "Has usado un medicamento (~g~+10~w~ de salud)");
    Player_SetHealth(playerid, Player_Health(playerid) + 10);

    InventorySlot_Subtract(playerid, slot);
    return 1;
}

public OnGameModeInit()
{
    // Medic kit
    Item_SetPreviewRot(ITEM_MEDIC_KIT, 1.000000, 0.000000, -28.000000, 1.000000);

    // Medicine
    Item_Callback(ITEM_MEDICINE) = __addressof(Medicine_OnUse);
    Item_SetPreviewRot(ITEM_MEDICINE, 86.000000, 0.000000, 22.000000, 1.000000);

    // Crack
    Item_Rarity(ITEM_CRACK) = RARITY_RARE;
    Item_SetPreviewRot(ITEM_CRACK, -38.000000, 0.000000, 159.000000, 1.000000);

    // Petrol can
    Item_SetPreviewRot(ITEM_PETROL_CAN, -21.000000, 0.000000, 159.000000, 1.000000);

    // Phone
    Item_SetPreviewRot(ITEM_PHONE, -91.000000, 0.000000, 254.000000, 1.000000);

    // Repair kit
    Item_SetPreviewRot(ITEM_REPAIR_KIT, -196.000000, 0.000000, 6.000000, 1.000000);

    // Porro
    Item_SetPreviewRot(ITEM_PORRETE, 0.000000, 0.000000, 0.000000, 1.000000);

    // Burrito
    Item_SetPreviewRot(ITEM_BURRITO, -46.000000, 0.000000, 2.000000, 1.000000);

    // Burger
    Item_SetPreviewRot(ITEM_BURGER, -79.000000, 0.000000, -14.000000, 1.000000);

    // Meat
    Item_SetPreviewRot(ITEM_MEAT, -79.000000, 0.000000, -127.000000, 1.000000);

    // Ham
    Item_SetPreviewRot(ITEM_HAM, -64.000000, 0.000000, 64.000000, 1.000000);

    // Orange
    Item_SetPreviewRot(ITEM_ORANGE, 0.000000, 0.000000, 0.000000, 1.000000);

    // Toast
    Item_SetPreviewRot(ITEM_TOAST, -64.000000, 0.000000, 64.000000, 1.000000);

    // Milk
    Item_SetPreviewRot(ITEM_MILK, 0.000000, 0.000000, 64.000000, 1.000000);

    // Orange juice
    Item_SetPreviewRot(ITEM_ORANGE_JUICE, 0.000000, 0.000000, -26.000000, 1.000000);

    // Apple juice
    Item_SetPreviewRot(ITEM_APPLE_JUICE, 0.000000, 0.000000, -26.000000, 1.000000);

    // Ketchup
    Item_SetPreviewRot(ITEM_KETCHUP, 0.000000, 0.000000, -26.000000, 1.000000);

    // Chocolate ice cream
    Item_SetPreviewRot(ITEM_CHOCOLATE_ICE_CREAM, -29.000000, 0.000000, -26.000000, 1.000000);

    // Strawberry ice cream
    Item_SetPreviewRot(ITEM_STRAWBERRY_ICE_CREAM, -29.000000, 0.000000, -26.000000, 1.000000);

    // Pizza
    Item_SetPreviewRot(ITEM_PIZZA, -29.000000, 0.000000, -26.000000, 1.000000);

    // Cepita del valle...
    Item_Rarity(ITEM_CEPITA) = RARITY_LEGENDARY;
    Item_SetPreviewRot(ITEM_CEPITA, 0.000000, 0.000000, -26.000000, 1.000000);

    // Beer
    Item_SetPreviewRot(ITEM_BEER, -29.000000, 0.000000, -26.000000, 1.000000);

    // Wisky
    Item_SetPreviewRot(ITEM_WISKY, -29.000000, 0.000000, -26.000000, 1.000000);

    // Champagne
    Item_SetPreviewRot(ITEM_CHAMPAGNE, -29.000000, 0.000000, -26.000000, 1.000000);

    // Craft Beer
    Item_SetPreviewRot(ITEM_CRAFT_BEER, -29.000000, 0.000000, -26.000000, 1.000000);

    // Chicken
    Item_SetPreviewRot(ITEM_CHICKEN, -29.000000, 0.000000, 51.000000, 1.000000);

    // Coffe
    Item_SetPreviewRot(ITEM_COFFE, -29.000000, 0.000000, 51.000000, 1.000000);

    // Sanguche de milanesa
    Item_Rarity(ITEM_SANGUCHEDEMILANESA) = RARITY_MYTHIC;
    Item_SetPreviewRot(ITEM_SANGUCHEDEMILANESA, -79.000000, 0.000000, -14.000000, 1.000000);

    // Fishing rod
    Item_Callback(ITEM_FISHING_ROD) = __addressof(FishingRod_OnUse);
    Item_SetPreviewRot(ITEM_FISHING_ROD, -2.000000, 8.000000, -138.000000, 1.000000);

    // Fish
    Item_SetPreviewRot(ITEM_FISH, -19.000000, 49.000000, -171.000000, 0.770000);

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
