#if defined _medicine_callbacks_
    #endinput
#endif
#define _medicine_callbacks_

static Phone_OnUse(playerid, slot)
{
    #pragma unused slot
    PhoneMenu_Main(playerid);

    return 1;
}

static Flag_OnUse(playerid, slot)
{
    if (Player_Gang(playerid) == -1)
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Tienes que estar en una banda.");

    if (Bit_Get(Player_Flags(playerid), PFLAG_INJURED))
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "No puedes conquistar estando herido.");

    new territory_index = -1;

    new areas = GetPlayerNumberDynamicAreas(playerid);
    if (areas)
    {
        YSI_UNSAFE_HUGE_STRING[areas] = INVALID_STREAMER_ID;
        GetPlayerDynamicAreas(playerid, YSI_UNSAFE_HUGE_STRING, YSI_UNSAFE_HUGE_LENGTH);

        for(new i; YSI_UNSAFE_HUGE_STRING[i] != INVALID_STREAMER_ID; ++i)
        {
            new areaid = YSI_UNSAFE_HUGE_STRING[i];
            if (Streamer_HasIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x544552)))
                territory_index = Streamer_GetIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_CUSTOM(0x544552));
        }
    }

    if (territory_index == -1)
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "No te encuentras en una zona conquistable.");

    if (!g_rgeTerritories[territory_index][e_bIsConquerable])
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "No te encuentras en una zona conquistable.");

    if (g_rgeTerritories[territory_index][e_iGangAttaking] != -1)
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Este territorio ya está siendo conquistado.");

    if (g_rgeGangs[Player_Gang(playerid)][e_bGangAttacking])
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Solo puedes conquistar un territorio al mismo tiempo.");

    if (g_rgeTerritories[territory_index][e_iGangID] == Gang_Data(Player_Gang(playerid))[e_iGangDbId])
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Este territorio ya pertenece a la banda.");

    new members;
    foreach(new i : Player)
    {
        if (IsPlayerInDynamicArea(i, g_rgeTerritories[territory_index][e_iArea]) && !Bit_Get(Player_Flags(i), PFLAG_INJURED) && Player_Gang(i) == Player_Gang(playerid))
            ++members;
    }

    if (members < 4)
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Se necesitan al menos 4 miembros de la banda para conquistar.");

    Gang_PlayerStartConquest(playerid, territory_index);

    Inventory_Hide(playerid);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 1000, 1);

    InventorySlot_Subtract(playerid, slot);
    return 1;
}

static Medicine_OnUse(playerid, slot)
{
    if (Player_Health(playerid) >= 100)
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Tienes la vida llena.");

    if(g_rgePlayerTempData[playerid][e_iMedicineUseTime] && gettime() - g_rgePlayerTempData[playerid][e_iMedicineUseTime] < (Player_VIP(playerid) >= 3 ? 3 : 10))
    {
        Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, va_return("Debes esperar %d segundos para consumir otro medicamento", ((Player_VIP(playerid) >= 3 ? 3 : 10) - (gettime() - g_rgePlayerTempData[playerid][e_iMedicineUseTime]))));
        return 1;
    }

    ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, false, true, true, false, 1000);
    PlayerPlaySound(playerid, SOUND_EAT);

    Notification_ShowBeatingText(playerid, 2000, 0xF7F7F7, 100, 255, "Has usado un medicamento (~g~+5~w~ de salud)");
    Player_SetHealth(playerid, Player_Health(playerid) + 5);
    g_rgePlayerTempData[playerid][e_iMedicineUseTime] = gettime();

    InventorySlot_Subtract(playerid, slot);
    return 1;
}

static Crack_OnUse(playerid, slot)
{
    if (Player_Armor(playerid) >= 100)
        return Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Tienes el chaleco lleno.");

    if(g_rgePlayerTempData[playerid][e_iCrackUseTime] && gettime() - g_rgePlayerTempData[playerid][e_iCrackUseTime] < (Player_VIP(playerid) >= 3 ? 3 : 10))
    {
        Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, va_return("Debes esperar %d segundos para consumir crack", ((Player_VIP(playerid) >= 3 ? 3 : 10) - (gettime() - g_rgePlayerTempData[playerid][e_iMedicineUseTime]))));
        return 1;
    }
    ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, false, true, true, false, 1000);
    PlayerPlaySound(playerid, SOUND_EAT);

    Notification_ShowBeatingText(playerid, 2000, 0xF7F7F7, 100, 255, "Has usado un gramo de crack (~g~+10~w~ de chaleco)");
    Player_SetArmor(playerid, Player_Armor(playerid) + 10);
    g_rgePlayerTempData[playerid][e_iCrackUseTime] = gettime();

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
        SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid) + Item_DrunkLevel(type));

    Player_AddHunger(playerid, Item_Hunger(type));
    Player_AddThirst(playerid, Item_Thirst(type));

    InventorySlot_Subtract(playerid, slot);
    return 1;
}

static RepairKit_OnUse(playerid, slot)
{
    new vehicleid = GetPlayerCameraTargetVehicle(playerid);
    if(vehicleid == INVALID_VEHICLE_ID)
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Necesitas estar viendo un vehículo");
        return 1;
    }

    if(Vehicle_Repairing(vehicleid))
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Este vehículo ya está siendo reparado");
        return 1;
    }

    if(Vehicle_GetEngineState(vehicleid) != VEHICLE_STATE_OFF || g_rgeVehicles[vehicleid][e_iVehicleTimers][VEHICLE_TIMER_TOGGLE_ENGINE])
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "El vehículo debe estar apagado");
        return 1;
    }

    new 
        Float:veh_x, Float:veh_y, Float:veh_z, Float:veh_ang;

    GetVehiclePos(vehicleid, veh_x, veh_y, veh_z);
    GetVehicleZAngle(vehicleid, veh_ang);

    new Float:model_x, Float:model_y, Float:model_z;
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, model_x, model_y, model_z);

    veh_x += (model_y / 2.0 + 0.5) * floatsin(-veh_ang, degrees);
    veh_y += (model_y / 2.0 + 0.5) * floatcos(-veh_ang, degrees);

    if(!IsPlayerInRangeOfPoint(playerid, 1.0, veh_x, veh_y, veh_z))
    {
        Notification_ShowBeatingText(playerid, 3000, 0xED2B2B, 100, 255, "Necesitas estar cerca del capó");
        return 1;
    }

    Player_SetPos(playerid, veh_x, veh_y, veh_z);
    SetPlayerFacingAngle(playerid, veh_ang);
    TogglePlayerControllable(playerid, false);
    ApplyAnimation(playerid, "CAR", "FIXN_CAR_LOOP", 4.1, 1, 0, 0, 1, 0);

    Inventory_Hide(playerid);
    InventorySlot_Subtract(playerid, slot);
    Vehicle_Repairing(vehicleid) = true;

    Notification_ShowBeatingText(playerid, 15000, 0xF29624, 100, 255, "Reparando vehículo...");
    g_rgiRepairSoundTimer[playerid] = SetTimerEx("GARAGE_VehicleRepairPlaySound", 1000, true, "i", playerid);
    g_rgiRepairFinishTimer[playerid] = SetTimerEx("REPAIRKIT_ActionFinished", 15000, false, "ii", playerid, vehicleid);

    return 1;
}

forward REPAIRKIT_ActionFinished(playerid, vehicleid);
public REPAIRKIT_ActionFinished(playerid, vehicleid)
{
    Timer_Kill(g_rgiRepairSoundTimer[playerid]);
    g_rgiRepairFinishTimer[playerid] = 0;

    Vehicle_SetHealth(vehicleid, 1000.0);
    Vehicle_Repairing(vehicleid) = false;
    TogglePlayerControllable(playerid, true);
    ApplyAnimation(playerid, "CAR", "FIXN_CAR_OUT", 4.1, 0, 0, 0, 0, 0);
    Notification_ShowBeatingText(playerid, 3000, 0x98D952, 100, 255, "Vehículo reparado");

    inline const AnimationDone()
    {
        ClearAnimations(playerid);
    }
    Timer_CreateCallback(using inline AnimationDone, 3000, 1);

    return 1;
}

static MediKit_OnUse(playerid, slot)
{
    new target = GetPlayerCameraTargetPlayer(playerid);
    if(!IsPlayerConnected(target))
    {
        Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, "Necesitas ver a un jugador para usar esto");
        return 1;
    }

    if(!Bit_Get(Player_Flags(target), PFLAG_INJURED))
    {
        Notification_ShowBeatingText(playerid, 2000, 0xED2B2B, 100, 255, va_return("%s no está herid%c", (Player_Sex(target) == SEX_MALE ? "Este jugador" : "Esta jugadora"), (Player_Sex(target) == SEX_MALE ? 'o' : 'a')));
        return 1;
    }

    Inventory_Hide(playerid);
    InventorySlot_Subtract(playerid, slot);

    new const time = (Player_VIP(playerid) >= 3 ? 5000 : 15000);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 1, 1, 1, 0, 1);
    Notification_ShowBeatingText(playerid, time, 0xED2B2B, 100, 255, va_return("Reanimando %s...", Player_Sex(target) == SEX_MALE ? "jugador" : "jugadora"));
    Notification_Show(target, va_return("Estás siendo reanimad%c por ~r~%s~w~.", (Player_Sex(target) == SEX_MALE ? 'o' : 'a'), Player_RPName(playerid)), time);

    inline const Due()
    {
        Player_SetHealth(target, (Player_VIP(playerid) >= 3 ? 100 : 25));
	    Player_Revive(target);
        ClearAnimations(playerid);
    }
    Timer_CreateCallback(using inline Due, time, 1);

    return 1;
}

public OnScriptInit()
{
    /* Medical */

    // Medic kit
    Item_Callback(ITEM_MEDIC_KIT) = __addressof(MediKit_OnUse);
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
    Item_Callback(ITEM_REPAIR_KIT) = __addressof(RepairKit_OnUse);
    Item_SetPreviewRot(ITEM_REPAIR_KIT, -196.000000, 0.000000, 6.000000, 1.000000);

    /* Other */

    // Phone
    Item_SetPreviewRot(ITEM_PHONE, -91.000000, 0.000000, 254.000000, 1.000000);
    Item_Callback(ITEM_PHONE) = __addressof(Phone_OnUse);

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
    Item_Thirst(ITEM_COFFEE) = -8.0;
    Item_Callback(ITEM_COFFEE) = __addressof(Food_OnUse);
    Item_SetPreviewRot(ITEM_COFFEE, -29.000000, 0.000000, 51.000000, 1.000000);

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

    // Flag
    Item_Callback(ITEM_FLAG) = __addressof(Flag_OnUse);
    Item_SetPreviewRot(ITEM_FLAG, -19.000000, 49.000000, -171.000000, 0.770000);

    #if defined ITEM_OnScriptInit
        return ITEM_OnScriptInit();
    #else
        return 1;
    #endif
}

#if defined _ALS_OnScriptInit
    #undef OnScriptInit
#else
    #define _ALS_OnScriptInit
#endif
#define OnScriptInit ITEM_OnScriptInit
#if defined ITEM_OnScriptInit
    forward ITEM_OnScriptInit();
#endif
