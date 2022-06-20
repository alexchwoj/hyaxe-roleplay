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

static Crack_OnUse(playerid, slot)
{
    ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, false, true, true, false, 1000);
    PlayerPlaySound(playerid, SOUND_EAT);

    Notification_ShowBeatingText(playerid, 2000, 0xF7F7F7, 100, 255, "Has usado un gramo de crack (~g~+10~w~ de chaleco)");
    Player_SetArmour(playerid, Player_Armour(playerid) + 10);

    InventorySlot_Subtract(playerid, slot);
    return 1;
}

static Food_OnUse(playerid, slot)
{
    new type = InventorySlot_Type(playerid, slot);

    if (Item_Puke(type))
    {
        Player_Puke(playerid);
    }
    else
    {
        if (Item_Hunger(type) >= Item_Thirst(type))
        {
            ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, false, true, true, false, 1000);
        }
        else
        {
            ApplyAnimation(playerid, "BAR", "DNK_STNDM_LOOP", 4.1, false, false, false, false, 0, false);
        }
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    Sound_PlayInRange(SOUND_EAT, x, y, z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

    if (Item_DrunkLevel(type))
        SetPlayerDrunkLevel(playerid, Item_DrunkLevel(type));

    Player_AddHunger(playerid, Item_Hunger(type));
    Player_AddThirst(playerid, Item_Thirst(type));

    InventorySlot_Subtract(playerid, slot);
    return 1;
}

public OnGameModeInit()
{
    /* Medical */

    // Medic kit
    Item_SetPreviewRot(ITEM_MEDIC_KIT, 1.000000, 0.000000, -28.000000, 1.000000);

    // Medicine
    Item_Callback(ITEM_MEDICINE) = __addressof(Medicine_OnUse);
    Item_SetPreviewRot(ITEM_MEDICINE, 86.000000, 0.000000, 22.000000, 1.000000);

    // Crack
    Item_Rarity(ITEM_CRACK) = RARITY_RARE;
    Item_Callback(ITEM_CRACK) = __addressof(Crack_OnUse);
    Item_SetPreviewRot(ITEM_CRACK, -38.000000, 0.000000, 159.000000, 1.000000);

    /* Vehicles */

    // Petrol can
    Item_SetPreviewRot(ITEM_PETROL_CAN, -21.000000, 0.000000, 159.000000, 1.000000);

    // Repair kit
    Item_SetPreviewRot(ITEM_REPAIR_KIT, -196.000000, 0.000000, 6.000000, 1.000000);

    /* Other */

    // Phone
    Item_SetPreviewRot(ITEM_PHONE, -91.000000, 0.000000, 254.000000, 1.000000);

    // Porro
    Item_SetPreviewRot(ITEM_PORRETE, 0.000000, 0.000000, 0.000000, 1.000000);

    /* Food */

    // Burrito
    Item_Hunger(ITEM_BURRITO) = -10.0;
    Item_Callback(ITEM_BURRITO) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_BURRITO, -46.000000, 0.000000, 2.000000, 1.000000);

    // Burger
    Item_Hunger(ITEM_BURGER) = -15.0;
    Item_Callback(ITEM_BURGER) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_BURGER, -79.000000, 0.000000, -14.000000, 1.000000);

    // Meat
    Item_Hunger(ITEM_MEAT) = -5.0;
    Item_Callback(ITEM_MEAT) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_MEAT, -79.000000, 0.000000, -127.000000, 1.000000);

    // Ham
    Item_Hunger(ITEM_HAM) = -25.0;
    Item_Callback(ITEM_HAM) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_HAM, -64.000000, 0.000000, 64.000000, 1.000000);

    // Orange
    Item_Hunger(ITEM_ORANGE) = -5.0;
    Item_Thirst(ITEM_ORANGE) = -3.0;
    Item_Callback(ITEM_ORANGE) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_ORANGE, 0.000000, 0.000000, 0.000000, 1.000000);

    // Toast
    Item_Hunger(ITEM_TOAST) = -4.0;
    Item_Callback(ITEM_TOAST) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_TOAST, -64.000000, 0.000000, 64.000000, 1.000000);

    // Milk
    Item_Hunger(ITEM_MILK) = -8.0;
    Item_Thirst(ITEM_MILK) = -10.0;
    Item_Callback(ITEM_MILK) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_MILK, 0.000000, 0.000000, 64.000000, 1.000000);

    // Orange juice
    Item_Thirst(ITEM_ORANGE_JUICE) = -10.0;
    Item_Callback(ITEM_ORANGE_JUICE) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_ORANGE_JUICE, 0.000000, 0.000000, -26.000000, 1.000000);

    // Apple juice
    Item_Thirst(ITEM_APPLE_JUICE) = -10.0;
    Item_Callback(ITEM_APPLE_JUICE) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_APPLE_JUICE, 0.000000, 0.000000, -26.000000, 1.000000);

    // Ketchup
    Item_Hunger(ITEM_KETCHUP) = -2.0;
    Item_Callback(ITEM_KETCHUP) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_KETCHUP, 0.000000, 0.000000, -26.000000, 1.000000);

    // Chocolate ice cream
    Item_Hunger(ITEM_CHOCOLATE_ICE_CREAM) = -18.0;
    Item_Callback(ITEM_CHOCOLATE_ICE_CREAM) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_CHOCOLATE_ICE_CREAM, -29.000000, 0.000000, -26.000000, 1.000000);

    // Strawberry ice cream
    Item_Hunger(ITEM_STRAWBERRY_ICE_CREAM) = -18.0;
    Item_Callback(ITEM_STRAWBERRY_ICE_CREAM) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_STRAWBERRY_ICE_CREAM, -29.000000, 0.000000, -26.000000, 1.000000);

    // Pizza
    Item_Hunger(ITEM_PIZZA) = -20.0;
    Item_Callback(ITEM_PIZZA) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_PIZZA, -29.000000, 0.000000, -26.000000, 1.000000);

    // Cepita del valle...
    Item_Thirst(ITEM_CEPITA) = -30.0;
    Item_Callback(ITEM_CEPITA) = __addressof(Food_OnUse);
    Item_Rarity(ITEM_CEPITA) = RARITY_LEGENDARY;
    Item_SetPreviewRot(ITEM_CEPITA, 0.000000, 0.000000, -26.000000, 1.000000);

    // Beer
    Item_DrunkLevel(ITEM_BEER) = 4000;
    Item_Thirst(ITEM_BEER) = -12.0;
    Item_Callback(ITEM_BEER) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_BEER, -29.000000, 0.000000, -26.000000, 1.000000);

    // Wisky
    Item_DrunkLevel(ITEM_WISKY) = 8000;
    Item_Thirst(ITEM_WISKY) = -12.0;
    Item_Callback(ITEM_WISKY) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_WISKY, -29.000000, 0.000000, -26.000000, 1.000000);

    // Champagne
    Item_DrunkLevel(ITEM_CHAMPAGNE) = 4000;
    Item_Thirst(ITEM_CHAMPAGNE) = -13.0;
    Item_Callback(ITEM_CHAMPAGNE) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_CHAMPAGNE, -29.000000, 0.000000, -26.000000, 1.000000);

    // Craft Beer
    Item_DrunkLevel(ITEM_CRAFT_BEER) = 4000;
    Item_Thirst(ITEM_CRAFT_BEER) = -10.0;
    Item_Callback(ITEM_CRAFT_BEER) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_CRAFT_BEER, -29.000000, 0.000000, -26.000000, 1.000000);

    // Chicken
    Item_Hunger(ITEM_CHICKEN) = -10.0;
    Item_Callback(ITEM_CHICKEN) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_CHICKEN, -29.000000, 0.000000, 51.000000, 1.000000);

    // Coffe
    Item_Thirst(ITEM_COFFE) = -8.0;
    Item_Callback(ITEM_COFFE) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_COFFE, -29.000000, 0.000000, 51.000000, 1.000000);

    // Sanguche de milanesa
    Item_Hunger(ITEM_SANGUCHEDEMILANESA) = -100.0;
    Item_Callback(ITEM_SANGUCHEDEMILANESA) = __addressof(Food_OnUse);
    Item_Rarity(ITEM_SANGUCHEDEMILANESA) = RARITY_MYTHIC;
    Item_SetPreviewRot(ITEM_SANGUCHEDEMILANESA, -79.000000, 0.000000, -14.000000, 1.000000);

    /* Fisherman */

    // Fishing rod
    Item_Callback(ITEM_FISHING_ROD) = __addressof(FishingRod_OnUse);
    Item_SetPreviewRot(ITEM_FISHING_ROD, -2.000000, 8.000000, -138.000000, 1.000000);

    // Fish
    Item_Puke(ITEM_FISH) = true;
    Item_Hunger(ITEM_FISH) = -20.0;
    Item_Thirst(ITEM_FISH) = 40.0;
    Item_Callback(ITEM_FISH) = __addressof(Food_OnUse);
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
